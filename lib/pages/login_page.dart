import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lastcard/pages/services_page.dart';
import 'package:lastcard/widgest/custom_text_field.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/register_page.dart';
import 'package:lastcard/pages/forgotpassword_page.dart';

//api
class APIService {
  final Dio _dio = Dio();

  Future<bool> loginUser(String phone, String password) async {
    try {
      Response response = await _dio.post(
        "http://192.168.1.105:8000/api/login",
        data: {"phone": phone, "password": password},
      );

      if (response.statusCode == 200) {
        return true; // نجاح تسجيل الدخول
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}

//

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, bool> fieldErrors = {};
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController phone_numberController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isLoading = false;

//api
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool success = await APIService()
          .loginUser(phone_numberController.text, _passwordController.text);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ServicesPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل تسجيل الدخول، تأكد من البيانات")),
        );
      }
    }
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 144, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/images/icon.png',
                height: 200,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مصلحة الأحوال المدنية',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 65,
              ),
              const Row(
                children: [
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildNumberField('رقم الهاتف', 9, phone_numberController),
              CustomTextField(
                hintText: 'كلمة المرور',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                obscureText: _isPasswordHidden,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
                controller: _passwordController, // إضافة المتحكم هنا
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال كلمة المرور'; // رسالة الخطأ
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  // : ElevatedButton(
                  //     onPressed: () async {
                  //       if (_formKey.currentState!.validate()) {
                  //         setState(() {
                  //           _isLoading = true;
                  //         });

                  //         // await login(); // استدعاء دالة تسجيل الدخول

                  //         setState(() {
                  //           _isLoading = false;
                  //         });

                  //         // ignore: use_build_context_synchronously
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => ServicesPage(),
                  //           ),
                  //         );
                  //       }
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.white, // لون الزر أبيض
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius:
                  //             BorderRadius.circular(10), // تعديل الزوايا
                  //       ),
                  //       minimumSize: const Size(250, 50), // تعيين العرض والارتفاع
                  //     ),
                  //     child: const Text(
                  //       'تسجيل الدخول',
                  //       style: TextStyle(
                  //         color:
                  //             kPrimaryColor, // لون النص بنفس لون التطبيق الأساسي
                  //         fontSize: 18, // حجم النص
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  : ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(250, 50),
                      ),
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }),
                      );
                    },
                    child: const Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      '        إنشاء حساب',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
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
                      fieldErrors['phone'] = true;
                    });
                  } else {
                    setState(() {
                      fieldErrors['phone'] = false;
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
          //   keyboardType: TextInputType.phone,
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
          //             fieldErrors['phone'] = true;
          //           });
          //         } else {
          //           setState(() {
          //             fieldErrors['phone'] = false;
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
          //       Icons.phone, // أيقونة الهاتف
          //       color: Colors.white,
          //     ),
          //   ),
          //   style: const TextStyle(color: Colors.white),
          // ),
          if (hintText == 'رقم الهاتف' && fieldErrors['phone'] == true)
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
