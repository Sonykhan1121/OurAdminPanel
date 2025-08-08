import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class DocumentPicker extends StatefulWidget {
  final String label;
  final List<String> allowedExtensions;
  final ValueChanged<File>? onFileSelected;
  final Widget? customPreview;
  final bool showClearButton;
  final double maxHeight;

  const DocumentPicker({
    super.key,
    required this.label,
    this.allowedExtensions = const ['pdf', 'doc', 'docx'],
    this.onFileSelected,
    this.customPreview,
    this.showClearButton = true,
    this.maxHeight = 200,
  });

  @override
  State<DocumentPicker> createState() => _DocumentPickerState();
}

class _DocumentPickerState extends State<DocumentPicker> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: FluentTheme.of(context).typography.bodyStrong,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[30]),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              if (_selectedFile != null) _buildPreview(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Button(
                        child: const Text('Select Document'),
                        onPressed: _pickDocument,
                      ),
                    ),
                    if (_selectedFile != null && widget.showClearButton)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          icon: const Icon(FluentIcons.delete),
                          onPressed: _clearSelection,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    if (widget.customPreview != null) return widget.customPreview!;

    return Container(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(FluentIcons.document, size: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedFile!.path.split('/').last,
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                Text(
                  '${(_selectedFile!.lengthSync() / 1024).toStringAsFixed(2)} KB',
                  style: FluentTheme.of(context).typography.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDocument() async {
    // Implement document picking logic
  }

  void _clearSelection() {
    setState(() => _selectedFile = null);
  }
}