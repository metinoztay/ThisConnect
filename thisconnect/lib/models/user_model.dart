class User {
  final String userId;
  final String phone;
  final String email;
  final String title;
  final String name;
  final String surname;
  final String? avatarUrl;
  final String createdAt;
  final String? updatedAt;
  final String lastSeenAt;

  User({
    required this.userId,
    required this.phone,
    required this.email,
    required this.title,
    required this.name,
    required this.surname,
    this.avatarUrl,
    required this.createdAt,
    this.updatedAt,
    required this.lastSeenAt,
  });
}
