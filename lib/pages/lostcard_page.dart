// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/services_page.dart';

//import '../services/api_service.dart';

class LostCardPage extends StatefulWidget {
  const LostCardPage({super.key});

  @override
  State<LostCardPage> createState() => _LostCardPageState();
}

// void replaceLostCard() async {
//   var response = await ApiService.replaceLostCard(1);

//   if (response['success']) {
//     print("تم تقديم طلب بدل فاقد");
//   } else {
//     print("خطأ: ${response['error']}");
//   }
// }


class _LostCardPageState extends State<LostCardPage> {
  final picker = ImagePicker();
  XFile? _selectedImage;
    Map<String, bool> fieldErrors = {};

  
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? idNumber;
  String? reason;
  DateTime? lostDate;
  bool isAcknowledged = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile; // استخدام XFile مباشرة
      });
    }
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  // Controller لتاريخ الفقد
  TextEditingController lostDateController = TextEditingController();

  // الحقول المحددة للتواريخ
  Widget _buildDatePickerField(String hintText, DateTime? selectedDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: lostDateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null && picked != selectedDate) {
            setState(() {
              lostDate = picked;
              lostDateController.text = "${lostDate!.day}/${lostDate!.month}/${lostDate!.year}";
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'تاريخ الفقد مطلوب';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImagePickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(' إضافة صورة :'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              builder: (context) {
                return Wrap(
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.camera_alt, color: kPrimaryColor),
                      title: const Text('التقاط صورة'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.image, color: kPrimaryColor),
                      title: const Text('اختر من المعرض'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white70),
            ),
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_selectedImage!.path), // تحويل XFile إلى File
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.white70, size: 40),
                      SizedBox(height: 8),
                      Text(
                        'اضغط لإضافة صورة لورقة توقيع العاقل',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
          ),
        ),
        if (fieldErrors.containsKey('image') && fieldErrors['image']!)
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'صورة المستخدم مطلوبة',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(String hintText, Function(String?)? onSaved, {TextInputType keyboardType = TextInputType.text, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText مطلوب';
          }
          return null;
        },
      ),
    );
  }

  // التحقق من رقم الهوية
  Widget _buildIdNumberField() {
    return _buildTextField(
      'رقم الهوية',
      (value) {
        idNumber = value;
      },
      keyboardType: TextInputType.number,
      maxLength: 11,
    );
  }

  Widget _buildCheckboxField() {
    return Row(
      children: [
        Checkbox(
          value: isAcknowledged,
          onChanged: (value) {
            setState(() {
              isAcknowledged = value!;
            });
          },
          activeColor: Colors.white,
          checkColor: kPrimaryColor,
        ),
        const Text(
          'أقر بأن كافة المعلومات صحيحة',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Center(
      child: TextButton(
        onPressed: isAcknowledged
            ? () {
                if (_formKey.currentState?.validate() ?? false) {
                  // حفظ البيانات
                  _formKey.currentState?.save();
                  // إرسال البيانات أو التوجيه إلى الصفحة التالية
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال الطلب بنجاح')),
                  );
                }
              }
            : null,
        style: TextButton.styleFrom(
          foregroundColor: isAcknowledged ? Colors.black : Colors.white,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: isAcknowledged ? Colors.white : kPrimaryColor,
          minimumSize: const Size(200, 50), // تحديد حجم الزر
        ),
        child: const Text('إرسال الطلب'),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 117, 144, 175),
          title: const Text(
            'استمارة بدل فاقد بطاقة شخصية',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: kPrimaryColor, // إضافة خلفية الصفحة هنا
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'معلومات الشخص المفقودة',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField('الاسم الكامل', (value) {
                    name = value;
                  }),
                  _buildIdNumberField(),
                  const SizedBox(height: 10),
                  _buildDatePickerField('تاريخ فقدان الهوية', lostDate),
                  const SizedBox(height: 10),
                  _buildTextField('سبب الفقدان', (value) {
                    reason = value;
                  }),
                  const SizedBox(height: 10),
                  _buildImagePickerField(),
                  const SizedBox(height: 20),
                  _buildCheckboxField(),
                  const SizedBox(height: 80),
                  _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
