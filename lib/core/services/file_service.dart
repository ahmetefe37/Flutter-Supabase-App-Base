import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'permission_service.dart';

class FileService {
  FileService._();
  static FileService? _instance;
  static FileService get instance => _instance ??= FileService._();

  final ImagePicker _imagePicker = ImagePicker();

  /// Galeri'den fotoğraf seç
  Future<File?> pickImageFromGallery() async {
    if (!await PermissionService.instance.requestStoragePermission()) {
      throw Exception('Galeri erişim izni gerekli');
    }

    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    return image != null ? File(image.path) : null;
  }

  /// Kamera'dan fotoğraf çek
  Future<File?> pickImageFromCamera() async {
    if (!await PermissionService.instance.requestCameraPermission()) {
      throw Exception('Kamera erişim izni gerekli');
    }

    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    return image != null ? File(image.path) : null;
  }

  /// Dosya seç (herhangi bir tip)
  Future<File?> pickFile({List<String>? allowedExtensions, FileType type = FileType.any}) async {
    if (!await PermissionService.instance.requestStoragePermission()) {
      throw Exception('Dosya erişim izni gerekli');
    }

    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }

    return null;
  }

  /// Birden fazla dosya seç
  Future<List<File>> pickMultipleFiles({
    List<String>? allowedExtensions,
    FileType type = FileType.any,
  }) async {
    if (!await PermissionService.instance.requestStoragePermission()) {
      throw Exception('Dosya erişim izni gerekli');
    }

    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
      allowMultiple: true,
    );

    if (result != null) {
      return result.paths.where((path) => path != null).map((path) => File(path!)).toList();
    }

    return [];
  }

  /// Dosyayı app directory'e kaydet
  Future<File> saveFileToAppDirectory(File file, {String? fileName}) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName_ = fileName ?? path.basename(file.path);
    final savedFile = File(path.join(appDir.path, fileName_));

    return file.copy(savedFile.path);
  }

  /// Bytes'ı dosya olarak kaydet
  Future<File> saveBytesToFile(Uint8List bytes, String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File(path.join(appDir.path, fileName));

    return file.writeAsBytes(bytes);
  }

  /// Dosya boyutunu formatla
  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Dosya türünü kontrol et
  bool isImageFile(String filePath) {
    const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    final extension = path.extension(filePath).toLowerCase();
    return imageExtensions.contains(extension);
  }

  bool isVideoFile(String filePath) {
    const videoExtensions = ['.mp4', '.avi', '.mov', '.wmv', '.flv', '.webm'];
    final extension = path.extension(filePath).toLowerCase();
    return videoExtensions.contains(extension);
  }

  /// App directories
  Future<Directory> getAppDocumentsDirectory() async => getApplicationDocumentsDirectory();

  Future<Directory> getAppCacheDirectory() async => getTemporaryDirectory();

  Future<Directory?> getExternalStorageDirectory() async => getExternalStorageDirectory();
}
