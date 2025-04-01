import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.1.105:8000/api",
    headers: {"Accept": "application/json"},
  ));

  Future<Response> registerUser(String fullname, String phone_number, String password) async {
    return await _dio.post('/register', data: {'fullname':fullname, 'phone_number': phone_number, 'password': password});
  }

  Future<Response> loginUser(String phone_number, String password) async {
    return await _dio.post('/login', data: {'phone_number': phone_number, 'password': password});
  }

  Future<Response> createRequest(String token, int userId, String type) async {
    return await _dio.post('/request',
        data: {'user_id': userId, 'request_type': type},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

  Future<Response> getRequests(String token, int userId) async {
    return await _dio.get('/requests/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }
  
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   static const String baseUrl = "http://127.0.0.1:8000/api"; // غيّره إلى رابط Laravel الخاص بك

//   /// **تسجيل مستخدم جديد**
//   static Future<Map<String, dynamic>> registerUser(String first_name, String phone_number, String password) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/register"),
//       body: {
//         "first_name": first_name,
//         "phone_number_number": phone_number,
//         "password": password,
//       },
//     );

//     return json.decode(response.body);
//   }

//   /// **تسجيل الدخول**
//   static Future<Map<String, dynamic>> loginUser(String phone_number, String password) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/login"),
//       body: {
//         "phone_number_number": phone_number,
//         "password": password,
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString("token", data["token"]); // تخزين التوكن لاستخدامه لاحقًا
//       return {"success": true, "user": data["user"]};
//     } else {
//       return {"success": false, "message": "بيانات تسجيل الدخول غير صحيحة"};
//     }
//   }

//   /// **إصدار بطاقة جديدة**
//   static Future<Map<String, dynamic>> requestNewCard(String fullfirst_name, String birthDate, String birthPlace) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");

//     if (token == null) {
//       return {"success": false, "message": "المستخدم غير مسجّل الدخول"};
//     }

//     final response = await http.post(
//       Uri.parse("$baseUrl/cards"),
//       headers: {
//         "Authorization": "Bearer $token",
//         "Content-Type": "application/json",
//       },
//       body: json.encode({
//         "full_first_name": fullfirst_name,
//         "birth_date": birthDate,
//         "birth_place": birthPlace,
//       }),
//     );

//     return json.decode(response.body);
//   }



//   // تجديد البطاقة
//   static Future<Map<String, dynamic>> renewCard(int cardId) async {
//     String? token = await _getToken();
//     if (token == null) return {'success': false, 'error': 'Token not found'};

//     final response = await http.post(
//       Uri.parse('$baseUrl/cards/$cardId/renew'),
//       headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
//     );

//     return _handleResponse(response);
//   }

//   // بدل فاقد
//   static Future<Map<String, dynamic>> replaceLostCard(int cardId) async {
//     String? token = await _getToken();
//     if (token == null) return {'success': false, 'error': 'Token not found'};

//     final response = await http.post(
//       Uri.parse('$baseUrl/cards/$cardId/replace-lost'),
//       headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
//     );

//     return _handleResponse(response);
//   }

//   // تعديل بيانات البطاقة
//   static Future<Map<String, dynamic>> updateCard(int cardId, String fullfirst_name, String birthDate) async {
//     String? token = await _getToken();
//     if (token == null) return {'success': false, 'error': 'Token not found'};

//     final response = await http.put(
//       Uri.parse('$baseUrl/cards/$cardId'),
//       headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
//       body: jsonEncode({'full_first_name': fullfirst_name, 'birth_date': birthDate}),
//     );

//     return _handleResponse(response);
//   }

//   // تخزين التوكن في الجهاز
//   static Future<void> _saveToken(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', token);
//   }

//   // جلب التوكن من الجهاز
//   static Future<String?> _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   // مسح التوكن من الجهاز
//   static Future<void> _clearToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('auth_token');
//   }

//   // دالة لمعالجة الاستجابة
//   static Map<String, dynamic> _handleResponse(http.Response response) {
//     final data = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return {'success': true, 'data': data};
//     } else {
//       return {'success': false, 'error': data['message'] ?? 'حدث خطأ'};
//     }
//   }
// }
