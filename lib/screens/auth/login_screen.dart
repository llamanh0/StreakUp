import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../config/theme.dart';
import 'register_screen.dart';
import '../../screens/home/main_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // We use controllers to get the text from the Input fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Controls whether to show the loading spinner on the button.
  bool _isLoading = false;

  // This function is called when the user clicks "Login".
  void _login() async {
    // 1. Show a loading spinner so the user knows something is happening.
    setState(() => _isLoading = true);

    // 2. Ask AuthService to try logging in.
    // listen: false because we just want to CALL a function, not listen to updates here.
    final error = await Provider.of<AuthService>(
      context,
      listen: false,
    ).login(_emailController.text, _passwordController.text);

    // 3. Login is done (success or fail), stop the spinner.
    setState(() => _isLoading = false);

    // 4. Check the result.
    if (error == null && mounted) {
      // Success! (error is null)
      // Go to the Main App Screen.
      // pushReplacement means user can't go "back" to login screen.
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainWrapper()));
    } else if (mounted) {
      // Failure! Show the error message at the bottom of the screen.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? "Login failed. Check your credentials."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 24),
              Text(
                "Welcome Back!",
                style: AppTheme.headlineLarge.copyWith(
                  color: AppTheme.primaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Login to continue your streak",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: "Login",
                onPressed: _login,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
