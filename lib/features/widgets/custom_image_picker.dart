import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constants/colors.dart';

class CustomImagePicker extends StatefulWidget {
  final String label;
  final Function(File?)? onImageSelected;
  final File? initialImage;
  final bool isRequired;
  final String? errorText;

  const CustomImagePicker({
    Key? key,
    required this.label,
    this.onImageSelected,
    this.initialImage,
    this.isRequired = false,
    this.errorText,
  }) : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        widget.onImageSelected?.call(_selectedImage);
      }
    } catch (e) {
      // Handle error
      print('Error picking image: $e');
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected?.call(null);
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
                  : DColors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _selectedImage != null
              ? Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(
                      FluentIcons.delete,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: _removeImage,
                  ),
                ),
              ),
            ],
          )
              : Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FluentIcons.photo,
                  size: 32,
                  color: DColors.black,
                ),
                const SizedBox(height: 8),
                Text(
                  'Click to select image',
                  style: TextStyle(
                    color: DColors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FluentIcons.photo2, size: 16),
                          const SizedBox(width: 8),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Button(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FluentIcons.camera, size: 16),
                          const SizedBox(width: 8),
                          Text('Camera'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: DColors.black,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
