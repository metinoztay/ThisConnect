import 'package:thisconnect/models/user.dart';
import 'package:thisconnect/screens/chat_screen.dart';
import 'package:thisconnect/services/user_api.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    readUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final name = user.fullName;
            return GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ChatScreen("Deneme"),
                  ),
                );
              },
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.title,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.messageDay,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(user.image),
                ),
                subtitle: Text(
                  name,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> readUsers() async {
    final results = await UserApi.getUsers();
    setState(() {
      users = results;
    });
  }
}
