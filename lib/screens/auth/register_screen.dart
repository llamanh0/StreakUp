import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../config/theme.dart';
import '../../screens/home/main_wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _register() async {
    setState(() => _isLoading = true);

    final error = await Provider.of<AuthService>(
      context,
      listen: false,
    ).register(_emailController.text, _passwordController.text);

    setState(() => _isLoading = false);

    if (error == null && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainWrapper()),
        (route) => false,
      );
    } else if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error ?? "Registration failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Create Account",
                style: AppTheme.headlineLarge.copyWith(
                  color: AppTheme.primaryLight,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join StreakUp and boost your productivity",
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
                text: "Sign Up",
                onPressed: _register,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
