import 'package:fluent_ui/fluent_ui.dart';

void showInfoBar(BuildContext context, {
  required String title,
  String? message,
  InfoBarSeverity severity = InfoBarSeverity.info,
}) {
  displayInfoBar(
    context,
    builder: (context, close) {
      return InfoBar(
        title: Text(title),
        content: message != null ? Text(message) : null,
        severity: severity,
        isLong: true, // allows multi-line
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
      );
    },
  );
}
