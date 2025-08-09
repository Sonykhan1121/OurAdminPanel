// 2. Long Text Writing Input Field
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';

import '../../utils/constants/colors.dart';

class CustomLongTextInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? value;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? errorText;
  final int maxLines;
  final int? maxLength;
  final bool editable;

  const CustomLongTextInput({
    Key? key,
    required this.label,
    required this.placeholder,
    this.value,
    this.onChanged,
    this.isRequired = false,
    this.errorText,
    this.maxLines = 6,
    this.maxLength,
    required this.editable,
  }) : super(key: key);

  @override
  State<CustomLongTextInput> createState() => _CustomLongTextInputState();
}

class _CustomLongTextInputState extends State<CustomLongTextInput> {
  late TextEditingController _controller;
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _currentLength = _controller.text.length;
    _controller.addListener(() {
      setState(() {
        _currentLength = _controller.text.length;
      });
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            if (widget.maxLength != null)
              Text(
                '$_currentLength/${widget.maxLength}',
                style: TextStyle(
                  color: _currentLength > widget.maxLength!
                      ? DColors.error
                      : DColors.black,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: DColors.white,
            border: Border.all(
              color: widget.errorText != null
                  ? DColors.error
                  : DColors.black.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextBox(
            enabled: widget.editable,
            controller: _controller,
            placeholder: widget.placeholder,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            style: TextStyle(
              color: DColors.black,
              fontSize: 14,
            ),
            placeholderStyle: TextStyle(
              color: DColors.black,
              fontSize: 14,
            ),
            decoration:WidgetStatePropertyAll(
              BoxDecoration(
                color: DColors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            )
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