import 'package:fluent_ui/fluent_ui.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Welcome to the Admin Panel'),
        commandBar: CommandBar(
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.info),
              label: const Text('Learn More'), onPressed: () {  },
            ),
          ],
        ),
      ),
      content: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'This is the introduction page for the admin panel. '
            'Here you can find information about how to use the application.',
            style: FluentTheme.of(context).typography.body,
          ),
        ),
      ),
    );
  }
}
