import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:io';

import '../../utils/constants/colors.dart';

class ProfilePicker extends StatefulWidget {
  final double size;
  final String? initialImageUrl; // Only network image URL
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
                  color: isHovering && widget.editable
                      ? widget.borderColor.withOpacity(0.8)
                      : widget.borderColor,
                  width: widget.borderWidth,
                ),
                image: _buildDecorationImage(),
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

  DecorationImage? _buildDecorationImage() {
    // Show user picked image first (local preview)
    if (_selectedImage != null && _selectedImage!.existsSync()) {
      return DecorationImage(
        image: FileImage(_selectedImage!),
        fit: BoxFit.cover,
      );
    }

    final url = widget.initialImageUrl;
    if (url == null) return null;

    return DecorationImage(
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );
  }

  Future<void> _pickImage() async {
    print('Pick image called');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      print('Selected image path: $path');

      File imageFile = File(path);
      if (!await imageFile.exists()) {
        print('Warning: picked file does not exist at path');
        return;
      }

      setState(() {
        _selectedImage = imageFile;
      });
      widget.onImageSelected?.call(imageFile);
    } else {
      print('No image selected.');
    }
  }
}
