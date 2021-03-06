import 'dart:convert';
import 'dart:typed_data';

import 'package:github/github.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Git {
  static late GitHub _git;
  static late String _owner;
  static late String _repo;
  static late bool _private;
  static late RepositorySlug _slug;
  static late String _currentRegistry;

  static bool get isPrivate => _private;

  static const _registry = 'registry';
  static const _library = 'library';
  static const _keepfile = '.keepfile';
  static String _getImagePath(String name) => '$_library/$name/image';
  static String _getVideoPath(String name) =>
      '$_library/${Uri.encodeComponent(name)}/video';

  static final _issueStoreSlug = RepositorySlug('ggdream', 'issue');
  static const _issueStoreNo = 1;

  static Future<void> init({
    String? owner,
    String? repo,
    bool private = false,
    String? token,
  }) async {
    final ins = await SharedPreferences.getInstance();
    if (owner == null) {
      final temp = ins.getString('owner');
      if (temp == null || temp.isEmpty) throw '请输入所属用户';
      _owner = temp;
    } else {
      _owner = owner;
      await ins.setString('owner', _owner);
    }
    if (repo == null) {
      final temp = ins.getString('repo');
      if (temp == null || temp.isEmpty) throw '请输入仓库名称';
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
      message: 'Create Lockfile',
    );
    await _createKeepFile('library');
  }

  static Future<void> _createKeepFile(String path) async {
    await _createFile(
      path: '$path/$_keepfile',
      content: '',
      message: 'Create Keepfile',
    );
  }

  static Future<ContentCreation> _createFile({
    required String path,
    required String content,
    String? message,
  }) async {
    final file = CreateFile(
      path: path,
      message: message ?? 'Create new file',
      content: base64Encode(utf8.encode(content)).toString(),
    );
    return await _git.repositories.createFile(_slug, file);
  }

  static Future<void> createIVKeepFile(String name) async {
    await _createKeepFile(_getImagePath(name));
    await _createKeepFile(_getVideoPath(name));
  }

  static Future<void> createFile({
    required String gitpath,
    required Uint8List data,
    String? message,
  }) async {
    final file = CreateFile(
      path: gitpath,
      message: message ?? 'Create new file',
      content: base64Encode(data).toString(),
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

    return result.tree?.map((e) {
      if (e.name == null || e.name == _keepfile) return null;

      if (_private) {
        return e.downloadUrl;
      }

      return '$_currentRegistry${_getImagePath(name)}/${e.name}';
    }).toList();
  }

  /// Browse all file names included in `$_library/$name/video` floder
  static Future<List<String?>?> browserVideos(String name) async {
    final result =
        await _git.repositories.getContents(_slug, _getVideoPath(name));

    return result.tree?.map((e) {
      final url = e.downloadUrl;
      if (url == null || e.name == null || e.name == _keepfile) return null;

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
    return [user.login, user.avatarUrl];
  }

  static Future<String?> getUsernameByAT(String token) async {
    final user = await GitHub(auth: Authentication.withToken(token)).users.getCurrentUser();
    return user.login;
  }

  static bool get registryIsGitHub =>
      _currentRegistry.contains('raw.githubusercontent.com');
  static bool get repoIsPrivate => _private;

  static Future<void> switchRegistry(bool isGitHub) async {
    if (isGitHub) {
      _currentRegistry =
          'https://raw.githubusercontent.com/$_owner/$_repo/main/';
    } else {
      _currentRegistry = 'https://cdn.jsdelivr.net/gh/$_owner/$_repo@latest/';
    }

    final ins = await SharedPreferences.getInstance();
    await ins.setString(_registry, _currentRegistry);
  }

  static String get repo => '$_owner/$_repo';

  static Future<bool> changeRepoVisual() async {
    try {
      await _git.repositories.editRepository(
        _slug,
        name: _repo,
        description: '',
        homepage: '',
        private: !_private,
        hasIssues: false,
        hasWiki: false,
        hasDownloads: false,
      );

      _private = !_private;
      if (_private) {
        await switchRegistry(true);
      }
    } on TypeError {
      _private = !_private;
      if (_private) {
        await switchRegistry(true);
      }
    } catch (e) {
      rethrow;
    }

    return _private;
  }

  static Future<void> createComment(String text) async {
    await _git.issues.createComment(_issueStoreSlug, _issueStoreNo, text);
  }

  static Future<List<Map<String, dynamic>>> getComments({
    required int page,
    required int number,
  }) async {
    final result = await _git.issues
        .listCommentsByIssue(_issueStoreSlug, _issueStoreNo, page, number)
        .toList();

    final List<Map<String, dynamic>> data = [];
    for (var item in result) {
      final temp = {
        'username': item.user?.name,
        'avatar': item.user?.avatarUrl,
        'datetime': item.createdAt?.millisecondsSinceEpoch,
        'message': item.body ?? '',
      };
      data.add(temp);
    }

    return data;
  }
}
