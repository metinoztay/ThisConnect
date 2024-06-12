import 'package:flutter/material.dart';
import 'package:thisconnect/models/qr.dart';
import 'package:thisconnect/screens/qr_viewing_screen.dart';

class QRListScreen extends StatefulWidget {
  const QRListScreen({super.key});

  @override
  State<QRListScreen> createState() => _QRListScreenState();
}

class _QRListScreenState extends State<QRListScreen> {
  List<QR> qrList = [];
  List<String> itemMaps = ['/main', '/main', '/chat', '/chat', '/chat'];

  @override
  void initState() {
    super.initState();
    loadQRList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: qrList.length,
                itemBuilder: (context, index) {
                  final item = qrList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    QRViewingScreen(qrCode: "QR CODE"))),
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
                          leading: SizedBox(
                            height: 40,
                            width: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Create QR',
                      style: TextStyle(fontSize: 20),
                    ),
                    content: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter title',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Create'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shadowColor: Colors.grey.shade300,
                elevation: 10,
              ),
              child: const Text(
                "Create New QR",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  loadQRList() {
    qrList = [
      QR(title: 'QR 1', image: 'https://picsum.photos/200/300'),
      QR(title: 'QR 2', image: 'https://picsum.photos/200/300'),
      QR(title: 'QR 3', image: 'https://picsum.photos/200/300'),
      QR(title: 'QR 4', image: 'https://picsum.photos/200/300'),
      QR(title: 'QR 5', image: 'https://picsum.photos/200/300'),
    ];
  }
}
