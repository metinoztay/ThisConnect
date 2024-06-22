import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:thisconnect/models/qr_model.dart';
import 'package:thisconnect/models/user_model.dart';
import 'package:thisconnect/services/api_handler.dart';

class QRResultScreen extends StatefulWidget {
  final String qrCodeId;
  final Function loadScan;

  const QRResultScreen(
      {super.key, required this.qrCodeId, required this.loadScan});

  @override
  State<QRResultScreen> createState() => _QRResultScreenState();
}

class _QRResultScreenState extends State<QRResultScreen> {
  late QRInformation _qrInformation;
  String fullName = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getQRResult();
  }

  @override
  void dispose() {
    widget.loadScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Result",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _qrInformation == null
              ? const Center(child: Text("No data found."))
              : Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(_qrInformation.user.avatarUrl!),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${_qrInformation.user.title} ${_qrInformation.user.name} ${_qrInformation.user.surname}",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Last Seen: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              Text(
                                _qrInformation.user.lastSeenAt,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Email: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              Expanded(
                                child: Text(
                                  _qrInformation.shareEmail
                                      ? _qrInformation.user.email
                                      : "-----",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Phone: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              Expanded(
                                child: Text(
                                  _qrInformation.sharePhone
                                      ? _qrInformation.user.phone
                                      : "----------",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Note:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              Text(
                                _qrInformation.shareNote &&
                                        _qrInformation.shareNote != null
                                    ? _qrInformation.note!
                                    : "There is no note for this QR Code.",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Connect!",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Future<void> getQRResult() async {
    try {
      final result = await ApiHandler.getQRInformation(widget.qrCodeId);

      setState(() {
        _qrInformation = result;
      });
    } catch (e) {
      // Handle error here
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
