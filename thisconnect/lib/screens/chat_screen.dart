import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thisconnect/models/message.dart';
import 'package:thisconnect/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final String currentUserId = '1'; // Şu anki kullanıcının ID'si
  List<Message> messages = [
    Message(
        id: '1',
        chatRoomId: '1',
        senderUserId: '1',
        receiverUserId: '2',
        content: 'Hello',
        createdAt: DateTime.now()),
    Message(
        id: '2',
        chatRoomId: '1',
        senderUserId: '2',
        receiverUserId: '1',
        content: 'Hi',
        createdAt: DateTime.now()),
    Message(
        id: '3',
        chatRoomId: '1',
        senderUserId: '1',
        receiverUserId: '2',
        content: 'How are you?',
        createdAt: DateTime.now()),
    Message(
        id: '4',
        chatRoomId: '1',
        senderUserId: '2',
        receiverUserId: '1',
        content:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ',
        createdAt: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        title: Row(
          children: [
            ClipOval(
                child: Image.network(
              'https://randomuser.me/api/portraits/med/men/10.jpg',
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            )),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Brent Brewer',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderUserId == currentUserId;

                      return Row(
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            MessageBubble(
                              message: message,
                              currentUserId: currentUserId,
                            ),
                          ]);
                    })),
            Container(
              height: 54,
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.face_outlined,
                        color: Colors.white,
                      )),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none),
                    ),
                  ),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.attach_file_outlined,
                        color: Colors.white,
                      )),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.mic_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
