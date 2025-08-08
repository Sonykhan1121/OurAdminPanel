// Login Page
import 'dart:ui';

import 'package:admin_panel/features/admin_local_data_features/admin_local_data.dart';
import 'package:admin_panel/features/auth_features/view_models/auth_view_model.dart';
import 'package:admin_panel/features/widgets/show_info_bar.dart';
import 'package:admin_panel/route/app_route_names.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/service_locator.dart';
import '../../../utils/constants/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authProvider = sl<AuthViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await authProvider.login(_emailController.text.toString(), _passwordController.text.toString());

      setState(() => _isLoading = false);
     if(authProvider.currentUser!=null)
       {
         print('loign: ${authProvider.currentUser.toString()}');
         AdminLocalData.adminRemember = true;
         AdminLocalData.user = authProvider.currentUser;
         AdminLocalData.saveAdminData();
         context.go(AppRouteNames.mainNavigationView_path);
       }
     else
       {
         showInfoBar(context, title: authProvider.errorMessage ?? "Login failed");
       }


    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: DColors.secondary,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  label: 'Email',
                  placeholder: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(FluentIcons.mail, size: 18),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: const Icon(FluentIcons.lock, size: 18),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: 'Forgot Password?',
                    onPressed: () => context.pushNamed(AppRouteNames.forget_password),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Sign In',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    CustomTextButton(
                      text: 'Sign Up',
                      onPressed: () => context.goNamed(AppRouteNames.signUp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
