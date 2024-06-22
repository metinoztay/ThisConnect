class Usertemp {
  String title;
  String firstName;
  String lastName;
  String gender;
  String email;
  String phone;
  String nat;
  String image;
  String messageDayFull;

  Usertemp({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.nat,
    required this.image,
    required this.messageDayFull,
  });

  String get fullName {
    return "$title $firstName $lastName";
  }

  String get messageDay {
    return DateTime.now().day.toString() +
        '.' +
        DateTime.now().month.toString() +
        '.' +
        DateTime.now().year.toString();
  }
}
