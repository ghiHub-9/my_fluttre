// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:lastcard/constants.dart';
// import 'package:image_picker/image_picker.dart'; // لاستخدام XFile
// import 'package:barcode_widget/barcode_widget.dart';  // استيراد مكتبة الباركود

// class CardPage extends StatelessWidget {
//   final String fullName;
//   final String birthDate;
//   final String citizenBloodType;
//   final String village;
//   final XFile image;

//   const CardPage({
//     super.key,
//     required this.fullName,
//     required this.birthDate,
//     required this.citizenBloodType,
//     required this.village,
//     required this.image,
//   });

//   // توليد رقم وطني عشوائي يبدأ بـ 0 ويتكون من 11 رقمًا
//   String generateNationalId() {
//     final Random random = Random();
//     String randomDigits = List.generate(10, (_) => random.nextInt(10).toString()).join();
//     return "0$randomDigits";
//   }

//   @override
//   Widget build(BuildContext context) {
//     String nationalId = generateNationalId();

//      return Directionality( // ← إضافة Directionality هنا
//       textDirection: TextDirection.ltr, // ← جعل هذه الصفحة فقط من اليسار إلى اليمين
//       child: Scaffold(
//         backgroundColor: kPrimaryColor,
//       appBar: AppBar(
//         title: const Text("البطاقة الشخصية"),
//         backgroundColor: const Color.fromARGB(255, 117, 144, 175),
//       ),
//       body: Center(
//         child: Container(
//           width: 380,
//           height: 270, // زيادة ارتفاع البطاقة لاستيعاب الباركود
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
//           ),
//           child: Stack(
//             children: [
//               // الجهة اليمنى (النصوص الرسمية)
//               const Positioned(
//                 top: 10,
//                 right: 10,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text("الجمهورية اليمنية", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     Text("وزارة الداخلية", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     Text("مصلحة الأحوال المدنية والسجل المدني", style: TextStyle(fontSize: 14)),
//                   ],
//                 ),
//               ),

//               // شعار الجمهورية اليمنية
//               Positioned(
//                 top: 10,
//                 right: 140,
//                 child: Image.asset("assets/images/yemen_logo.png", width: 80),
//               ),

//               // نص "بطاقة شخصية"
//               const Positioned(
//                 top: 105,
//                 right: 120,
//                 child: Text(
//                   "بطاقة شخصية",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: kPrimaryColor,
//                   ),
//                 ),
//               ),

//               //  (الآن يدعم الصور المختارة من المعرض أو الكاميرا) صورة المستخدم الرئيسية
//               Positioned(
//                 top: 10,
//                 left: 10,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   // ignore: unnecessary_null_comparison
//                   child: image != null
//                       // ? Image.file(image, width: 80, height: 100, fit: BoxFit.cover)
//                       // : const Icon(Icons.person, size: 80, color: Colors.grey), // صورة افتراضية
//                       ? Image.file(
//                           File(image.path), // تحويل XFile إلى File
//                           width: 80,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                       : const Icon(Icons.person, size: 80, color: Colors.grey), // صورة افتراضية
//                 ),
//               ),

//               // البيانات الشخصية
//               const Positioned(
//                 bottom: 88,
//                 right: -10,
//                 child: Text("الرقم الوطني     " , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
//               ),
//               Positioned(
//                 top: 140,
//                 bottom: 60,
//                 right: 120,
//                 // ignore: unnecessary_string_interpolations
//                 child: Text("$nationalId", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor)),
//               ),
//               Positioned(
//                 top: 160,
//                 bottom: 40,
//                 right: 130,
//                 // ignore: unnecessary_string_interpolations
//                 child: Text( "$fullName", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               ),
//               const Positioned(
//                 bottom: 23,
//                 right: -10,
//                 child: Text("مكان وتاريخ الميلاد     " , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
//               ),
//               Positioned(
//                 bottom: 20,
//                 right: 130,
//                 child: Text("$village - $birthDate", style: const TextStyle(fontSize: 16)),
//               ),

