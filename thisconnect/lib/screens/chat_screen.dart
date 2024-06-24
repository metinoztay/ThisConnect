import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thisconnect/models/messageModel.dart';
import 'package:thisconnect/models/user_model.dart';
import 'package:thisconnect/services/api_handler.dart';
import 'package:thisconnect/utils/removeMessageExtraChar.dart';
import 'package:thisconnect/widgets/chatMessageListWidget.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:thisconnect/widgets/chatTypeMessageWidget.dart';

class ChatScreen extends StatefulWidget {
  final String recieverId;
  final String senderId = "1";
  final String userName;
  const ChatScreen(this.userName, this.recieverId, {super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? reciever;
  //late User sender;
  ScrollController chatListScrollController = new ScrollController();
  TextEditingController messageTextController = TextEditingController();
  // Şu anki kullanıcının ID'si
  bool isMessageEmpty = true;

  @override
  void initState() {
    super.initState();
    getUserInformations();
    openSignalRConnection();
    createRandomId();
    messageTextController.addListener(_handleMessageChanged);
  }

  @override
  void dispose() {
    messageTextController.removeListener(_handleMessageChanged);
    messageTextController.dispose();
    super.dispose();
  }

  void _handleMessageChanged() {
    setState(() {
      isMessageEmpty = messageTextController.text.trim().isEmpty;
    });
  }

  int currentUserId = 0;
  //generate random user id
  createRandomId() {
    Random random = Random();
    currentUserId = random.nextInt(999999);
  }

  submitMessageFunction() async {
    if (reciever == null) {
      return;
    }
    var messageText = removeMessageExtraChar(messageTextController.text);
    await connection.invoke('SendMessage',
        args: [widget.userName, currentUserId, messageText]);
    messageTextController.text = "";

    Future.delayed(const Duration(milliseconds: 50), () {
      chatListScrollController.animateTo(
          chatListScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
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
            const Text(
              'Brent Brewer',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            chatMessageWidget(
                chatListScrollController, messageModel, currentUserId, context),
            chatTypeMessageWidget(
                messageTextController, submitMessageFunction, isMessageEmpty),
          ],
        ),
      ),
    );
  }

  //set url and configs
  final connection = HubConnectionBuilder()
      .withUrl(
          'https://10.0.2.2:7049/chathub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
            transport: HttpTransportType.webSockets,
            skipNegotiation: true,
          ))
      .build();

  //connect to signalR
  Future<void> openSignalRConnection() async {
    await connection.start();
    connection.on('ReceiveMessage', (message) {
      _handleIncommingDriverLocation(message);
    });
    await connection.invoke('JoinUSer', args: [widget.userName, currentUserId]);
  }

  //get messages
  List<MessageModel> messageModel = [];
  Future<void> _handleIncommingDriverLocation(List<dynamic>? args) async {
    if (args != null) {
      var jsonResponse = json.decode(json.encode(args[0]));
      MessageModel data = MessageModel.fromJson(jsonResponse);
      setState(() {
        messageModel.add(data);
        Future.delayed(const Duration(milliseconds: 50), () {
          chatListScrollController.animateTo(
              chatListScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
        });
      });
    }
  }

  Future<void> getUserInformations() async {
    try {
      final recieverTemp =
          await ApiHandler.getUserInformation(widget.recieverId);
      //final senderTemp = await ApiHandler.getUserInformation(widget.senderId);
      setState(() {
        reciever = recieverTemp;
        //sender = senderTemp;
      });
    } catch (e) {
      // Handle error here
    }
  }
}
