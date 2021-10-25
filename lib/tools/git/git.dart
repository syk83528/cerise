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
  static String _getVideoPath(String name) =>
      '$_library/${Uri.encodeComponent(name)}/video';

  static Future<void> init({
    String? owner,
    String? repo,
    bool private = false,
    String? token,
  }) async {
    final ins = await SharedPreferences.getInstance();
    if (owner == null) {
      final temp = ins.getString('owner');
      if (temp == null || temp.isEmpty) throw 'Please entry owner';
      _owner = temp;
    } else {
      _owner = owner;
      await ins.setString('owner', _owner);
    }
    if (repo == null) {
      final temp = ins.getString('repo');
      if (temp == null || temp.isEmpty) throw 'Please entry repo';
      _repo = temp;
    } else {
      _repo = repo;
      await ins.setString('repo', _repo);
    }

    _private = private;
    _slug = RepositorySlug(_owner, _repo);
    await _initCache();

    if (token == null) {
      token = ins.getString('token');
    } else {
      await ins.setString('token', token);
    }

    final tk = token == null
        ? findAuthenticationFromEnvironment()
        : Authentication.withToken(token);
    _git = GitHub(auth: tk);

    await _initRepo();
  }

  static _initCache() async {
    final ins = await SharedPreferences.getInstance();
    final registry = ins.getString(_registry);

    if (registry == null || registry.isEmpty) {
      _currentRegistry = 'https://cdn.jsdelivr.net/gh/$_owner/$_repo@latest/';
      return;
    }
    if (registry.contains('/$_owner/$_repo')) {
      _currentRegistry = registry;
    } else {
      _currentRegistry = 'https://cdn.jsdelivr.net/gh/$_owner/$_repo@latest/';
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
    } finally {
      if (_private) {
        await switchRegistry(true);
      }
    }

    await _createFile(
      path: '.cerise/.lockfile',
      content: DateTime.now().millisecondsSinceEpoch.toString(),
      message: 'lockfile',
    );
    await _createFile(
      path: 'library/.keepfile',
      content: '',
      message: 'keepfile',
    );
  }

  static _createFile({
    required String path,
    required String content,
    String? message,
  }) async {
    final file = CreateFile(
      path: path,
      message: message ?? 'Create new file',
      content: base64Encode(utf8.encode(content)).toString(),
    );
    await _git.repositories.createFile(_slug, file);
  }

  /// Browse all file names included in `_library` floder
  static Future<List<String?>?> browseLibrary() async {
    final result = await _git.repositories.getContents(_slug, _library);
    return result.tree?.map((e) {
      if (e.name != '.keepfile') {
        return e.name;
      }
    }).toList();
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

    return result.tree?.map((e) {
      final url = e.downloadUrl;
      if (url == null || e.name == null) return null;

      if (_private) {
        final temp =
            'https://raw.githubusercontent.com/$_owner/$_repo/main/${_getVideoPath(name)}/${Uri.encodeComponent(e.name!)}';
        return '$temp?${url.split('?').last}';
      }

      return '$_currentRegistry${_getVideoPath(name)}/${Uri.encodeComponent(e.name!)}';
    }).toList();
  }

  static Future<List<String?>> getProfile() async {
    final user = await _git.users.getCurrentUser();
    return [user.name, user.avatarUrl];
  }

  static bool get registryIsGitHub =>
      _currentRegistry.contains('raw.githubusercontent.com');

  static Future<void> switchRegistry(bool isGitHub) async {
    if (isGitHub == registryIsGitHub) return;

    if (isGitHub) {
      _currentRegistry =
          'https://raw.githubusercontent.com/$_owner/$_repo/main/';
    } else {
      _currentRegistry = 'https://cdn.jsdelivr.net/gh/$_owner/$_repo@latest/';
    }

    final ins = await SharedPreferences.getInstance();
    await ins.setString(_registry, _currentRegistry);
  }
}
