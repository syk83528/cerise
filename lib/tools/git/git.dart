import 'dart:convert';

import 'package:github/github.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Git {
  static late GitHub _git;
  static late String _owner;
  static late String _repo;
  static late bool _private;
  static late RepositorySlug _slug;
  static late String _currentRegistry;

  static const _registry = 'registry';
  static const _library = 'library';
  static String _getImagePath(String name) => '$_library/$name/image';
  static String _getVideoPath(String name) => '$_library/$name/video';

  static init({
    required String owner,
    required String repo,
    bool private = false,
    String? token,
  }) async {
    _owner = owner;
    _repo = repo;
    _private = private;
    _slug = RepositorySlug(_owner, _repo);
    await _initCache();

    final tk = token == null
        ? findAuthenticationFromEnvironment()
        : Authentication.withToken(token);
    _git = GitHub(auth: tk);

    await _initRepo();
  }

  static _initCache() async {
    final ins = await SharedPreferences.getInstance();
    final registry = ins.getString(_registry);

    if (registry == null) {
      _currentRegistry =
          'https://raw.githubusercontent.com/$_owner/$_repo/main/';
      return;
    }
    if (registry.contains('/$_owner/$_repo/')) {
      _currentRegistry = registry;
    } else {
      _currentRegistry =
          'https://raw.githubusercontent.com/$_owner/$_repo/main/';
      await ins.setString(_registry, _currentRegistry);
    }
  }

  static _initRepo() async {
    try {
      final info = await _git.repositories.getRepository(_slug);
      _private = info.isPrivate;
    } on NotFound {
      final repository = CreateRepository(_repo, private: _private);
      await _git.repositories.createRepository(repository);
    } catch (e) {
      throw e.toString();
    }

    await _createFile(path: '.cerise/.lockfile', content: '');
    await _createFile(path: 'library/.keepfile', content: '');
  }

  static _createFile({
    required String path,
    required String content,
    String? message,
  }) async {
    final file = CreateFile(
      path: path,
      message: message,
      content: base64Encode(utf8.encode(content)).toString(),
    );
    await _git.repositories.createFile(_slug, file);
  }

  /// Browse all file names included in `_library` floder
  static Future<List<String?>?> browseLibrary() async {
    final result = await _git.repositories.getContents(_slug, _library);
    return result.tree?.map((e) => e.name).toList();
  }

  /// Browse all file names included in `$_library/$name/image` floder
  static Future<List<String?>?> browserImages(String name) async {
    final result =
        await _git.repositories.getContents(_slug, _getImagePath(name));

    if (_private) {
      return result.tree?.map((e) => e.downloadUrl).toList();
    } else {
      return result.tree
          ?.map((e) => '$_currentRegistry${_getImagePath(name)}/${e.name}')
          .toList();
    }
  }

  /// Browse all file names included in `$_library/$name/video` floder
  static Future<List<String?>?> browserVideos(String name) async {
    final result =
        await _git.repositories.getContents(_slug, _getVideoPath(name));

    if (_private) {
      return result.tree?.map((e) => e.downloadUrl).toList();
    } else {
      return result.tree
          ?.map((e) => '$_currentRegistry${_getImagePath(name)}/${e.name}')
          .toList();
    }
  }

  static Future<void> switchRegistry(bool useGitHub) async {
    if (useGitHub) {
      _currentRegistry =
          'https://raw.githubusercontent.com/$_owner/$_repo/main/';
    } else {
      _currentRegistry = 'https://cdn.jsdelivr.net/gh/$_owner/$_repo/';
    }

    final ins = await SharedPreferences.getInstance();
    await ins.setString(_registry, _currentRegistry);
  }
}