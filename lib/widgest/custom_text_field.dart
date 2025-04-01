import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText; // لإخفاء النص (كلمة المرور)
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.onSaved, 
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white70, // لون النص التلميحي
          fontSize: 16,
        ),
        prefixIcon: prefixIcon, // أيقونة البداية
        suffixIcon: suffixIcon, // أيقونة النهاية
        filled: true,
        fillColor: Colors.white.withOpacity(0.1), // لون الخلفية
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0, 
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // الحواف المستديرة
          borderSide: BorderSide.none, // إزالة الحدود
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5), // لون الحدود عند التفاعل
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.white, // لون النص المدخل
        fontSize: 16,
      ),
      onSaved: onSaved,
    );
  }
}
