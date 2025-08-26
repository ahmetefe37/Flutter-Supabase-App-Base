import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/services/file_service.dart';

class FilePickerWidget extends StatefulWidget {
  const FilePickerWidget({
    super.key,
    this.onFileSelected,
    this.title,
    this.showCamera = true,
    this.showGallery = true,
    this.showFiles = true,
  });
  final Function(File file)? onFileSelected;
  final String? title;
  final bool showCamera;
  final bool showGallery;
  final bool showFiles;

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  File? selectedFile;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (widget.title != null) Text(widget.title!, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 16),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.showCamera)
            _buildPickerButton(icon: Icons.camera_alt, label: 'Kamera', onTap: _pickFromCamera),
          if (widget.showGallery)
            _buildPickerButton(icon: Icons.photo_library, label: 'Galeri', onTap: _pickFromGallery),
          if (widget.showFiles)
            _buildPickerButton(icon: Icons.folder, label: 'Dosyalar', onTap: _pickFile),
        ],
      ),

      if (selectedFile != null) ...[const SizedBox(height: 16), _buildFilePreview()],

      if (isLoading) const CircularProgressIndicator(),
    ],
  );

  Widget _buildPickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [Icon(icon, size: 32), const SizedBox(height: 4), Text(label)]),
    ),
  );

  Widget _buildFilePreview() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        if (FileService.instance.isImageFile(selectedFile!.path))
          Image.file(selectedFile!, width: 60, height: 60, fit: BoxFit.cover)
        else
          const Icon(Icons.insert_drive_file, size: 60),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedFile!.path.split('/').last,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(FileService.instance.formatFileSize(selectedFile!.lengthSync())),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              selectedFile = null;
            });
          },
        ),
      ],
    ),
  );

  Future<void> _pickFromCamera() async {
    setState(() => isLoading = true);
    try {
      final file = await FileService.instance.pickImageFromCamera();
      if (file != null) {
        setState(() => selectedFile = file);
        widget.onFileSelected?.call(file);
      }
    } catch (e) {
      _showError('Kamera hatası: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() => isLoading = true);
    try {
      final file = await FileService.instance.pickImageFromGallery();
      if (file != null) {
        setState(() => selectedFile = file);
        widget.onFileSelected?.call(file);
      }
    } catch (e) {
      _showError('Galeri hatası: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _pickFile() async {
    setState(() => isLoading = true);
    try {
      final file = await FileService.instance.pickFile();
      if (file != null) {
        setState(() => selectedFile = file);
        widget.onFileSelected?.call(file);
      }
    } catch (e) {
      _showError('Dosya seçme hatası: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
