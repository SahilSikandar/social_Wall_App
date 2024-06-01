import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_wall_app/auth/auth_page.dart';
import 'package:social_wall_app/auth/login_or_signup.dart';
import 'package:social_wall_app/firebase_options.dart';
import 'package:social_wall_app/screens/home_Screen.dart';
import 'package:social_wall_app/screens/login_page.dart';
import 'package:social_wall_app/screens/profile_screen.dart';
import 'package:social_wall_app/screens/user_screen.dart';
import 'package:social_wall_app/themes/dark_theme.dart';
import 'package:social_wall_app/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_or_signup': (context) => const LoginOrSignup(),
        //'/login_page': (context) => LoginScreen(),
        '/profile_screen': (context) => ProfileScreen(),
        '/user_screen': (context) => const UserScreen(),
        '/home_Screen': (context) => HomeScreen()
      },
      home: const AuthPage(),
    );
  }
}
