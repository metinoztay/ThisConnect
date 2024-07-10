import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thisconnect/models/chatroom_model.dart';
import 'package:thisconnect/models/messageModel.dart';
import 'package:thisconnect/models/message_model.dart';
import 'package:thisconnect/models/user_model.dart';
import 'package:thisconnect/services/api_handler.dart';
import 'package:thisconnect/utils/removeMessageExtraChar.dart';
import 'package:thisconnect/widgets/chatMessageListWidget.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:thisconnect/widgets/chatTypeMessageWidget.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoom chatRoom;
  final User user;
  final String userName;
  const ChatScreen(this.userName, this.user, this.chatRoom, {super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? reciever;
  ScrollController chatListScrollController = ScrollController();
  TextEditingController messageTextController = TextEditingController();

  bool isMessageEmpty = true;

  @override
  void initState() {
    super.initState();
    getUserInformations();
    openSignalRConnection();
    messageTextController.addListener(_handleMessageChanged);
  }

  @override
  void dispose() {
    messageTextController.removeListener(_handleMessageChanged);
    messageTextController.dispose();
    super.dispose();
  }

  void _handleMessageChanged() {
    if (mounted) {
      setState(() {
        isMessageEmpty = messageTextController.text.trim().isEmpty;
      });
    }
  }

  Future<void> submitMessageFunction() async {
    if (reciever == null) {
      return;
    }
    var messageText = removeMessageExtraChar(messageTextController.text);

    var message = {
      'MessageId': null,
      'ChatRoomId': widget.chatRoom.chatRoomId,
      'SenderUserId': widget.user.userId,
      'RecieverUserId': reciever!.userId,
      'AttachmentId': null,
      'Content': messageText,
      'CreatedAt': DateTime.now().toIso8601String(),
      'ReadedAt': null,
    };

    await connection.invoke('SendMessage', args: [message]);
    messageTextController.text = "";

    Future.delayed(const Duration(milliseconds: 50), () {
      chatListScrollController.animateTo(
          chatListScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reciever == null) {
      return Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        title: Row(
          children: [
            ClipOval(
                child: Image.network(
              reciever!.avatarUrl!,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            )),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reciever!.title}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 1),
                ),
                Text(
                  "${reciever!.name} ${reciever!.surname}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, letterSpacing: 1),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            chatMessageWidget(chatListScrollController, messages,
                widget.user.userId, context),
            chatTypeMessageWidget(
                messageTextController, submitMessageFunction, isMessageEmpty),
          ],
        ),
      ),
    );
  }

  final connection = HubConnectionBuilder()
      .withUrl(
          'https://10.0.2.2:7049/chathub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
            transport: HttpTransportType.webSockets,
            skipNegotiation: true,
          ))
      .build();

  Future<void> openSignalRConnection() async {
    await connection.start();
    connection.on('ReceiveMessage', (message) {
      _handleIncommingDriverLocation(message);
    });
    await connection.invoke('JoinRoom', args: [widget.chatRoom.chatRoomId]);
  }

  List<Message> messages = [];
  Future<void> _handleIncommingDriverLocation(List<dynamic>? args) async {
    if (args != null) {
      var jsonResponse = json.decode(json.encode(args[0]));
      Message data = Message.fromJson(jsonResponse);
      if (mounted) {
        setState(() {
          messages.add(data);
          Future.delayed(const Duration(milliseconds: 50), () {
            chatListScrollController.animateTo(
                chatListScrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          });
        });
      }
    }
  }

  Future<void> getUserInformations() async {
    try {
      final recieverTemp = await ApiHandler.getUserInformation(
          widget.chatRoom.participant1Id == widget.user.userId
              ? widget.chatRoom.participant1Id
              : widget.chatRoom.participant2Id);
      //final senderTemp = await ApiHandler.getUserInformation(widget.senderId);
      if (mounted) {
        setState(() {
          reciever = recieverTemp;
          //sender = senderTemp;
        });
      }
    } catch (e) {}
  }
}
