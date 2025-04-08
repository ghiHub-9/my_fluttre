// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

//import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lastcard/constants/const.dart';
import 'package:lastcard/controllers/auth/register_controller.dart';
import 'package:lastcard/pages/login_page.dart';
import 'package:lastcard/widgest/custom_text_field.dart';
import 'package:lastcard/constants.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = '/RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterController registerController = Get.put(RegisterController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _user_FullnameController =
      TextEditingController();
  final TextEditingController phone_numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, bool> fieldErrors = {};
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  //

// دالة التسجيل في API

// Future<void> registerUser() async {
//  // final String apiUrl = '${APIConfig.baseUrl}/register'; // استخدم APIConfig.baseUrl
// final String apiUrl = APIConfig.registerEndpoint;
//
//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "first_name": _user_FullnameController.text,
//         "phone_number_number": phone_numberController.text,
//         "password": _passwordController.text,
//       }),
//     );
//
//     final responseData = jsonDecode(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تم التسجيل بنجاح! يمكنك الآن تسجيل الدخول')),
//       );
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ أثناء التسجيل: ${responseData["message"] ?? "حدث خطأ غير معروف"}')),
//       );
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('خطأ أثناء الاتصال بالخادم: $e')),
//     );
//   }
// }


// Future<void> registerUser() async {
//   final dio = Dio();
//   const String apiUrl = 'http://192.168.1.105/api/register'; // عنوان API

//   try {
//     final response = await dio.post(
//       apiUrl,
//       data: {
//         "fullname": _user_FullnameController.text,
//         "phone_number": phone_numberController.text,
//         "password": _passwordController.text,
//       },
//       options: Options(
//         headers: {"Content-Type": "application/json"},
//       ),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تم التسجيل بنجاح! يمكنك الآن تسجيل الدخول')),
//       );

