// Global Custom Input Field Widget
import 'package:fluent_ui/fluent_ui.dart';

import '../../utils/constants/colors.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final bool isRequired;
  final bool editable;

  const CustomInputField({
    super.key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.isRequired = true,
    required this.editable
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label + (isRequired ? ' *' : ''),
          style:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormBox(
          enabled: editable,
          controller: controller,
          placeholder: placeholder,
          obscureText: isPassword,
          keyboardType: keyboardType,
          validator: validator,
          prefix: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: prefixIcon,
          )
              : null,
          decoration: WidgetStateProperty.all(
            BoxDecoration(
              color: FluentTheme.of(context).brightness == Brightness.dark
                  ? DColors.darkGrey
                  : DColors.white,
              border: Border.all(color: DColors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          style: TextStyle(
            color: FluentTheme.of(context).brightness == Brightness.dark
                ? DColors.white
                : DColors.black,
          ),

        ),
      ],
    );
  }
}