import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:thisconnect/screens/messages_screen.dart';
import 'package:thisconnect/screens/profile_menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPage = 0;
  final pageOptions = [
    const MessagesScreen(),
    const MessagesScreen(),
    const ProfileMenuScreen(),
  ];
  final appBarTitles = [
    "Messages",
    "Messages",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitles[selectedPage],
              style: const TextStyle(
                  fontSize: 20, color: Colors.white, letterSpacing: 1)),
          backgroundColor: Colors.blue,
          elevation: 210,
          centerTitle: true,
        ),
        body: pageOptions[selectedPage],
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          height: 54,
          initialActiveIndex: selectedPage,
          items: const [
            TabItem(icon: Icons.message, title: 'Messages'),
            TabItem(
              icon: Icons.qr_code_scanner,
              title: 'Messages',
            ),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          onTap: (int index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/qrScanner');
            }
            setState(() {
              if (index != 1) {
                selectedPage = index;
              }
            });
          },
        ));
  }
}