//       // الانتقال إلى صفحة تسجيل الدخول بعد نجاح التسجيل
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('حدث خطأ أثناء التسجيل: ${response.data['message']}')),
//       );
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('حدث خطأ أثناء الاتصال بالخادم: $e')),
//     );
//   }
// }



  //

  // Future<void> registerUser() async {
  //   final dio = Dio();
  //   const String apiUrl =
  //       'http://127.0.0.1:8000/api/register'; // استبدلها بعنوان API الخاص بك

  //   try {
  //     final response = await dio.post(
  //       apiUrl,
  //       data: {
  //         "fullname": _user_FullnameController.text,
  //         "phone_number": phone_numberController.text,
  //         "password": _passwordController.text,
  //       },
  //       options: Options(
  //         headers: {"Content-Type": "application/json"},
  //       ),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // تم التسجيل بنجاح
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text('تم التسجيل بنجاح! يمكنك الآن تسجيل الدخول')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content:
  //                 Text('حدث خطأ أثناء التسجيل: ${response.data['message']}')),
  //       );
  //     }
  //   } catch (e) {
  //     // عرض رسالة الخطأ
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('حدث خطأ أثناء الاتصال بالخادم: $e')),
  //     );
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 117, 144, 175), // لون الخلفية
        title: const Text(
          'إنشاء حساب',
          style: TextStyle(color: Colors.white), // لون النص
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, 'LoginPage');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey, // ربط Form بـ _formKey
          child: ListView(
            children: [
              const SizedBox(height: 40),
              CustomTextField(
                controller: _user_FullnameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال الاسم الرباعي '; // رسالة الخطأ
                  }
                  return null;
                },
                hintText: 'الاسم الرباعي',
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                obscureText: false,
              ),
              const SizedBox(height: 20),

              _buildNumberField('رقم الهاتف', 9, phone_numberController),

              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال كلمة المرور  '; // رسالة الخطأ
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'كلمة المرور',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: _isPasswordHidden,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 60),

              //  // زر انشاء حساب
              //   SizedBox(
              //     width: double.infinity, // لتحديد عرض الزر بالكامل
              //     height: 50, // تعديل الارتفاع كما تريد
              //     child: ElevatedButton(
              //       onPressed: LoginPage,
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white, // لون الزر أبيض
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10), // تعديل الزوايا
              //         ),
              //       ),
              //       child: const Text(
              //         'إنشاء حساب',
              //         style: TextStyle(
              //           color: kPrimaryColor, // لون النص
              //           fontSize: 18, // حجم النص
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),

              // // زر انشاء حساب
              // SizedBox(
              //   width: double.infinity, // جعل الزر يأخذ العرض بالكامل
              //   height: 50, // تحديد الارتفاع
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       if (_formKey.currentState!.validate()) {
              //         setState(() {
              //           _isLoading = true; // تشغيل مؤشر التحميل
              //         });

              //         await Future.delayed(
              //             const Duration(seconds: 2)); // محاكاة عملية التسجيل

              //         setState(() {
              //           _isLoading = false; // إيقاف مؤشر التحميل
              //         });

              //         // الانتقال إلى صفحة تسجيل الدخول
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const LoginPage(),
              //           ),
              //         );
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.white, // لون الزر أبيض
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10), // تعديل الزوايا
              //       ),
              //     ),
              //     child: _isLoading
              //         ? const CircularProgressIndicator(
              //             color: kPrimaryColor) // عرض مؤشر تحميل أثناء الانتظار
              //         : const Text(
              //             'إنشاء حساب',
              //             style: TextStyle(
              //               color: kPrimaryColor, // لون النص
              //               fontSize: 18, // حجم النص
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //   ),
              // ),

              ///
              // زر انشاء حساب
              SizedBox(
                width: double.infinity, // جعل الزر يأخذ العرض بالكامل
                height: 50, // تحديد الارتفاع
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {


                      registerController.registerUser(
                        firstName: _user_FullnameController.text.trim(),
                        phoneNumber: phone_numberController.text.trim(),
                        password: _passwordController.text,
                      );

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // لون الزر أبيض
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // تعديل الزوايا
                    ),
                  ),
                  child: Obx(
                        ()=>registerController.isLoading.value
                        ? const CircularProgressIndicator(color: kPrimaryColor)
                        :const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        color: kPrimaryColor, // لون النص
                        fontSize: 18, // حجم النص
                        fontWeight: FontWeight.bold,
                      ),
                    ),),

                ),
              ),

              ///

              // _isLoading
              //     ? const Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.white,
              //         ),
              //       )
              //     : CustomButton(
              //         text: 'إنشاء حساب ',
              //         onPressed: () async {
              //           if (_formKey.currentState!.validate()) {
              //             setState(() {
              //               _isLoading = true;
              //             });
              //             await registerUser(); // استدعاء الـ API
              //             await Future.delayed(const Duration(seconds: 2));

              //             setState(() {
              //               _isLoading = false;
              //             });

              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => const LoginPage(),
              //               ),
              //             );
              //           }
              //         },
              //       ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Text(
                  //   'تملك حساب مسبقاً',
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'LoginPage');
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField(
      String hintText, int maxLength, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب إدخال رقم الهاتف';
              }
              if (value.length != 9) {
                return 'رقم الهاتف يجب أن يكون 9 أرقام';
              }
              if (!RegExp(r'^(73|71|70|78|77)').hasMatch(value)) {
                return 'يجب أن يبدأ الرقم بـ 77 أو 73 أو 71 أو 70 أو 78';
              }
              return null;
            },
            maxLength: maxLength,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              if (hintText == 'رقم الهاتف') {
                if (value.isEmpty) {
                  return;
                }

                if (value.length >= 2) {
                  RegExp regex = RegExp(r'^(73|71|70|78|77)');

                  if (!regex.hasMatch(value)) {
                    controller.clear();
                    setState(() {
                      fieldErrors['phone_number'] = true;
                    });
                  } else {
                    setState(() {
                      fieldErrors['phone_number'] = false;
                    });
                  }
                }
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          // TextFormField(
          //   controller: controller,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'يجب إدخال رقم الهاتف'; // رسالة الخطأ
          //     }
          //     return null;
          //   },
          //   maxLength: maxLength,
          //   keyboardType: TextInputType.phone_number,
          //   onChanged: (value) {
          //     if (hintText == 'رقم الهاتف') {
          //       if (value.isEmpty) {
          //         return;
          //       }

          //       // التحقق فقط بعد إدخال أول رقمين
          //       if (value.length >= 2) {
          //         RegExp regex = RegExp(r'^(73|71|70|78|77)');

          //         if (!regex.hasMatch(value)) {
          //           controller.clear(); // حذف الإدخال الخاطئ
          //           setState(() {
          //             fieldErrors['phone_number'] = true;
          //           });
          //         } else {
          //           setState(() {
          //             fieldErrors['phone_number'] = false;
          //           });
          //         }
          //       }
          //     }
          //   },
          //   decoration: InputDecoration(
          //     hintText: hintText,
          //     hintStyle: const TextStyle(color: Colors.white70),
          //     filled: true,
          //     fillColor: Colors.white.withOpacity(0.1),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: BorderSide.none,
          //     ),
          //     prefixIcon: const Icon(
          //       Icons.phone_number, // أيقونة الهاتف
          //       color: Colors.white,
          //     ),
          //   ),
          //   style: const TextStyle(color: Colors.white),
          // ),
          if (hintText == 'رقم الهاتف' && fieldErrors['phone_number'] == true)
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'يجب أن يبدأ الرقم بـ 77 او 73 او 71 او 70 او 78',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
