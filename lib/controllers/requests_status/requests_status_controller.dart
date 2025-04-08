import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lastcard/constants/const.dart';

class RequestStatusController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var requestData = <RequestData>[].obs; // Ensure this is a list of objects

  final storage = GetStorage();

  Future<void> fetchRequestData() async {
    isLoading.value = true;
    errorMessage.value = '';

    String? token = storage.read('token');  // Retrieve token from GetStorage
    var userJson = storage.read('user');  // Retrieve user data from GetStorage

    if (token == null) {
      errorMessage.value = "❌ No token found. Please log in.";
      isLoading.value = false;
      return;
    }

    if (userJson == null) {
      errorMessage.value = "❌ No user data found.";
      isLoading.value = false;
      return;
    }

    // Decode user data if it's stored as a JSON string
    Map<String, dynamic> user = userJson is String ? jsonDecode(userJson) : userJson;

    int userId = user['id']; // Extract user ID
    print("********** User ID: $userId");

    var url = Uri.parse('${APIConfig.requestStatusEndpoint}$userId');

    var headers = {
      'Authorization': 'Bearer $token',  // Use the stored token
    };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['data'] != null && data['data'] is List) {
          requestData.value = (data['data'] as List)
              .map((item) => RequestData.fromJson(item))
              .toList();
        } else {
          errorMessage.value = "❌ No requests found.";
        }
      } else {
        errorMessage.value = "❌ API Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      errorMessage.value = "❌ Exception: $e";
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRequestData(); // Fetch requests when controller is initialized
    super.onInit();
  }
}


// Model to represent each request data item
class RequestData {
  final int id;
  final String requestDate;
  final String requestTime;
  final String requestStatus;
  final String? rejectionReason;
  final String createdAt;
  final String updatedAt;
  final int serviceId;
  final int userId;
  final int branchId;

  RequestData({
    required this.id,
    required this.requestDate,
    required this.requestTime,
    required this.requestStatus,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceId,
    required this.userId,
    required this.branchId,
  });

  // Factory method to create a RequestData object from JSON
  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      id: json['id'] ?? 0, // Default value to prevent null exceptions
      requestDate: json['request_date'] ?? '',
      requestTime: json['request_time'] ?? '',
      requestStatus: json['request_status'] ?? '',
      rejectionReason: json['rejection_reason'], // Nullable field
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      serviceId: json['service_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      branchId: json['branch_id'] ?? 0,
    );
  }
}

