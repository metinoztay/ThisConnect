import 'package:flutter/material.dart';
import 'package:thisconnect/screens/login_screen.dart';
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
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black))),
      home: const LoginScreen(),
    );
  }
}
