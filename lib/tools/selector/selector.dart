import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FileSelector {
  static Future<XFile?> pickFile({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    if (GetPlatform.isWeb) {
      return await openFile(
        acceptedTypeGroups: acceptedTypeGroups ?? [],
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
      );
    } else if (GetPlatform.isMobile) {
      throw UnimplementedError();
    }

    return await FileSelectorPlatform.instance.openFile(
      acceptedTypeGroups: acceptedTypeGroups,
      initialDirectory: initialDirectory,
      confirmButtonText: confirmButtonText,
    );
  }

  static Future<List<XFile>> pickFiles({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    if (GetPlatform.isWeb) {
      return await openFiles(
        acceptedTypeGroups: acceptedTypeGroups ?? [],
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
      );
    } else if (GetPlatform.isMobile) {
      throw UnimplementedError();
    }

    return await FileSelectorPlatform.instance.openFiles(
      acceptedTypeGroups: acceptedTypeGroups,
      initialDirectory: initialDirectory,
      confirmButtonText: confirmButtonText,
    );
  }

  static Future<List<XFile>> pickImages({
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    final acceptedTypeGroups = XTypeGroup(
      label: '图片(JPG,JPEG,PNG,WEBP)',
      extensions: ['jpg', 'jpeg', 'png', 'webp'],
    );

    if (GetPlatform.isWeb) {
      return await openFiles(
        acceptedTypeGroups: [acceptedTypeGroups],
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
      );
    } else if (GetPlatform.isMobile) {
      final picker = ImagePicker();
      final result = await picker.pickImage(source: ImageSource.gallery);
      if (result == null) {
        return [];
      } else {
        return [result];
      }
    }

    return await FileSelectorPlatform.instance.openFiles(
      acceptedTypeGroups: [acceptedTypeGroups],
      initialDirectory: initialDirectory,
      confirmButtonText: confirmButtonText,
    );
  }

  static Future<List<XFile>> pickVideos({
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    final acceptedTypeGroups = XTypeGroup(
      label: '视频(MP4，WEBM,FLV,AVI,MKV)',
      extensions: ['mp4', 'webm', 'flv', 'avi', 'mkv'],
    );

    if (GetPlatform.isWeb) {
      return await openFiles(
        acceptedTypeGroups: [acceptedTypeGroups],
        initialDirectory: initialDirectory,
        confirmButtonText: confirmButtonText,
      );
    } else if (GetPlatform.isMobile) {
      final picker = ImagePicker();
      final result = await picker.pickVideo(source: ImageSource.gallery);
      if (result == null) {
        return [];
      } else {
        return [result];
      }
    }

    return await FileSelectorPlatform.instance.openFiles(
      acceptedTypeGroups: [acceptedTypeGroups],
      initialDirectory: initialDirectory,
      confirmButtonText: confirmButtonText,
    );
  }

  static Future<String?> pickDirectoryPath({
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    return await FileSelectorPlatform.instance.getDirectoryPath(
      initialDirectory: initialDirectory,
      confirmButtonText: confirmButtonText,
    );
  }

  Future<void> saveFile({
    required String name,
    required Uint8List data,
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
    String? mimeType,
  }) async {
    final path = await FileSelectorPlatform.instance.getSavePath(
      suggestedName: name,
      acceptedTypeGroups: acceptedTypeGroups,
      initialDirectory: initialDirectory,
      confirmButtonText: confirmButtonText,
    );
    if (path == null) return;

    final file = XFile.fromData(data, mimeType: mimeType, name: name);
    await file.saveTo(path);
  }
}
