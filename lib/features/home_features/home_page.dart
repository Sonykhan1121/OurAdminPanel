import 'package:fluent_ui/fluent_ui.dart';

import '../../utils/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header:  PageHeader(
        title: Text('Portfolio Admin Panel',style: TextStyle(color: DColors.secondary,fontSize: 20),textAlign: TextAlign.center,),
      ),
      content: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                FluentIcons.admin,
                size: 120,
                color: DColors.secondary,
              ),
              const SizedBox(height: 40),
              Text(
                'PORTFOLIO CONTROL CENTER',
                style: FluentTheme.of(context).typography.title?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: FluentTheme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _InfoTile(
                      icon: FluentIcons.set_action,
                      text: "This panel manages all portfolio content",
                    ),
                    const SizedBox(height: 16),
                    _InfoTile(
                      icon: FluentIcons.cloud_upload,
                      text: "Data uploaded here will appear on the portfolio website",
                    ),
                    const SizedBox(height: 16),
                    _InfoTile(
                      icon: FluentIcons.lock_solid,
                      text: "Restricted access - Admin privileges required",
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20,color: DColors.secondary,),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: FluentTheme.of(context).typography.body,
          ),
        ),
      ],
    );
  }
}