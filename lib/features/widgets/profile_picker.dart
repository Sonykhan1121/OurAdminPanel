import 'package:fluent_ui/fluent_ui.dart';
import 'dart:io';

import '../../utils/constants/colors.dart';

class ProfilePicker extends StatefulWidget {
  final double size;
  final String? initialImageUrl;
  final ValueChanged<File?>? onImageSelected;
  final Color borderColor;
  final double borderWidth;
  final bool editable;

  ProfilePicker({
    super.key,
    this.size = 100,
    this.initialImageUrl,
    this.onImageSelected,
    this.borderColor = const Color(0xFF2196F3),
    this.borderWidth = 3,
    this.editable = true,
  });

  @override
  State<ProfilePicker> createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  File? _selectedImage;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: widget.editable ? _pickImage : null,
      builder: (context, states) {
        final isHovering = states.isHovering;
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isHovering && widget.editable
                          ? DColors.secondary.withOpacity(0.8)
                          : DColors.secondary,
                  width: widget.borderWidth,
                ),
                image: _buildImageDecoration(),
              ),
            ),
            if (isHovering && widget.editable)
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FluentIcons.camera,
                  color: Colors.white,
                  size: 32,
                ),
              ),
          ],
        );
      },
    );
  }

  DecorationImage? _buildImageDecoration() {
    if (_selectedImage != null) {
      return DecorationImage(
        image: FileImage(_selectedImage!),
        fit: BoxFit.cover,
      );
    } else if (widget.initialImageUrl != null) {
      return DecorationImage(
        image: AssetImage(widget.initialImageUrl!),
        fit: BoxFit.cover,
      );
    }
    return null;
  }

  Future<void> _pickImage() async {
    print('Pick image called');
  }
}
