import 'package:flutter/material.dart';
import 'package:lastcard/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _phone_numberController = TextEditingController();

  void _sendPasswordResetLink() {
    String phone_number = _phone_numberController.text;

    if (phone_number.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إرسال رابط استرجاع كلمة المرور إلى $phone_number')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال رقم الهاتف')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'نسيت كلمة المرور؟',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white, // لون النص
          ),
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // لون السهم
        ),
      ),
      body: Container(
        color: kPrimaryColor, // خلفية الصفحة
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'أدخل رقم هاتفك لاسترجاع كلمة المرور',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // لون النص
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phone_numberController,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  labelStyle:
                      TextStyle(color: Colors.white), // لون النصوص داخل الحقل
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white), // لون النص المدخل
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendPasswordResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC7EDE6), // لون الزر
                ),
                child: const Text(
                  'إرسال رابط استرجاع كلمة المرور',
                  style: TextStyle(color: Colors.black), // لون النص على الزر
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
