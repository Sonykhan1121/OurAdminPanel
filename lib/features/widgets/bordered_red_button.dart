import 'package:fluent_ui/fluent_ui.dart';

class BorderedRedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;

  const BorderedRedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 4.0,
    this.borderWidth = 1.5,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: ButtonState.all(Colors.transparent),
        shape: ButtonState.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: Colors.red,
            width: borderWidth,
          ),
        )),
        padding: ButtonState.all(padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}