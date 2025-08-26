import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();
  static PermissionService? _instance;
  static PermissionService get instance => _instance ??= PermissionService._();

  /// Storage permission isteği
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await _getAndroidVersion() >= 33) {
        // Android 13+ için
        final photos = await Permission.photos.request();
        final videos = await Permission.videos.request();
        return photos.isGranted && videos.isGranted;
      } else if (await _getAndroidVersion() >= 30) {
        // Android 11-12 için
        final storage = await Permission.manageExternalStorage.request();
        return storage.isGranted;
      } else {
        // Android 10 ve altı için
        final storage = await Permission.storage.request();
        return storage.isGranted;
      }
    } else if (Platform.isIOS) {
      final photos = await Permission.photos.request();
      return photos.isGranted;
    }
    return false;
  }

  /// Kamera permission isteği
  Future<bool> requestCameraPermission() async {
    final camera = await Permission.camera.request();
    return camera.isGranted;
  }

  /// Mikrofon permission isteği
  Future<bool> requestMicrophonePermission() async {
    final microphone = await Permission.microphone.request();
    return microphone.isGranted;
  }

  /// Konum permission isteği
  Future<bool> requestLocationPermission() async {
    final location = await Permission.locationWhenInUse.request();
    return location.isGranted;
  }

  /// Tüm gerekli izinleri kontrol et
  Future<Map<String, bool>> checkAllPermissions() async => {
    'storage': await _hasStoragePermission(),
    'camera': await Permission.camera.isGranted,
    'photos': await Permission.photos.isGranted,
    'microphone': await Permission.microphone.isGranted,
    'location': await Permission.locationWhenInUse.isGranted,
  };

  /// Storage permission kontrolü
  Future<bool> _hasStoragePermission() async {
    if (Platform.isAndroid) {
      if (await _getAndroidVersion() >= 33) {
        return await Permission.photos.isGranted && await Permission.videos.isGranted;
      } else if (await _getAndroidVersion() >= 30) {
        return Permission.manageExternalStorage.isGranted;
      } else {
        return Permission.storage.isGranted;
      }
    } else if (Platform.isIOS) {
      return Permission.photos.isGranted;
    }
    return false;
  }

  /// Android version kontrolü
  Future<int> _getAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await Permission.photos.status;
      // Bu basit bir kontrol, gerçek version için device_info_plus kullanın
      return 30; // Varsayılan
    }
    return 0;
  }

  /// Permission reddedildiğinde settings'e yönlendirme
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Permission dialog göster
  static Future<bool> showPermissionDialog(
    BuildContext context,
    String title,
    String message,
  ) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('İzin Ver'),
            ),
          ],
        ),
      ) ??
      false;
}
