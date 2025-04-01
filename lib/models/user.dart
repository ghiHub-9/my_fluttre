class User {
  String name;
  int phone_number;
  String password;
  String passwordConfirmation;

  User({
    required this.name,
    required this.phone_number,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phone_number,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
