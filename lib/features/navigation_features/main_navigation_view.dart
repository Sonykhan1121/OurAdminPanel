import 'dart:developer';

import 'package:admin_panel/features/experieces_features/views/experience_page.dart';
import 'package:admin_panel/features/intro_features/views/intro_page.dart';
import 'package:admin_panel/features/projects_features/views/project_page.dart';
import 'package:admin_panel/features/service_features/views/service_page.dart';
import 'package:admin_panel/features/widgets/show_confirmation_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/service_locator.dart';
import '../../route/app_route_names.dart';
import '../../utils/constants/colors.dart';
import '../admin_local_data_features/admin_local_data.dart';
import '../auth_features/view_models/auth_view_model.dart';
import '../home_features/home_page.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _selectedIndex = 0;
  final authProvider = sl<AuthViewModel>();

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: Icon(FluentIcons.home, color:DColors.black),
      title:  Text("Home", style: TextStyle(color: DColors.secondary,fontSize: 16)),
      body: const HomePage(),
    ),
    PaneItem(
      icon: Icon(FluentIcons.profile_search, color: Colors.black),
      title:  Text("Intro Page",style: TextStyle(color: Colors.red,fontSize: 16)),
      body: const IntroPage(),
    ),
    PaneItem(
      icon: Icon(FluentIcons.service_activity, color: Colors.black),
      title:  Text("Services",style: TextStyle(color: Colors.red,fontSize: 16)),
      body: const ServicePage(),
    ),
    PaneItem(
      icon: Icon(FluentIcons.calendar_year, color: Colors.black),
      title:  Text("Experiences",style: TextStyle(color: Colors.red,fontSize: 16)),
      body: const ExperiencePage(),
    ),
    PaneItem(
      icon: Icon(FluentIcons.project_collection, color: Colors.black),
      title:  Text("Projects",style: TextStyle(color: Colors.red,fontSize: 16)),
      body: const ProjectPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.open,
        // Always show on left
        items: _items,
        footerItems: [
          PaneItem(
            tileColor: WidgetStatePropertyAll(DColors.secondary.withOpacity(0.2)),
            icon: Icon(FluentIcons.sign_out, color: Colors.red),
            title:  Text("Logout",style: TextStyle(color: DColors.secondary,fontSize: 16,),textAlign: TextAlign.center,),
            body:  SizedBox(), // Not used, since it's a button
            onTap: () {
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showConfirmationDialog(
      context: context,
      title: "Logout",
      content: 'Are you sure you want to log out?',
      onConfirm: () {
        authProvider.logout();
        AdminLocalData.resetAdmin();
        context.go(AppRouteNames.login_path);
      },
    );
  }
}
