import 'dart:convert';
import 'package:thisconnect/models/qr.dart';
import 'package:thisconnect/models/qr_model.dart';
import 'package:thisconnect/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:thisconnect/models/user_model.dart';

class ApiHandler {
  static Future<QR> getQRInformation(String qrId) async {
    String url = "https://10.0.2.2:7049/api/qr/byqrid/$qrId";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    final user = await getUserInformation(json["userId"]);

    return QR(
        qrId: qrId,
        userId: json["userId"],
        title: json["title"],
        shareEmail: json["shareEmail"],
        sharePhone: json["sharePhone"],
        shareNote: json["shareNote"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        note: json["note"],
        isActive: json["isActive"],
        user: user);
  }

  static Future<bool> updateQRInformation(QR updatedQR) async {
    String url = "https://10.0.2.2:7049/api/qr/updateqr/${updatedQR.qrId}";
    Uri uri = Uri.parse(url);

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'qrId': updatedQR.qrId,
        'userId': updatedQR.userId,
        'title': updatedQR.title,
        'shareEmail': updatedQR.shareEmail,
        'sharePhone': updatedQR.sharePhone,
        'shareNote': updatedQR.shareNote,
        'createdAt': updatedQR.createdAt,
        'updatedAt': updatedQR.updatedAt,
        'note': updatedQR.note,
        'isActive': updatedQR.isActive,
      }),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      print('Failed to update QR information: ${response.statusCode}');
      return false;
    }
  }

  static Future<bool> deleteQR(String qrId) async {
    String url = "https://10.0.2.2:7049/api/qr/deleteqr/$qrId";
    Uri uri = Uri.parse(url);

    try {
      final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        print('Failed to delete QR: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting QR: $e');
      return false;
    }
  }

  static Future<bool> addQR(QR addedQR) async {
    String url = "https://10.0.2.2:7049/api/qr/addqr";
    Uri uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'qrId': addedQR.qrId,
        'userId': addedQR.userId,
        'title': addedQR.title,
        'shareEmail': addedQR.shareEmail,
        'sharePhone': addedQR.sharePhone,
        'shareNote': addedQR.shareNote,
        'createdAt': addedQR.createdAt,
        'updatedAt': addedQR.updatedAt,
        'note': addedQR.note,
        'isActive': addedQR.isActive,
      }),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      print('Failed to add QR: ${response.statusCode}');
      return false;
    }
  }

  static Future<User> getUserInformation(String userId) async {
    String url = "https://10.0.2.2:7049/api/user/$userId";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    return User(
        userId: json["userId"],
        phone: json["phone"],
        email: json["email"],
        title: json["title"],
        name: json["name"],
        surname: json["surname"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        avatarUrl: json["avatarUrl"],
        lastSeenAt: json["lastSeenAt"]);
  }

  static Future<List<QR>> getUsersQRList(String userId) async {
    String url = "https://10.0.2.2:7049/api/QR/byuserid/$userId";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['\$values'] as List<dynamic>;
    final user = await getUserInformation(results[0]["userId"]);
    final qrlist = await Future.wait(results.map((e) async {
      return QR(
          qrId: e["qrId"],
          userId: e["userId"],
          title: e["title"],
          shareEmail: e["shareEmail"],
          sharePhone: e["sharePhone"],
          shareNote: e["shareNote"],
          note: e["note"],
          createdAt: e["createdAt"],
          updatedAt: e["updatedAt"],
          isActive: e["isActive"],
          user: user);
    }));
    return qrlist;
  }
}
