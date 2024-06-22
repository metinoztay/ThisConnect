import 'dart:convert';
import 'package:thisconnect/models/user.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<Usertemp>> getUsers() async {
    const url = "https://randomuser.me/api?results=5";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      return Usertemp(
          title: e["name"]["title"],
          firstName: e["name"]["first"],
          lastName: e["name"]["last"],
          gender: e["gender"],
          email: e["email"],
          phone: e["phone"],
          nat: e["nat"],
          image: e["picture"]["thumbnail"],
          messageDayFull: e["registered"]["date"].toString());
    }).toList();
    return users;
  }
}
