import 'package:flutter/material.dart';
import 'package:thisconnect/screens/chat_screen.dart';
import 'package:thisconnect/screens/home_screen.dart';
import 'package:thisconnect/screens/login_screen.dart';
import 'package:thisconnect/screens/main_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const ThisConnect());

class ThisConnect extends StatelessWidget {
  const ThisConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 20,
              iconTheme: IconThemeData(color: Colors.black))),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
