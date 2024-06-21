import 'package:flutter/material.dart';
import 'package:thisconnect/screens/chat_screen.dart';
import 'package:thisconnect/screens/help_screen.dart';
import 'package:thisconnect/screens/home_screen.dart';
import 'package:thisconnect/screens/login_screen.dart';
import 'package:thisconnect/screens/main_screen.dart';
import 'package:thisconnect/screens/messages_screen.dart';
import 'package:thisconnect/screens/onboarding_screen.dart';
import 'package:thisconnect/screens/profile_menu_screen.dart';
import 'package:thisconnect/screens/qr_list_screen.dart';
import 'package:thisconnect/screens/qr_scanner_screen.dart';
import 'package:thisconnect/screens/signalRdeneme.dart';
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
              titleSpacing: 1,
              actionsIconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.blue,
              elevation: 20,
              iconTheme: IconThemeData(color: Colors.white))),
      //home: const SplashScreen(),
      home: SignalRScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/help': (context) => const HelpScreen(),
        '/main': (context) => const MainScreen(),
        '/chat': (context) => const ChatScreen(),
        '/home': (context) => const HomeScreen(),
        '/splash': (context) => const SplashScreen(),
        '/intro': (context) => const OnBoardingScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/profile': (context) => const ProfileMenuScreen(),
        '/qrList': (context) => const QRListScreen(),
        '/qrScanner': (context) => const QRScannerScreen(),
      },
    );
  }
}
