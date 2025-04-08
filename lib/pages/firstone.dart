import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/services_page.dart';
import 'package:lastcard/widgest/nav_drawer.dart';



class FirstOne extends StatefulWidget {
  const FirstOne({super.key});

  @override
  State<FirstOne> createState() => _FirstOneState();
}

class _FirstOneState extends State<FirstOne> {

  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1)); // Optional splash delay
    final token = storage.read('token');

    if (token != null && token.isNotEmpty) {
      debugPrint("✅ Token found: $token");
      Get.offAll(ServicesPage()); // Or push replacement to your Home screen
    } else {
      debugPrint("❌ No token found");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor, // لون شريط التطبيق
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/firstone.png'),
            fit: BoxFit.cover, // تملأ الصورة الشاشة بالكامل
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'نظام هويةالمواطن',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  backgroundColor: Color.fromARGB(137, 60, 97, 140), // خلفية شفافة للنص
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40), // تباعد بين النص والزر
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'LoginPage'); // الانتقال إلى صفحة تسجيل الدخول
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor, // لون الزر
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // زوايا مستديرة
                  ),
                ),
                child: const Text(
                  'انتقل الى صفحة تسجيل الدخول',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
