// Global Text Button Widget
import 'package:fluent_ui/fluent_ui.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: ButtonState.all(Colors.transparent),
        padding: ButtonState.all(EdgeInsets.zero),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