//               // صورة المستخدم الصغيرة في الأسفل يمين
//               Positioned(
//                 bottom: 48,
//                 left: 300,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   // ignore: unnecessary_null_comparison
//                   child: image != null
//                       // ? Image.file(image, width: 80, height: 100, fit: BoxFit.cover)
//                       // : const Icon(Icons.person, size: 80, color: Colors.grey), // صورة افتراضية
//                     ? Image.file(
//                           File(image.path), // تحويل XFile إلى File
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                         )
//                       : const Icon(Icons.person, size: 80, color: Colors.grey), // صورة افتراضية
//                 ),
//               ),

//               // فصيلة الدم
//               const Positioned(
//                 bottom: 8,
//                 right: 10,
//                 child: Text(
//                   "فصيلة الدم",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//               ),
//               Positioned(
//                 bottom: -2,
//                 right: 25,
//                 // ignore: unnecessary_string_interpolations
//                 child: Text("$citizenBloodType", style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const Positioned(
//                 bottom: 1,
//                 left: 20,
//                 child: Text(
//                   "4/A",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//               ),

//               //الباركود الذي يحوي الرقم الوطني
//               Positioned(
//                 bottom: -1, // الباركود في أسفل البطاقة
//                 left: 65,
//                 child: BarcodeWidget(
//                   barcode: Barcode.code128(), // نوع الباركود
//                   data: nationalId, // الرقم الوطني
//                   width: 200,
//                   height: 25,
//                   drawText: false, // إخفاء الرقم من تحت الباركود
//               ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unnecessary_null_comparison

import 'dart:ui' as ui;

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lastcard/constants.dart';
import 'package:image_picker/image_picker.dart'; // لاستخدام XFile
import 'package:barcode_widget/barcode_widget.dart'; // استيراد مكتبة الباركود

class CardPage extends StatelessWidget {
  final String fullName;
  final String birthDate;
  final String citizenBloodType;
  final String village;
  final XFile image;
  final String branch; // الفرع الذي اختاره المستخدم
  // final String issueDate; // تاريخ الإصدار
  // final String expirationDate; // تاريخ الانتهاء

  const CardPage({
    super.key,
    required this.fullName,
    required this.birthDate,
    required this.citizenBloodType,
    required this.village,
    required this.image,
    required this.branch,
    // required this.issueDate,
    // required this.expirationDate,
  });

  // توليد رقم وطني عشوائي يبدأ بـ 0 ويتكون من 11 رقمًا
  String generateNationalId() {
    final Random random = Random();
    String randomDigits =
        List.generate(10, (_) => random.nextInt(10).toString()).join();
    return "0$randomDigits";
  }

