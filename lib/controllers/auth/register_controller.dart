import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lastcard/constants/const.dart';

import '../../pages/login_page.dart';

class RegisterController extends GetxController {
  // Observables for loading and response
  var isLoading = false.obs;
  var responseMessage = ''.obs;

  // Register function
  Future<void> registerUser({
    required String firstName,
    required String phoneNumber,
    required String password,
  }) async {
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(APIConfig.registerEndpoint);

    var body = json.encode({
      "first_name": firstName,
      "phone_number": phoneNumber,
      "password": password,
    });

    try {
      var request = http.Request('POST', url);
      request.body = body;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        String responseData = await response.stream.bytesToString();
        responseMessage.value = responseData;
        debugPrint('✅ Success: $responseData');
        Get.to(()=>const LoginPage());
      } else {
        String error = response.reasonPhrase ?? 'Unknown error';
        Get.snackbar('error', error.toString());
        responseMessage.value = '❌ Error: $error';
        debugPrint('❌ Error: $error');
      }
    } catch (e) {
      responseMessage.value = '❌ Exception: $e';
      Get.snackbar('error', responseMessage.value);
      debugPrint('❌ Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
