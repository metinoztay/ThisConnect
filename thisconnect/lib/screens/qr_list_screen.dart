import 'package:flutter/material.dart';
import 'package:thisconnect/models/qr_model.dart';
import 'package:thisconnect/screens/qr_viewing_screen.dart';
import 'package:thisconnect/services/api_handler.dart';

class QRListScreen extends StatefulWidget {
  const QRListScreen({super.key});

  @override
  State<QRListScreen> createState() => _QRListScreenState();
}

class _QRListScreenState extends State<QRListScreen> {
  List<QR> _qrList = [];
  String newQRtitle = '';
  String userId = "febcb8a6-937d-4aa9-a659-5c90d7c66b4b";
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
                itemCount: _qrList.length,
                itemBuilder: (context, index) {
                  final item = _qrList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QRViewingScreen(
                                    qrId: item.qrId,
                                    updateQRList: loadQRList))),
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
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Create QR',
                        style: TextStyle(fontSize: 20),
                      ),
                      content: TextField(
                        onChanged: (value) {
                          newQRtitle = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter title',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            addQR();
                            Navigator.pop(context);
                          },
                          child: const Text('Create'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
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

  Future<void> loadQRList() async {
    final results = await ApiHandler.getUsersQRList(userId);
    setState(() {
      _qrList = results;
    });
  }

  Future<void> addQR() async {
    final results = await ApiHandler.addQR(
      QR(
          qrId: "test",
          userId: userId,
          title: newQRtitle,
          shareEmail: false,
          sharePhone: false,
          shareNote: false,
          note: "Note",
          createdAt: DateTime.now().toString(),
          isActive: true,
          user: await ApiHandler.getUserInformation(userId)),
    );

    setState(() {
      loadQRList();
    });
  }
}
