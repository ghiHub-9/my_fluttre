class APIConfig {
  static const String baseUrl = "http://192.168.1.105:8000/api"; // عدلي الـ IP هنا عند الحاجة

  // المسارات المختلفة داخل الـ API
  static const String loginEndpoint = "$baseUrl/login";
  static const String registerEndpoint = "$baseUrl/register";
  static const String newCardEndpoint = "$baseUrl/new-card";
}
