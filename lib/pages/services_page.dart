import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/controllers/auth/logout_controller.dart';
import 'package:lastcard/controllers/requests_status/requests_status_controller.dart';
import 'package:lastcard/pages/newcard_page.dart';
import 'package:lastcard/pages/renewingcard_page.dart';
import 'package:lastcard/pages/lostcard_page.dart';
import 'package:lastcard/pages/modifycard_page.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  LogoutController logoutController = Get.put(LogoutController());
  RequestStatusController requestStatusController = Get.put(RequestStatusController());


  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _showRequestsDialog(BuildContext context) {
    requestStatusController.fetchRequestData(); // Fetch data before showing dialog

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حالة الطلبات'),
          content: SizedBox(
            width: double.maxFinite,
            child: Obx(() {
              if (requestStatusController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (requestStatusController.errorMessage.isNotEmpty) {
                return Center(child: Text(requestStatusController.errorMessage.value));
              } else if (requestStatusController.requestData.isEmpty) {
                return const Center(child: Text('لا توجد طلبات متاحة.'));
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: requestStatusController.requestData.length,
                itemBuilder: (context, index) {
                  final request = requestStatusController.requestData[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("رقم الطلب: ${request.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("الحالة: ${request.requestStatus}", style: const TextStyle(color: Colors.blue)),
                          Text("التاريخ: ${request.requestDate}", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'خدمات الهوية الوطنية',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 117, 144, 175),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: ()=> _showRequestsDialog(context),
            ),

            Obx(
                  () => logoutController.isLoading.value
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white))
                  : IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  // Show confirmation dialog in Arabic before logout
                  Get.dialog(
                    AlertDialog(
                      title: const Text(
                        'تأكيد الخروج',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back(); // Close the dialog
                          },
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            logoutController.logout(); // Call logout function
                            Get.back(); // Close the dialog
                          },
                          child: Text(
                            'تأكيد',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )

          ],
        ),
        backgroundColor: kPrimaryColor,
        body: Container(
          color: kPrimaryColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'أهلاً بكم في خدمات الهوية الوطنية عبر منصة هويتك من بيتك',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildServiceCard(
                      context,
                      'إصدار الهوية الوطنية',
                      Icons.add_card,
                      () => _navigateToPage(context, const NewCardPage()),
                    ),
                    _buildServiceCard(
                      context,
                      'تجديد الهوية الوطنية',
                      Icons.refresh,
                      () => _navigateToPage(context, const RenewingCardPage()),
                    ),
                    _buildServiceCard(
                      context,
                      'بدل فاقد',
                      Icons.credit_card_off,
                      () => _navigateToPage(context, const LostCardPage()),
                    ),
                    _buildServiceCard(
                      context,
                      'تعديل البيانات',
                      Icons.edit,
                      () => _navigateToPage(context, const ModifyCardPage()),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: SizedBox(
          width: 150,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 50),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}