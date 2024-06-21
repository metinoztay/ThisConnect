import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRScreen extends StatefulWidget {
  @override
  _SignalRScreenState createState() => _SignalRScreenState();
}

class _SignalRScreenState extends State<SignalRScreen> {
  late final HubConnection _hubConnection;

  @override
  void initState() {
    super.initState();
    _hubConnection =
        HubConnectionBuilder().withUrl('http://localhost:7166/chathub').build();

    _hubConnection.on('ReceiveMessage', _handleReceiveMessage);

    _hubConnection.start();
    print('Connection started');
  }

  void _handleReceiveMessage(List<Object?>? args) {
    final user = args?[0] as String?;
    final message = args?[1] as String?;
    print('User: $user, Message: $message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter Message',
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Send'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(''),
                subtitle: Text(''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hubConnection.stop();
    super.dispose();
  }
}
