import 'package:fluent_ui/fluent_ui.dart';

import '../../utils/constants/colors.dart';

class CustomPageHeader extends StatelessWidget {
   final String text;
  const CustomPageHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: Text(
        text,
        style: TextStyle(color: DColors.secondary, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
