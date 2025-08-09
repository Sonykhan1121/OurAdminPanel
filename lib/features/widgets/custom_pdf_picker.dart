import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

import '../../utils/constants/colors.dart';

class CustomPDFPicker extends StatefulWidget {
  final String label;
  final Function(File?)? onFileSelected;
  final File? initialFile;
  final bool isRequired;
  final String? errorText;

  const CustomPDFPicker({
    Key? key,
    required this.label,
    this.onFileSelected,
    this.initialFile,
    this.isRequired = false,
    this.errorText,
  }) : super(key: key);

  @override
  State<CustomPDFPicker> createState() => _CustomPDFPickerState();
}

class _CustomPDFPickerState extends State<CustomPDFPicker> {
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _selectedFile = widget.initialFile;
  }

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
        widget.onFileSelected?.call(_selectedFile);
      }
    } catch (e) {
      print('Error picking PDF: $e');
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
    widget.onFileSelected?.call(null);
  }

  String _getFileName(File file) {
    return file.path.split('/').last;
  }

  String _getFileSize(File file) {
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    var i = (bytes.bitLength - 1) ~/ 10;
    return '${(bytes / (1 << (i * 10))).toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: DColors.black,
            ),
            children: widget.isRequired
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: DColors.error),
              ),
            ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: DColors.white,
            border: Border.all(
              color: widget.errorText != null
                  ? DColors.error
                  : DColors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _selectedFile != null
              ? Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: DColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    FluentIcons.pdf,
                    color: DColors.error,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getFileName(_selectedFile!),
                        style: TextStyle(
                          color: DColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getFileSize(_selectedFile!),
                        style: TextStyle(
                          color: DColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    FluentIcons.delete,
                    color: DColors.textSecondary,
                    size: 16,
                  ),
                  onPressed: _removeFile,
                ),
              ],
            ),
          )
              : GestureDetector(
            onTap: _pickPDF,
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.pdf,
                    size: 32,
                    color: DColors.textSecondary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Click to select PDF file',
                    style: TextStyle(
                      color: DColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Supported format: PDF',
                    style: TextStyle(
                      color: DColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: DColors.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}