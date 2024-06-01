import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thisconnect/screens/home_screen.dart';
import 'package:thisconnect/screens/main_screen.dart';
import 'package:thisconnect/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool isIntroducted = false;

  void checkIsIntroducted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isIntroducted = prefs.getBool('isIntroducted') ?? false;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    checkIsIntroducted();

    Future.delayed(const Duration(seconds: 3), () {
      isIntroducted
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainScreen()))
          : Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const OnBoardingScreen(),
            ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.connect_without_contact_rounded,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "This Connect!",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 32),
              )
            ],
          )),
    );
  }
}
