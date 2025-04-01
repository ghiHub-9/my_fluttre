import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // استخدام final لجعل المتغير غير قابل للتغيير
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // تنفيذ الوظيفة عند الضغط
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // تأثير الظل الخفيف
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold, // تحسين النص بجعله أكثر وضوحًا
            ),
          ),
        ),
      ),
    );
  }
}
