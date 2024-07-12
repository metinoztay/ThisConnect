import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thisconnect/models/qr_model.dart';
import 'package:thisconnect/models/user_model.dart';
import 'package:thisconnect/screens/chat_screen.dart';
import 'package:thisconnect/screens/help_screen.dart';
import 'package:thisconnect/screens/home_screen.dart';
import 'package:thisconnect/screens/login_screen.dart';
import 'package:thisconnect/screens/main_screen.dart';
import 'package:thisconnect/screens/messages_screen.dart';
import 'package:thisconnect/screens/onboarding_screen.dart';
import 'package:thisconnect/screens/profile_menu_screen.dart';
import 'package:thisconnect/screens/profile_screen.dart';
import 'package:thisconnect/screens/qr_list_screen.dart';
import 'package:thisconnect/screens/qr_result_screen.dart';
import 'package:thisconnect/screens/qr_scanner_screen.dart';
import 'package:thisconnect/services/pref_handler.dart';
import 'screens/splash_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ThisConnect());
}

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
      home: FutureBuilder<User?>(
          future: PrefHandler.getPrefUserInformation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return QRResultScreen(
                    qrCodeId: "a3ecf479-bd51-4c71-a1b1-3c0a5fa66342",
                    user: snapshot.data!,
                    loadScan: () {});
              } else {
                // Handle the case when there is no user data in prefs
                return Text("No user information available");
              }
            } else {
              // Show a loading spinner while waiting for the data
              return CircularProgressIndicator();
            }
          }),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/help': (context) => const HelpScreen(),
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomeScreen(),
        '/splash': (context) => const SplashScreen(),
        '/intro': (context) => const OnBoardingScreen(),
        '/profile': (context) => ProfileScreen(),
        //'/messages': (context) => const MessagesScreen(),
        '/profileMenu': (context) => const ProfileMenuScreen(),
        '/qrList': (context) => const QRListScreen(),
        //'/qrScanner': (context) => const QRScannerScreen(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
