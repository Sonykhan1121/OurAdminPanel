import 'package:fluent_ui/fluent_ui.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return ContentDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          // Cancel button (outline style)
          Button(
            style: ButtonStyle(
              backgroundColor: ButtonState.all(Colors.transparent),
              shape: ButtonState.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              foregroundColor: ButtonState.all(Colors.red),
            ),
            child: Text(cancelText),
            onPressed: () => Navigator.pop(context),
          ),

          // Confirm button (filled red)
          FilledButton(
            style: ButtonStyle(
              backgroundColor: ButtonState.all(Colors.red),
              foregroundColor: ButtonState.all(Colors.white),
              shape: ButtonState.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red, width: 2),                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            child: Text(confirmText),
            onPressed: () {
              Navigator.pop(context);

              onConfirm();
            },
          ),
        ],
      );
    },
  );
}
