import 'package:flutter/material.dart';
import 'package:lastcard/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'من نحن',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 117, 144, 175),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: kPrimaryColor,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child:Directionality(textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // إضافة صورة هنا
              Center(
                child: Image.asset(
                  'assets/images/id_card.png', // مسار الصورة في مجلد assets
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'مرحبًا بكم في تطبيق هوية المواطن',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'عن التطبيق:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'تطبيق "هوية المواطن" هو منصة إلكترونية تهدف إلى أتمتة إصدار البطاقات الشخصية بشكل سريع وسهل. نحن نقدم خدمات إصدار البطاقات الوطنية، تجديدها، استبدالها في حالة الفقد، وتعديل البيانات الشخصية دون الحاجة إلى زيارة المراكز الحكومية.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'مهمتنا:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'نسعى إلى تبسيط الإجراءات الحكومية وتوفير الوقت والجهد على المواطنين من خلال تقديم خدمات إلكترونية آمنة وسهلة الاستخدام.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'ميزات التطبيق:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.white),
                    title: Text(
                      'إصدار بطاقة وطنية جديدة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.white),
                    title: Text(
                      'تجديد البطاقة الوطنية',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.white),
                    title: Text(
                      'استبدال البطاقة في حالة الفقد',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.white),
                    title: Text(
                      'تعديل البيانات الشخصية',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.white),
                    title: Text(
                      'خدمات آمنة وسريعة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'فريق العمل:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'نحن فريق من المطورين والمصممين واختصاصيي الخدمات الحكومية يعملون معًا لتقديم أفضل تجربة للمستخدمين.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'اتصل بنا:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'للاستفسارات أو الدعم الفني، يرجى التواصل معنا عبر البريد الإلكتروني: amohammed37@gmail.ocm أو الاتصال على الرقم: 779876567.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}