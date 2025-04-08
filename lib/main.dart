import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lastcard/pages/firstone.dart';
import 'package:lastcard/pages/login_page.dart';
import 'package:lastcard/pages/register_page.dart';
import 'package:lastcard/pages/services_page.dart';
//import 'package:lastcard/pages/profile_page.dart';
import 'package:lastcard/providers/authentication.dart';
import 'package:lastcard/widgest/nav_drawer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is ready before async operations
  await GetStorage.init(); // Initialize GetStorage

  runApp(
    ChangeNotifierProvider(
      create: (context) => Auth(),
      child: const FirstPage(),
    ),
  );
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), // تأكد من أن التطبيق يستخدم العربية
      builder: (context, child) {
        //جعل كل الصفحات من اليمين الى اليسار
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      routes: {
        'FirstOne': (context) => const FirstOne(),
        'LoginPage': (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        'ServicesPage': (context) => ServicesPage(),
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == 'ProfilePage') {
      //     final args = settings.arguments as Map<String, dynamic>?;
      //     return MaterialPageRoute(
      //       builder: (context) => ProfilePage(
      //         user_Fullname: args?['user_Fullname'] ?? '',
      //         phone_number: args?['phone_number'] ?? '',
      //         user_NationalId: args?['user_NationalId'] ?? '',
      //         user_DOB: args?['user_DOB'] ?? '',
      //         user_BirthPlace: args?['user_BirthPlace'] ?? '',
      //         user_Gender: args?['user_Gender'] ?? '',
      //         user_MaritalStatus: args?['user_MaritalStatus'] ?? '',
      //         user_Address: args?['user_Address'] ?? '',
      //         user_EducationLevel: args?['user_EducationLevel'] ?? '',
      //         user_Nationality: args?['user_Nationality'] ?? '',
      //         user_Profession: args?['user_Profession'] ?? '',
      //         imagePath: args?['imagePath'] ?? '',
      //       ),
      //     );
      //   }
      //   return null; // إذا لم يتم العثور على الصفحة المطلوبة
      // },
      initialRoute: 'FirstOne', // الصفحة الافتراضية عند تشغيل التطبيق
      home: const Scaffold(
        drawer: NavDrawer(),
        body: Center(child: Text('Home Page')),
      ),
    );
  }
}
