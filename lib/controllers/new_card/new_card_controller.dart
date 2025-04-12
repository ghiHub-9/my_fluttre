

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lastcard/constants/const.dart';


class NewCardRequestController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;
  final storage = GetStorage();

  Future<void> submitNewCard({
    required Map<String, dynamic> fields,
    required XFile? userPhoto,
    required XFile? documents,
  }) async {
    isLoading.value = true;

    try {
      final String? token = storage.read('token');
      if (token == null || token.isEmpty) {
        responseMessage.value = "❌ No token found. Please log in.";
        Get.snackbar('Error', responseMessage.value);
        print(responseMessage.value);
        return;
      }

      if (userPhoto == null || documents == null) {
        responseMessage.value = '❌ Please select both a user photo and a document.';
        Get.snackbar('Error', responseMessage.value);
        print(responseMessage.value);
        return;
      }

      const String fullUrl = APIConfig.newCardEndpoint; // 👈 Ensure the URL is correct
      print('📤 Sending request to: $fullUrl');

      final Uri url = Uri.parse(fullUrl);

      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token', // or hardcoded for testing
          'Accept': 'application/json',
        })
        ..fields.addAll(fields.map((key, value) => MapEntry(key, value.toString())))
        ..files.add(await http.MultipartFile.fromPath('user_photo', userPhoto.path))
        ..files.add(await http.MultipartFile.fromPath('documents', documents.path));

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 201 || streamedResponse.statusCode == 200) {
        responseMessage.value = '✅ Success:\n$responseBody';
        Get.snackbar('Success', responseMessage.value);
        print(responseMessage.value);
      } else {
        responseMessage.value = '❌ Error ${streamedResponse.statusCode}:\n$responseBody';
        Get.snackbar('Error', responseMessage.value);
        print(responseMessage.value);
      }
    } catch (e) {
      responseMessage.value = '⚠️ Exception occurred:\n$e';
      Get.snackbar('Error', responseMessage.value);
      print(responseMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
