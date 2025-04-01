class Login {
  int phone_number;
  String password;

  Login({
    required this.phone_number,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phone_number,
      'password': password,
    };
  }
}