  @override
  Widget build(BuildContext context) {
    String nationalId = generateNationalId();

    // الحصول على التاريخ الحالي
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyy-MM-dd').format(now);

    // حساب تاريخ الانتهاء (10 سنوات ناقص يوم واحد)
    DateTime expirationDate = DateTime(now.year + 10, now.month, now.day - 1);
    String formattedExpirationDate =
        DateFormat('yyyy-MM-dd').format(expirationDate);

    // return Directionality(
    //   textDirection: TextDirection.ltr,
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: const Text("البطاقة الشخصية"),
          backgroundColor: const Color.fromARGB(255, 117, 144, 175),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // البطاقة الأولى
                const SizedBox(height: 60),
                Container(
                  width: 380,
                  height: 270,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ],
                  ),
                  child: Stack(
                    children: [
                      // الجهة اليمنى (النصوص الرسمية)
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("الجمهورية اليمنية",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("وزارة الداخلية",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("مصلحة الأحوال المدنية والسجل المدني",
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),

                      // شعار الجمهورية اليمنية
                      Positioned(
                        top: 10,
                        right: 140,
                        child: Image.asset("assets/images/yemen_logo.png",
                            width: 80),
                      ),

                      // نص "بطاقة شخصية"
                      const Positioned(
                        top: 105,
                        right: 120,
                        child: Text(
                          "بطاقة شخصية",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),

                      // صورة المستخدم الرئيسية
                      Positioned(
                        top: 10,
                        left: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: image != null
                              ? Image.file(
                                  File(image.path),
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.person,
                                  size: 80, color: Colors.grey),
                        ),
                      ),

                      // البيانات الشخصية
                      const Positioned(
                        bottom: 88,
                        right: -10,
                        child: Text("الرقم الوطني     ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Positioned(
                        top: 140,
                        bottom: 60,
                        right: 120,
                        child: Text("$nationalId",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor)),
                      ),
                      Positioned(
                        top: 160,
                        bottom: 40,
                        right: 130,
                        child: Text("$fullName",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      const Positioned(
                        bottom: 23,
                        right: -10,
                        child: Text("مكان وتاريخ الميلاد     ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 130,
                        child: Text("$village - $birthDate",
                            style: const TextStyle(fontSize: 16)),
                      ),

                      // صورة المستخدم الصغيرة في الأسفل يمين
                      Positioned(
                        bottom: 48,
                        left: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: image != null
                              ? Image.file(
                                  File(image.path),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.person,
                                  size: 80, color: Colors.grey),
                        ),
                      ),

                      // فصيلة الدم
                      const Positioned(
                        bottom: 8,
                        right: 10,
                        child: Text(
                          "فصيلة الدم",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: 25,
                        child: Text("$citizenBloodType",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ),
                      const Positioned(
                        bottom: 1,
                        left: 20,
                        child: Text(
                          "4/A",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      // الباركود الذي يحوي الرقم الوطني
                      Positioned(
                        bottom: -1,
                        left: 65,
                        child: BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: nationalId,
                          width: 200,
                          height: 25,
                          drawText: false,
                        ),
                      ),
                    ],
                  ),
                ),

                // البطاقة الثانية
                Container(
                  width: 380,
                  height: 270,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ],
                  ),
                  child: Stack(
                    children: [
                      // جهة الإصدار
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("جهة الإصدار",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // جهة الإصدار
                      Positioned(
                        top: 10,
                        right: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("$branch",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // تاريخ الإصدار
                      const Positioned(
                        top: 30,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("تاريخ الإصدار",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // تاريخ الإصدار
                      Positioned(
                        top: 30,
                        right: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(currentDate,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // تاريخ الانتهاء
                      const Positioned(
                        top: 50,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("تاريخ الانتهاء",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // تاريخ الانتهاء
                      Positioned(
                        top: 50,
                        right: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(formattedExpirationDate,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // نص "البطاقة وثيقة هامة يجب الحفاظ عليها"
                      const Positioned(
                        top: 70,
                        right: 10,
                        child: Text(
                          " البطاقة وثيقة هامة يجب الحفاظ عليها  -",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),

                      // نص "في حالة فقدان البطاقة أو تلفها يجب إبلاغ أقرب مركز شرطة"
                      const Positioned(
                        top: 90,
                        right: 10,
                        child: Text(
                          " في حالة فقدان البطاقة أو تلفها يجب إبلاغ أقرب مركز شرطة  -",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),

                      // شعار الجمهورية اليمنية
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Image.asset("assets/images/backCard.png",
                            width: 80),
                      ),

                      // الباركود
                      Positioned(
                        top: 95,
                        left: 5,
                        right: 5,
                        bottom: 1,
                        child: Image.asset("assets/images/barcodSecondCard.png",
                            width: 330),
                      ),
                    

                          // رقم البطاقة
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Row(
                              children: [
                                Text(nationalId,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),

                      const Positioned(
                        bottom: 1,
                        left: 10,
                        child: Row(
                          children: [
                            Text("C03CF3",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
