import 'dart:convert';
import 'package:thisconnect/models/qr_model.dart';
import 'package:thisconnect/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:thisconnect/models/user_model.dart';

class ApiHandler {
  static Future<QRInformation> getQRInformation(String qrId) async {
    String url = "https://10.0.2.2:7049/api/qr/$qrId";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    return QRInformation(
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
        user: User(
            userId: json["user"]["userId"],
            phone: json["user"]["phone"],
            email: json["user"]["email"],
            title: json["user"]["title"],
            name: json["user"]["name"],
            surname: json["user"]["surname"],
            createdAt: json["user"]["createdAt"],
            updatedAt: json["user"]["updatedAt"],
            avatarUrl: json["user"]["avatarUrl"],
            lastSeenAt: json["user"]["lastSeenAt"]));
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
}
