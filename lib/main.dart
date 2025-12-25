import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'config/theme.dart';
import 'providers/timer_provider.dart';
import 'providers/task_provider.dart';
import 'providers/group_provider.dart';
import 'services/auth_service.dart';
import 'screens/auth/login_screen.dart';
import 'providers/theme_provider.dart';
import 'screens/home/main_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Entry point of the application.
/// Initializes bindings, Firebase, and runs the root [MyApp] widget.
void main() async {
  // Ensure that plugin services are initialized before `runApp` is called.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Log errors strictly in debug mode to avoid exposing sensitive info in prod.
    debugPrint("Firebase Initialization Error: $e");
  }

  runApp(const MyApp());
}

/// The Root Widget of the application.
/// Sets up the [MultiProvider] for state management and global theme configuration.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // ProxyProviders depend on AuthService
        ChangeNotifierProxyProvider<AuthService, TimerProvider>(
          create: (_) => TimerProvider(),
          update: (_, auth, timer) => timer!..update(auth),
        ),
        ChangeNotifierProxyProvider<AuthService, TaskProvider>(
          create: (_) => TaskProvider(),
          update: (_, auth, task) => task!..update(auth),
        ),
        ChangeNotifierProxyProvider<AuthService, GroupProvider>(
          create: (_) => GroupProvider(),
          update: (_, auth, group) => group!..update(auth),
        ),
      ],
      child: Consumer2<ThemeProvider, AuthService>(
        builder: (context, themeProvider, authService, child) {
          return MaterialApp(
            title: 'StreakUp',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: authService.isLoggedIn
                ? const MainWrapper()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
