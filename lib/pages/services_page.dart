import 'package:flutter/material.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/newcard_page.dart';
import 'package:lastcard/pages/renewingcard_page.dart';
import 'package:lastcard/pages/lostcard_page.dart';
import 'package:lastcard/pages/modifycard_page.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  final List<Map<String, String>> _requests = [
    {'requestId': '12345', 'status': 'قيد المعالجة', 'date': '2025-02-12'},
    {'requestId': '67890', 'status': 'قيد الحفظ ', 'date': '2025-02-10'},
    {'requestId': '54321', 'status': 'رفض  ', 'date': '2025-05-4'},
    {'requestId': '13245', 'status': 'مؤكد  ', 'date': '2025-03-2'},
  ];

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _showRequestsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حالة الطلبات'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text("رقم الطلب: ${request['requestId']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الحالة: ${request['status']}", style: const TextStyle(color: Colors.blue)),
                        Text("التاريخ: ${request['date']}", style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
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
              onPressed: () => _showRequestsDialog(context),
            ),
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