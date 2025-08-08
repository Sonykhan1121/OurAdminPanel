import 'package:fluent_ui/fluent_ui.dart';

class FilledRedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const FilledRedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 4.0,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: ButtonState.resolveWith((states) {
          if (states.isDisabled) return Colors.grey[30];
          return Colors.red;
        }),
        shape: ButtonState.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )),
        padding: ButtonState.all(padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
      child: isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: ProgressRing(strokeWidth: 2),
      )
          : Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}