

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lastcard/constants/const.dart';

import '../../pages/firstone.dart';

class LogoutController extends GetxController {
  var isLoading = false.obs;
  var logoutMessage = ''.obs;

  // Function to perform the logout request
  Future<void> logout() async {
    // Set loading state to true
    isLoading.value = true;

    // Get token from GetStorage
    var box = GetStorage();
    String? token = box.read('token'); // Retrieve the token from GetStorage

    if (token == null) {
      logoutMessage.value = 'No token found';
      isLoading.value = false;
      if (kDebugMode) {
        print('No token found');
      } // Debugging print
      return;
    }

    // Print token to confirm if it was retrieved
    if (kDebugMode) {
      print('Found token: $token');
    }  // Debugging print

    // Define the headers with the token
    var headers = {
      'Authorization': 'Bearer $token', // Use the token retrieved from GetStorage
    };

    // Define the request
    var request = http.Request('POST', Uri.parse(APIConfig.logoutEndpoint));
    request.headers.addAll(headers);

    try {
      // Send the request
      http.StreamedResponse response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        logoutMessage.value = 'Logout successful';
        print('Logout successful'); // Debugging print

        // Remove token and user data from GetStorage
        box.remove('token');
        box.remove('user');  // Remove any other user-related data
        if (kDebugMode) {
          print('Token and user removed from storage');
        } // Debugging print

        if (kDebugMode) {
          print(await response.stream.bytesToString());
        }

        Get.offAll(const FirstOne());
      } else {
        // Handle unexpected response
        logoutMessage.value = 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        if (kDebugMode) {
          print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        } // Debugging print
        _showLoginFailedDialog(logoutMessage.value);
      }
    } catch (e) {
      // Handle any errors
      logoutMessage.value = 'Error: $e';
      if (kDebugMode) {
        print('Error: $e');
      } // Debugging print
      // _showLoginFailedDialog(logoutMessage.value);
    } finally {
      // Set loading state to false
      isLoading.value = false;
    }
  }
}
void _showLoginFailedDialog(String message) {
  Get.defaultDialog(
    title: "خطأ في تسجيل الخروج",
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    middleText: message,
    middleTextStyle: const TextStyle(fontSize: 16),
    textCancel: "إغلاق",
  );
}