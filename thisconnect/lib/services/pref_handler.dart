import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thisconnect/models/user_model.dart';

class PrefHandler {
  static Future<bool> savePrefUserInformation(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user',
        jsonEncode({
          'userId': user.userId,
          'phone': user.phone,
          'email': user.email,
          'title': user.title,
          'name': user.name,
          'surname': user.surname,
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt,
          'avatarUrl': user.avatarUrl,
          'lastSeenAt': user.lastSeenAt
        }));
    return true;
  }

  static Future<User?> getPrefUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user');
    if (json != null) {
      final data = jsonDecode(json);
      return User(
          userId: data['userId'],
          phone: data['phone'],
          email: data['email'],
          title: data['title'],
          name: data['name'],
          surname: data['surname'],
          createdAt: data['createdAt'],
          updatedAt: data['updatedAt'],
          avatarUrl: data['avatarUrl'],
          lastSeenAt: data['lastSeenAt']);
    } else {
      return null;
    }
  }

  static Future<bool> removePrefUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    return true;
  }
}
