class APIConfig {
  static const String baseUrl = "http://192.168.1.6:8001/api"; // عدلي الـ IP هنا عند الحاجة

  // المسارات المختلفة داخل الـ API
  static const String loginEndpoint = "$baseUrl/login";
  static const String registerEndpoint = "$baseUrl/register";
  static const String newCardEndpoint = "$baseUrl/new-card";
  static const String logoutEndpoint = "$baseUrl/logout";
  static const String requestStatusEndpoint = "$baseUrl/requests/";

}
