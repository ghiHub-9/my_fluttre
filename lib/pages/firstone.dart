import 'package:flutter/material.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/widgest/nav_drawer.dart';



class FirstOne extends StatelessWidget {
  const FirstOne({super.key});

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
