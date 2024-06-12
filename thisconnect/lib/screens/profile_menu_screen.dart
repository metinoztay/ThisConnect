import 'package:thisconnect/models/profileitem.dart';
import 'package:thisconnect/models/user.dart';
import 'package:thisconnect/services/user_api.dart';
import 'package:flutter/material.dart';

class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({super.key});

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  List<Profileitem> profileItems = [];
  List<String> itemMaps = ['/main', '/qrList', '/chat', '/help', '/login'];
  @override
  void initState() {
    super.initState();
    loadProfileItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView.builder(
          itemCount: profileItems.length,
          itemBuilder: (context, index) {
            final item = profileItems[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context,
                      itemMaps[
                          index]), // logout olduğunda push replacement yapılacak
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    leading: Icon(item.icon),
                  ),
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  loadProfileItems() {
    profileItems = [
      Profileitem(title: 'Profile', icon: Icons.person),
      Profileitem(title: 'QR List', icon: Icons.qr_code),
      Profileitem(title: 'Settings', icon: Icons.settings),
      Profileitem(title: 'Help', icon: Icons.help),
      Profileitem(title: 'Logout', icon: Icons.logout),
    ];
  }
}
