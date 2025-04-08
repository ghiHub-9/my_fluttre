import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lastcard/constants/const.dart';

import '../../pages/services_page.dart';


class LoginController extends GetxController {
  final storage = GetStorage();

  var isLoading = false.obs;
  var loginMessage = ''.obs;
  var token = ''.obs;
  var userData = {}.obs;

  Future<void> loginUser({
    required String phoneNumber,
    required String password,
  }) async {
    /// Set loading state to true
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(APIConfig.loginEndpoint);

    var body = json.encode({
      "phone_number": phoneNumber,
      "password": password,
    });

    try {
      var request = http.Request('POST', url);
      request.body = body;
      request.headers.addAll(headers);

      /// Start the request and await the response
      debugPrint("Sending login request...");  // Debug message before sending the request
      http.StreamedResponse response = await request.send();

      /// Check the status code of the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

        /// Extract token and user information
        token.value = data['token'];
        userData.value = data['user'];

        /// Save the token and user information locally
        storage.write('token', token.value);
        storage.write('user', userData);

        loginMessage.value = "✅ Logged in successfully";
        debugPrint("Token: ${token.value}");  // Debug message to print the token
        debugPrint("User Data: ${userData}");  // Debug message to print user data

        /// Navigate to the next page (ServicesPage)
        Get.offAll(() => ServicesPage());
      } else {
        loginMessage.value = '❌ Login failed: ${response.reasonPhrase}';

        debugPrint("Login failed with status code: ${response.statusCode}");  // Debug message for failure
        debugPrint("Reason: ${response.reasonPhrase}");  // Debug message for failure reason
        _showLoginFailedDialog("Login failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      loginMessage.value = '❌ Exception: $e';
      debugPrint("Exception occurred: $e");  // Debug message for exceptions
      _showLoginFailedDialog("Exception occurred: $e");
    } finally {
      isLoading.value = false;
      debugPrint("Login request finished");  // Debug message for when request is finished
    }
  }
}

void _showLoginFailedDialog(String message) {
  Get.defaultDialog(
    title: "خطأ في تسجيل الدخول",
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    middleText: message,
    middleTextStyle: const TextStyle(fontSize: 16),
    textCancel: "إغلاق",
  );
}