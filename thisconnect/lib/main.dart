import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const ThisConnect());

class ThisConnect extends StatelessWidget {
  const ThisConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
