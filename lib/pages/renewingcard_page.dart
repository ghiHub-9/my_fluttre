// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/services_page.dart';

//import '../services/api_service.dart';

class RenewingCardPage extends StatefulWidget {
  const RenewingCardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RenewingCardPageState createState() => _RenewingCardPageState();
}


// void renewCard() async {
//   var response = await ApiService.renewCard(1);

//   if (response['success']) {
//     print("تم تجديد البطاقة");
//   } else {
//     print("خطأ: ${response['error']}");
//   }
// }


class _RenewingCardPageState extends State<RenewingCardPage> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> placeOFGetYourCard = [
    'المركز الرئيسي',
    'فرع قسم 14 اكتوبر',
    'فرع قسم شرطة 22 مايو',
    'قسم شرطة حدة',
    'فرع قسم شرطة شميلة',
    'فرع قسم شرطة جمال جميل',
    'فرع قسم شرطة الثورة',
    'فرع قسم شرطة الحصبة',
    'فرع قسم شرطة بني الحارث',
    'فرع قسم شرطة الشهيد الاحمر'
  ];
  final List<String> governorates = [
    'صنعاء',
    'لحج',
    'صعدة',
    'إب',
    'حضرموت',
    'أمانة العاصمة',
    'تعز',
    'عدن',
    'ريمة',
    'المحويت',
    'أبين',
    'الجوف',
    'شبوة',
    'ذمار',
    'مأرب',
    'الحديدة',
    'الضالع',
    'البيضاء',
    'حجة',
    'عمران',
    'المهرة'
  ];
  final List<String> placeofGotCard = [
    'مصلحة الأحوال المدنية - عصر',
    'فرع قسم شرطة الحصبة',
    'مصلحة الأحوال المدنية - صنعاء القديمة',
    'فرع قسم شرطة الشهيد الاحمر',
    'قسم شرطة حدة',
    'فرع قسم شرطة شميلة',
    'فرع قسم شرطة جمال جميل',
    'فرع قسم شرطة الثورة',
    'مصلحة الأحوال المدنية - بني الحارث',
    'قسم شرطة الحميري',
    'فرع قسم شرطة 22 مايو',
  ];
  String? selectedgovernorates;

  DateTime? selectedIssueDate;
  DateTime? selectedRenewalDate;
  DateTime? selectedRequestDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController grandFatherController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nationalNumberController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController renewalDateController = TextEditingController();
  TextEditingController requestDateController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkFormValidity() {
    setState(() {
      isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  void _showSuccessNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('لقد تم حفظ بياناتك الجديدة بنجاح'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // التنقل إلى صفحة الخدمات بعد ظهور الإشعار
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServicesPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تحديد اتجاه النص من اليمين إلى اليسار
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 117, 144, 175),
          title: const Text(
            'طلب الحصول على بطاقة شخصية تجديد',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: _checkFormValidity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'بيانات مقدم الطلب:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField('اسم الفرد', isRequired: true),
                  _buildTextField('اسم الأب', isRequired: true),
                  _buildTextField('اسم الجد', isRequired: true),
                  _buildTextField('اللقب', isRequired: true),
                  _buildTextField(
                    'الرقم الوطني',
                    controller: nationalNumberController,
                    isNumber: true,
                    maxLength: 11,
                    isRequired: true,
                  ),
                  _buildDropdownField(
                      'مكان إصدار البطاقة تجديد/مركز', placeOFGetYourCard),
                  _buildDropdownField('المحافظة', governorates),
                  _buildDatePickerField(
                    'تاريخ إصدار البطاقة',
                    controller: issueDateController,
                    selectedDate: selectedIssueDate,
                    onDatePicked: (date) {
                      setState(() {
                        selectedIssueDate = date;
                        issueDateController.text = _formatDate(date);
                        _checkFormValidity();
                      });
                    },
                    isRequired: true,
                  ),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    'أقر بتجديد بطاقتي الشخصية برقم وطني:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  _buildTextField(
                    'الرقم الوطني',
                    controller: nationalNumberController,
                    isNumber: true,
                    maxLength: 11,
                    isRequired: true,
                  ),
                  _buildDatePickerField(
                    'تاريخ تجديد البطاقة',
                    controller: renewalDateController,
                    selectedDate: selectedRenewalDate,
                    onDatePicked: (date) {
                      setState(() {
                        selectedRenewalDate = date;
                        renewalDateController.text = _formatDate(date);
                        _checkFormValidity();
                      });
                    },
                    isRequired: true,
                  ),
                  const Text(
                    'وأن جميع البيانات المذكورة أعلاه صحيحة وعلى مسؤوليتي.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    'تاريخ الطلب:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  _buildDatePickerField(
                    'تاريخ الطلب',
                    controller: requestDateController,
                    selectedDate: selectedRequestDate,
                    onDatePicked: (date) {
                      setState(() {
                        selectedRequestDate = date;
                        requestDateController.text = _formatDate(date);
                        _checkFormValidity();
                      });
                    },
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: isButtonEnabled
                          ? () => _showSuccessNotification(context)
                          : null,
                      style: TextButton.styleFrom(
                        foregroundColor:
                            isButtonEnabled ? kPrimaryColor : Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor:
                            isButtonEnabled ? Colors.white : Colors.grey,
                        minimumSize: const Size(200, 50), // تحديد حجم الزر
                      ),
                      child: const Text('تجديد بطاقتي'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText,
      {TextEditingController? controller,
      bool isNumber = false,
      int maxLength = 0,
      bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLength: maxLength > 0 ? maxLength : null,
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
        validator: isRequired
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDatePickerField(String hintText,
      {TextEditingController? controller,
      DateTime? selectedDate,
      required Function(DateTime) onDatePicked,
      bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
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
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    surface: kPrimaryColor,
                    onSurface: Colors.white,
                  ),
                  dialogBackgroundColor: kPrimaryColor,
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            onDatePicked(picked);
          }
        },
        validator: isRequired
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                return null;
              }
            : null,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.toLocal()}".split(' ')[0];
  }

  Widget _buildDropdownField(String hintText, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
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
        dropdownColor: kPrimaryColor,
        style: const TextStyle(color: Colors.white),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
