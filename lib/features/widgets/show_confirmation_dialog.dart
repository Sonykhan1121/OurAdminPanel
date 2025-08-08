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
          Button(
            child: Text(cancelText),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
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
