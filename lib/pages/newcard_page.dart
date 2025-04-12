// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; //for DateFormat
import 'package:lastcard/constants.dart';
import 'package:lastcard/controllers/new_card/new_card_controller.dart';
import 'package:lastcard/pages/BranchMapPage.dart';
import 'package:lastcard/pages/card_page.dart';
import 'package:lastcard/pages/services_page.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';

class NewCardPage extends StatefulWidget {
  const NewCardPage({super.key});

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {

  NewCardRequestController newCardRequestController = Get.put(NewCardRequestController());

  Map<String, bool> fieldErrors = {};

  void createNewRequest(String token) async {
  var response = await ApiService().createRequest(token, 1, "new_card");
  print(response.data);
}


  final picker = ImagePicker();

  final TextEditingController _dateController =
      TextEditingController(); //تاريخ ميلاد مقدم الطلب
  final TextEditingController _requestDateController =
      TextEditingController(); //تاريخ طلب البطاقة
  final TextEditingController _witness1DateController =
      TextEditingController(); //تاريخ حصول الشاهد الاول على البطاقة
  final TextEditingController _witness2DateController =
      TextEditingController(); //تاريخ حصول الشاهد الثاني على البطاقة

  // final TextEditingController _startdateController =
  //     TextEditingController(); //تاريخ اصدار البطاقة

  // final TextEditingController _enddateController =
  //     TextEditingController(); //تاريخ انتهاء البطاقة

  DateTime? selectedDate;
  DateTime? requestDate;
  DateTime? witness1Date;
  DateTime? witness2Date;

  bool isConfirmed = false;
  XFile? _selectedImage;
  XFile? _selectedImagepaper;
  String? selectedBranch;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile; // استخدام XFile مباشرة
      });
    }
  }

  Future<void> _pickImagepaper(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImagepaper = pickedFile; // استخدام XFile مباشرة
      });
    }
  }

  final TextEditingController witness1Name = TextEditingController();
  final TextEditingController witness1Work = TextEditingController();
  final TextEditingController witness1Phone = TextEditingController();
  final TextEditingController witness1CardNumber = TextEditingController();
  final TextEditingController witness1IssuePlace = TextEditingController();

  final TextEditingController witness2Name = TextEditingController();
  final TextEditingController witness2Work = TextEditingController();
  final TextEditingController witness2Phone = TextEditingController();
  final TextEditingController witness2CardNumber = TextEditingController();
  final TextEditingController witness2IssuePlace = TextEditingController();

  String? gender;
  bool isAcknowledged = false;
  final List<String> countries = [
    'اليمن',
    'الإمارات',
    'تونس',
    'سوريا',
    'السودان',
    'السعودية',
    'قطر',
    'فلسطين',
    'عمان',
    'المغرب',
    'موريتانيا',
    'ليبيا',
    'لبنان',
    'الكويت',
    'الأردن',
    'العراق',
    'مصر',
    'البحرين',
    'الجزائر'
  ];
  final List<String> birthCity = [
    'اليمن',
    'الإمارات',
    'تونس',
    'سوريا',
    'السودان',
    'السعودية',
    'قطر',
    'فلسطين',
    'عمان',
    'المغرب',
    'موريتانيا',
    'ليبيا',
    'لبنان',
    'الكويت',
    'الأردن',
    'العراق',
    'مصر',
    'البحرين',
    'الجزائر'
  ];
  final List<String> nationality = ['يمني'];
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

  final Map<String, List<String>> districts = {
    'أمانة العاصمة': [
      'آزال',
      'التحرير',
      'الثورة',
      'السبعين',
      'الصافية',
      'الوحدة',
      'بني الحارث',
      'شعوب',
      'صنعاء القديمة',
      'معين'
    ],
    'صنعاء': [
      'أرحب',
      'الطيال',
      'بني ضبيان',
      'صعفان',
      'الحصن',
      'بلاد الروس',
      'جحانة',
      'مناخة',
      'الحيمة الخارجية',
      'بني حشيش',
      'خولان',
      'نهم',
      'الحيمة الداخلية',
      'بني مطر',
      'سنحان وبني بهلول',
      'همدان'
    ],
    'الحديدة': [
      'الحديدة',
      'بيت الفقيه',
      'التحيتا',
      'زبيد',
      'الخوخة',
      'الدريهمي',
      'اللحية',
      'الحوك',
      'المغلاف'
    ],
    'تعز': [
      'الشمايتين',
      'تبن',
      'المخا',
      'حيفان',
      'جبل حبشي',
      'المعافر',
      'صالة',
      'القاهرة',
      'المظفر',
      'المواسط',
      'صبر الموادم'
    ],
    'عدن': [
      'التواهي',
      'المعلا',
      ' خور مكسر',
      'الشيخ عثمان',
      'دار سعد',
      'كريتر',
      'الممدارة'
    ],
    'ريمة': ['ريمة', 'الجرين'],
    'المحويت': ['المحويت', 'الرجم', ' البحدا'],
    'أبين': ['زنجبار', 'خنفر', 'لودر', 'جعار', 'مودية', 'المحفد'],
    'الجوف': ['خب والشعف', 'المتون', 'المصلوب', 'الحزم', 'الجوف'],
    'شبوة': ['الروضة', 'ميفعة', 'بيحان', 'جردان', 'نصاب', 'عتق'],
    'ذمار': [
      'بلاد الطعام',
      'الحداء',
      'آنس',
      'عتمة',
      'ميفعة عنس',
      'جهران',
      'ذمار'
    ],
    'مأرب': [
      'مأرب المدينة',
      'صرواح',
      'رغوان',
      'حريب',
      'الجوبة',
      'مجزر',
      'بدبدة',
      'ماهلية',
      'الوادي'
    ],
    'الضالع': [' الضالع', 'قعطبة', 'الحشاء', 'جبن', 'دمت', 'الأزارق', 'الشعيب'],
    'البيضاء': [
      ' البيضاء',
      'الزاهر',
      'الصومعة',
      'مكيراس',
      'رداع',
      'الطفة',
      'ناطع',
      'نعمان',
      'القريشية',
      'ولد ربيع',
      'السوادية'
    ],
    'حجة': [
      ' حجة',
      'عبس',
      'حيران',
      'المحابشة',
      'كشر',
      'كعيدنة',
      'الشغادرة',
      'أفلح اليمن',
      'أفلح الشام',
      ' خيران المحرق',
      'بني قيس',
      'القناوص',
      'مستبا',
      'المغربة',
      'أسلم'
    ],
    'عمران': [
      ' عمران',
      'خمر',
      'حوث',
      'ريدة',
      'حرف سفيان',
      'جبل عيال يزيد',
      'السودة',
      'ذيبين ',
      'أفلح الشام',
      ' القفلة ',
      ' المدان',
      'بني صريم',
      'عيال سريح'
    ],
    'المهرة': [
      'الغيظة',
      'سيحوت',
      'قشن',
      'حصوين',
      'المسيلة',
      'حوف',
      'منعر',
      'شحن'
    ],
    'لحج': [
      'الحوطة',
      'تبن',
      'طور الباحة',
      'المسيمير',
      'المفلحي',
      'ردفان',
      'حبيل جبر',
      'يافع',
      'القبيطة'
    ],
    'صعدة': [
      'صعدة',
      'كتاف والبقع',
      'رازح ',
      'غمر',
      'باقم',
      'ساقين',
      'حيدان ',
      'الصفراء',
      'مجز',
      'شدا',
      'ضحيان'
    ],
    'إب': [
      'إب',
      ' القفر',
      'السدة ',
      'العدين',
      'جبلة',
      ' يريم',
      'ذي السفال ',
      'النادرة',
      'المخادر',
      'بعدان',
      'الشعر'
    ],
    'حضرموت': [
      'عمد',
      ' شبام',
      'غيل باوزير ',
      'الريدة وقصيعر',
      'الديس الشرقية',
      ' وادي العين',
      'القطن  ',
      'تريم',
      'سيئون',
      'الشحر',
      'المكلا',
      'حورة',
      'يبعث'
    ],
  };

  String? selectedBloodType; // متغير لتخزين القيمة المختارة
  String? selectedbranch;
  String? selectedDistricts;
  String? selectedgovernorates;
  final List<String> religions = ['مسلم'];
  final List<String> maritalStatuses = ['عازب', 'متزوج'];
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  final List<String> educationLevels = [
    'ثانوية',
    'بكالوريوس',
    'ماجستير',
    'دكتوراه'
  ];

  final TextEditingController citizenNameController = TextEditingController();
  final TextEditingController citizenFathernameController =
      TextEditingController();
  final TextEditingController citizenGrandFathernameController =
      TextEditingController();
  final TextEditingController citizenLastnameController =
      TextEditingController();
  final TextEditingController requestDateController = TextEditingController();
  final TextEditingController promulgateDateController =
      TextEditingController();
  final TextEditingController villageController = TextEditingController();

  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController fatherDadnameController = TextEditingController();
  final TextEditingController fatherGrandnameController =
      TextEditingController();
  final TextEditingController fatherLastnameController =
      TextEditingController();
  final TextEditingController fatherNationalityController =
      TextEditingController();

  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController motherDadnameController = TextEditingController();
  final TextEditingController motherGrandnameController =
      TextEditingController();
  final TextEditingController motherLastnameController =
      TextEditingController();
  final TextEditingController motherNationalityController =
      TextEditingController();

  final TextEditingController citizenHighCertificateController =
      TextEditingController();
  final TextEditingController citizenMajoredController =
      TextEditingController();
  final TextEditingController citizenProfessionController =
      TextEditingController();
  final TextEditingController citizenWorkplaceController =
      TextEditingController();
  final TextEditingController citizenIsolationController =
      TextEditingController();
  final TextEditingController citizenNeighborhoodController =
      TextEditingController();
  final TextEditingController citizenStreetController = TextEditingController();
  final TextEditingController citizenHouseController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController witness1PhoneController = TextEditingController();
  final TextEditingController witness2PhoneController = TextEditingController();
  final TextEditingController witness1nationalID = TextEditingController();
  final TextEditingController witness2nationalID = TextEditingController();

  bool isAcknowledgmentChecked = false;

  bool get isAllFieldsFilled =>
      isAcknowledgmentChecked &&
      _selectedImage != null &&
      _selectedImagepaper != null &&
      _dateController.text.isNotEmpty &&
      selectedBloodType != null &&
      requestDateController.text.isNotEmpty &&
      promulgateDateController.text.isNotEmpty;

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 18),
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
                        'اضغط لاختيار صورة',
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

  Widget _buildImagePickerFieldforPaper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('الوثائق :'),
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
                        _pickImagepaper(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.image, color: kPrimaryColor),
                      title: const Text('اختر من المعرض'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImagepaper(ImageSource.gallery);
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
            child: _selectedImagepaper != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_selectedImagepaper!.path), // تحويل XFile إلى File
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
                        'اضغط لإدراج صورة لشهادة الميلاد',
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
              'صورة شهادة الميلاد مطلوبة',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 144, 175),
        title: const Text(
          'إصدار الهوية الوطنية',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'مقدم الطلب :',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              _buildTextFieldWithController(
                  'اسم الفرد', citizenNameController, 'citizenName'),
              _buildTextFieldWithController(
                  'اسم الأب', citizenFathernameController, 'citizenFathername'),
              _buildTextFieldWithController('اسم الجد',
                  citizenGrandFathernameController, 'citizenGrandFathername'),
              _buildTextFieldWithController(
                  'اللقب', citizenLastnameController, 'citizenLastname'),
              _buildDropdownField('الجنسية', nationality),
              const SizedBox(height: 20),
              const Text(
                'اسم الأب :',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              _buildTextFieldWithController(
                  'اسم الفرد', fatherNameController, 'fatherName'),
              _buildTextFieldWithController(
                  'اسم الأب', fatherDadnameController, 'fatherDadname'),
              _buildTextFieldWithController(
                  'اسم الجد', fatherGrandnameController, 'fatherGrandname'),
              _buildTextFieldWithController(
                  'اللقب', fatherLastnameController, 'fatherLastname'),
              _buildDropdownField('الجنسية', nationality),
              const SizedBox(height: 20),
              const Text(
                'اسم الأم :',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              _buildTextFieldWithController(
                  'اسم الفرد', motherNameController, 'motherName'),
              _buildTextFieldWithController(
                  'اسم الأب', motherDadnameController, 'motherDadname'),
              _buildTextFieldWithController(
                  'اسم الجد', motherGrandnameController, 'motherGrandname'),
              _buildTextFieldWithController(
                  'اللقب', motherLastnameController, 'motherLastname'),
              _buildDropdownField('الجنسية', nationality),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    ' النوع :',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Radio(
                    value: 'ذكر',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const Text('ذكر', style: TextStyle(color: Colors.white)),
                  Radio(
                    value: 'أنثى',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const Text('أنثى', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              _buildDatePickerField('تاريخ الميلاد', _dateController,
                  (pickedDate) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }),
              const SizedBox(height: 20),
              const Text(
                ' محل الميلاد :',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              _buildDropdownField('دولة الميلاد', birthCity),
              _buildTextFieldWithController(
                  'عزلة/قرية', villageController, 'village'),
              const SizedBox(height: 20),
              _buildDropdownField('الديانة', religions),
              _buildDropdownField('الحالة الاجتماعية', maritalStatuses),
              _buildDropdownField('فصيلة الدم', bloodTypes,
                  selectedValue: selectedBloodType, onChanged: (newValue) {
                setState(() {
                  selectedBloodType = newValue;
                });
              }),

              _buildDropdownField('الحالة التعليمية', educationLevels),
              _buildTextFieldWithController('اسم أعلى شهادة',
                  citizenHighCertificateController, 'citizenHighCertificate'),
              _buildTextFieldWithController(
                  'التخصص', citizenMajoredController, 'citizenMajored'),
              _buildTextFieldWithController(
                  'المهنة', citizenProfessionController, 'citizenProfession'),
              _buildTextFieldWithController(
                  'جهة العمل', citizenWorkplaceController, 'citizenWorkplace'),
              const SizedBox(height: 20),
              const Text(
                'العنوان :',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              _buildDropdownField('دولة الإقامة', countries),
              _buildDropdownField('المحافظة', governorates),
              if (selectedgovernorates != null)
                _buildDropdownField(
                  'المديرية',
                  districts[selectedgovernorates] ?? [],
                ),
              _buildTextFieldWithController(
                  'العزلة', citizenIsolationController, 'citizenIsolation'),
              _buildTextFieldWithController(
                  'الحي', citizenNeighborhoodController, 'citizenNeighborhood'),
              _buildTextFieldWithController(
                  'الشارع', citizenStreetController, 'citizenStreet'),
              _buildTextFieldWithController(
                  'المنزل', citizenHouseController, 'citizenHouse'),
              _buildNumberField('رقم الهاتف', 9, phoneController),
              const SizedBox(height: 20),
              _buildImagePickerField(),

              // الإقرار
              CheckboxListTile(
                title: const Text(
                    'أقر بأن جميع البيانات الواردة أعلاه صحيحة وأنه لم يسبق لي الحصول على بطاقة شخصية من قبل وعلى مسؤوليتي.',
                    style: TextStyle(color: Colors.white)),
                value: isConfirmed,
                onChanged: (value) {
                  setState(() {
                    isConfirmed = value ?? false;
                  });
                },
                tileColor: Colors.transparent, // إزالة الخلفية البيضاء
                checkColor: kPrimaryColor, // لون علامة الاختيار
                activeColor: Colors.white, // لون الإطار
              ),
              const SizedBox(height: 20),

              // تاريخ الطلب
              _buildDatePickerField('تاريخ الطلب', _requestDateController,
                  (pickedDate) {
                setState(() {
                  requestDate = pickedDate;
                });
              }),
              const SizedBox(height: 20),

              // الشهود
              const Text(
                'نشهد نحن الموقعين على هذا بأن الأخ والمرفقة صورته أعلاه معروف لدينا وأن جميع البيانات أعلاه صحيحة وأنه متمتع بالجنسية اليمنية وعلى مسؤوليتنا.',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),

              // الشاهد الأول
              const Text('الشاهد الأول:',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              _buildTextFieldWithController(
                  'الاسم', witness1Name, 'witness1Name'),
              _buildTextFieldWithController(
                  'جهة العمل ومقرها', witness1Work, 'witness1Work'),
              _buildNumberField('رقم الهاتف', 9, witness1PhoneController),
              _buildDropdownField('نوع البطاقة', [
                'شخصية',
                'جامعية',
                'لاجئي',
                'العمل',
                'التأمين الصحي',
                'القيادة',
                'ضمان اجتماعي',
                'الائتمان/الخصم البنكية',
                'العضوية',
                'السفر (الجواز الإلكتروني)'
              ]),
              _buildNumberField('رقم البطاقة', 11, witness1nationalID),
              _buildDropdownField('محل صدورها', governorates),
              _buildDatePickerField('تاريخ صدورها', _witness1DateController,
                  (pickedDate) {
                setState(() {
                  witness1Date = pickedDate;
                });
              }),
              const SizedBox(height: 20),

              // الشاهد الثاني (بنفس الحقول)
              const Text('الشاهد الثاني:',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              _buildTextFieldWithController(
                  'الاسم', witness2Name, 'witness2Name'),
              _buildTextFieldWithController(
                  'جهة العمل ومقرها', witness2Work, 'witness2Work'),
              _buildNumberField('رقم الهاتف', 9, witness2PhoneController),
              _buildDropdownField('نوع البطاقة', [
                'شخصية',
                'جامعية',
                'لاجئي',
                'العمل',
                'التأمين الصحي',
                'القيادة',
                'ضمان اجتماعي',
                'الائتمان/الخصم البنكية',
                'العضوية',
                'السفر (الجواز الإلكتروني)'
              ]),
              _buildNumberField('رقم البطاقة', 11, witness2nationalID),
              _buildDropdownField('محل صدورها', governorates),
              _buildDatePickerField('تاريخ صدورها', _witness2DateController,
                  (pickedDate) {
                setState(() {
                  witness2Date = pickedDate;
                });
              }),
              const SizedBox(height: 20),
              _buildImagePickerFieldforPaper(),
              const SizedBox(height: 30),

              ListTile(
                title: Text(
                  'الفرع :',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: _buildTextFieldWithController(
                    'لم يتم اختيار الفرع',
                    TextEditingController(text: selectedBranch ?? ''),
                    'branch',
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BranchMapPage()),
                    );
                    if (result != null) {
                      setState(() {
                        selectedBranch = result;
                      });
                    }
                  },
                  child: Text('اختر الفرع'),
                ),
              ),

              const SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSubmitButton() {
  //   return Obx(
  //     ()=> newCardRequestController.isLoading.value?CircularProgressIndicator(color: Colors.white,):Center(
  //       child: ElevatedButton(
  //         onPressed: _onSubmit,
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.white,
  //           foregroundColor: kPrimaryColor,
  //           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  //           textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         child: const Text('طلب إصدار بطاقة شخصية إلكترونية'),
  //       ),
  //     ),
  //   );
  // }
  //
  // void _onSubmit() async {
  //   // إعادة تعيين الأخطاء
  //   fieldErrors.clear();
  //
  //   // إذا كانت هناك أخطاء، قم بتحديث الواجهة وعرض الرسائل
  //   if (fieldErrors.isNotEmpty) {
  //     setState(() {});
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('يرجى ملء جميع الحقول المطلوبة'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   // //api
  //   // Map<String, dynamic> requestData = {
  //   //   "name": citizenNameController.text,
  //   //   "citizenFathernameController": citizenFathernameController.text,
  //   //   "citizenGrandFathernameController": citizenGrandFathernameController.text,
  //   //   "citizenLastnameController": citizenLastnameController.text,
  //   //   "selectedBloodType": selectedBloodType.toString(),
  //   //   "citizenHighCertificateController": citizenHighCertificateController.text,
  //   //   "citizenMajoredController": citizenMajoredController.text,
  //   //   "citizenProfessionController": citizenProfessionController.text,
  //   //   "citizenWorkplaceController": citizenWorkplaceController.text,
  //   //   "citizenIsolationController": citizenIsolationController.text,
  //   //   "citizenNeighborhoodController": citizenNeighborhoodController.text,
  //   //   "citizenStreetController": citizenStreetController.text,
  //   //   "citizenHouseController": citizenHouseController.text,
  //   //   "fatherNameController": fatherNameController.text,
  //   //   "fatherDadnameController": fatherDadnameController.text,
  //   //   "fatherGrandnameController": fatherGrandnameController.text,
  //   //   "fatherLastnameController": fatherLastnameController.text,
  //   //   "motherNameController": motherNameController.text,
  //   //   "motherDadnameController": motherDadnameController.text,
  //   //   "motherGrandnameController": motherGrandnameController.text,
  //   //   "motherLastnameController": motherLastnameController.text,
  //   //   "witness1Name": witness1Name.text,
  //   //   "witness1Work": witness1Work.text,
  //   //   "witness2Name": witness2Name.text,
  //   //   "witness2Work": witness2Work.text,
  //   //   "requestDateController": requestDateController.text,
  //   //   "promulgateDateController": promulgateDateController.text,
  //   //   "villageController": villageController.text,
  //   //   "isAcknowledgmentChecked": isAcknowledgmentChecked,
  //   //   "selectedBranch": selectedBranch,
  //   //   "birthdate":_dateController.text,
  //   //   // أضيفي باقي الحقول هنا
  //   // };
  //   final Map<String, String> stringFields = requestData.map(
  //         (key, value) => MapEntry(key, value.toString()),
  //   );
  //
  //   Map<String, dynamic> requestData = {
  //     // Basic fields
  //     // "phone_number": phoneNumberController.text,
  //     "first_name": citizenNameController.text,
  //     "second_name": citizenFathernameController.text,
  //     "third_name": citizenGrandFathernameController.text,
  //     "last_name": citizenLastnameController.text,
  //     "national_number": nationalNumberController.text,
  //     "email": emailController.text,
  //
  //     // Birth data
  //     "birth_date_writing": birthDateWritingController.text,
  //     "birth_date": _dateController.text,
  //     "born_country": bornCountryController.text,
  //     "born_city": bornCityController.text,
  //     "born_area": citizenNeighborhoodController.text,
  //     "born_village": villageController.text,
  //
  //     // Personal data
  //     "nationality": nationalityController.text,
  //     "marital_status": selectedMaritalStatus, // Make sure this matches one of the valid strings: متزوج, اعزب, مطلق, ارمل
  //     "religion": religionController.text,
  //     "gender": selectedGender, // male or female
  //     "blood_type": selectedBloodType, // Must match one of the allowed types
  //
  //     // Address and occupation
  //     "location": citizenIsolationController.text,
  //     "career": citizenProfessionController.text,
  //     "workplace": citizenWorkplaceController.text,
  //
  //     // Education
  //     "educational_status": educationalStatusController.text,
  //     "top_name_of_certificate": citizenHighCertificateController.text,
  //     "majored": citizenMajoredController.text,
  //
  //     // Father data
  //     "father_f_name": fatherNameController.text,
  //     "father_s_name": fatherDadnameController.text,
  //     "father_thr_name": fatherGrandnameController.text,
  //     "father_l_name": fatherLastnameController.text,
  //     "father_nationality": fatherNationalityController.text,
  //
  //     // Mother data
  //     "mother_f_name": motherNameController.text,
  //     "mother_s_name": motherDadnameController.text,
  //     "mother_thr_name": motherGrandnameController.text,
  //     "mother_l_name": motherLastnameController.text,
  //     "mother_nationality": motherNationalityController.text,
  //
  //     // Branch ID
  //     "branch": selectedBranch,
  //   };
  //
  //   await newCardRequestController.submitNewCard(fields: stringFields, userPhoto: _selectedImage, documents: _selectedImagepaper);
  //
  //   // try {
  //   //   var response = await _authService.submitNewCardRequest(requestData);
  //   //   print("نجحت عملية إصدار البطاقة: $response"); // يمكنكِ إظهار إشعار نجاح هنا
  //   // } catch (e) {
  //   //   print("خطأ في اصدار البطاقة: $e"); // يمكنكِ إظهار رسالة خطأ للمستخدم
  //   // }
  //
  //   // التحقق من الحقول الفارغة
  //   if (citizenNameController.text.isEmpty) fieldErrors['citizenName'] = true;
  //   if (citizenFathernameController.text.isEmpty)
  //     fieldErrors['citizenFathername'] = true;
  //   if (citizenGrandFathernameController.text.isEmpty)
  //     fieldErrors['citizenGrandFathername'] = true;
  //   if (citizenLastnameController.text.isEmpty)
  //     fieldErrors['citizenLastname'] = true;
  //   if (selectedBloodType == null) fieldErrors['citizenBloodType'] = true;
  //
  //   if (citizenHighCertificateController.text.isEmpty)
  //     fieldErrors['citizenHighCertificate'] = true;
  //   if (citizenMajoredController.text.isEmpty)
  //     fieldErrors['citizenMajored'] = true;
  //   if (citizenProfessionController.text.isEmpty)
  //     fieldErrors['citizenProfession'] = true;
  //   if (citizenWorkplaceController.text.isEmpty)
  //     fieldErrors['citizenWorkplace'] = true;
  //   if (citizenIsolationController.text.isEmpty)
  //     fieldErrors['citizenIsolation'] = true;
  //   if (citizenNeighborhoodController.text.isEmpty)
  //     fieldErrors['citizenNeighborhood'] = true;
  //   if (citizenStreetController.text.isEmpty)
  //     fieldErrors['citizenStreet'] = true;
  //   if (citizenHouseController.text.isEmpty) fieldErrors['citizenHouse'] = true;
  //
  //   if (fatherNameController.text.isEmpty) fieldErrors['fatherName'] = true;
  //   if (fatherDadnameController.text.isEmpty)
  //     fieldErrors['fatherDadname'] = true;
  //   if (fatherGrandnameController.text.isEmpty)
  //     fieldErrors['fatherGrandname'] = true;
  //   if (fatherLastnameController.text.isEmpty)
  //     fieldErrors['fatherLastname'] = true;
  //
  //   if (motherNameController.text.isEmpty) fieldErrors['motherName'] = true;
  //   if (motherDadnameController.text.isEmpty)
  //     fieldErrors['motherDadname'] = true;
  //   if (motherGrandnameController.text.isEmpty)
  //     fieldErrors['motherGrandname'] = true;
  //   if (motherLastnameController.text.isEmpty)
  //     fieldErrors['motherLastname'] = true;
  //
  //   if (witness1Name.text.isEmpty) fieldErrors['witness1Name'] = true;
  //   if (witness1Work.text.isEmpty) fieldErrors['witness1Work'] = true;
  //   if (witness2Name.text.isEmpty) fieldErrors['witness2Name'] = true;
  //   if (witness2Work.text.isEmpty) fieldErrors['witness2Work'] = true;
  //
  //   if (requestDateController.text.isEmpty) fieldErrors['requestDate'] = true;
  //   if (promulgateDateController.text.isEmpty)
  //     fieldErrors['promulgateDate'] = true;
  //   if (villageController.text.isEmpty) fieldErrors['village'] = true;
  //   if (!isAcknowledgmentChecked) fieldErrors['acknowledgment'] = true;
  //   if (_selectedImage == null) fieldErrors['image'] = true;
  //   if (_selectedImagepaper == null) fieldErrors['imagePaper'] = true;
  //   if (selectedBranch == null) fieldErrors['branch'] = true;
  //
  //   // إذا لم تكن هناك أخطاء، تابع العملية
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('تم حفظ بياناتك مؤقتاً. بياناتك قيد الفحص والتأكد.'),
  //       backgroundColor: Colors.green,
  //     ),
  //   );
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CardPage(
  //         fullName:
  //             "${citizenNameController.text} ${citizenFathernameController.text} ${citizenGrandFathernameController.text} ${citizenLastnameController.text}",
  //         citizenBloodType: selectedBloodType ?? "",
  //         village: villageController.text,
  //         birthDate: _dateController.text,
  //         image: _selectedImage!,
  //         branch: selectedBranch ?? "لم يتم اختيار الفرع",
  //         // issueDate: _startdateController.text,
  //         // expirationDate: _enddateController.text,
  //       ),
  //     ),
  //   );
  // }


  Widget _buildSubmitButton() {
    return Obx(
          () => newCardRequestController.isLoading.value
          ? const CircularProgressIndicator(color: Colors.white)
          : Center(
        child: ElevatedButton(
          onPressed: _onSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: const Text('طلب إصدار بطاقة شخصية إلكترونية'),
        ),
      ),
    );
  }

  void _onSubmit() async {
    // Reset any previous errors
    fieldErrors.clear();

    // Validate required fields
    _validateRequiredFields();


    // if (fieldErrors.isNotEmpty) {
    //   setState(() {});
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('يرجى ملء جميع الحقول المطلوبة'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }

    String generateNationalId() {
      final Random random = Random();
      String randomDigits =
      List.generate(10, (_) => random.nextInt(10).toString()).join();
      return "0$randomDigits";
    }

    // Prepare the data for submission
    final Map<String, dynamic> requestData = {
      "phone_number":phoneController.text,
      "first_name": citizenNameController.text,
      "second_name": citizenFathernameController.text,
      "third_name": citizenGrandFathernameController.text,
      "last_name": citizenLastnameController.text,
      "national_number": generateNationalId().toString(),
      "email": 'diaa.alqadrei@gmail.com',
      "birth_date_writing": '2020-10-05',
      "birth_date": _dateController.text,
      "born_country": countries[1],
      "born_city": birthCity[1],
      "born_area": citizenNeighborhoodController.text,
      "born_village": villageController.text,
      "nationality": 'Yemen',
      "marital_status": ' متزوج',
      "religion": religions[0],
      "gender": ' male',
      "blood_type": selectedBloodType,
      "location": citizenIsolationController.text,
      "career": citizenProfessionController.text,
      "workplace": citizenWorkplaceController.text,
      "educational_status": 'بكالوريوس',
      "top_name_of_certificate": citizenHighCertificateController.text,
      "majored": citizenMajoredController.text,
      "father_f_name": fatherNameController.text,
      "father_s_name": fatherDadnameController.text,
      "father_thr_name": fatherGrandnameController.text,
      "father_l_name": fatherLastnameController.text,
      "father_nationality": "يمني",
      "mother_f_name": motherNameController.text,
      "mother_s_name": motherDadnameController.text,
      "mother_thr_name": motherGrandnameController.text,
      "mother_l_name": motherLastnameController.text,
      "mother_nationality": "يمني",
      "branch": 1,
    };


    print(requestData.toString());
    // final Map<String, String> stringFields =
    // requestData.map((key, value) => MapEntry(key, value.toString()));

    // Call the controller to submit
    await newCardRequestController.submitNewCard(
      fields: requestData,
      userPhoto: _selectedImage,
      documents: _selectedImagepaper,
    );

    // Show success feedback
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ بياناتك مؤقتاً. بياناتك قيد الفحص والتأكد.'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to the result screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CardPage(
    //       fullName:
    //       "${citizenNameController.text} ${citizenFathernameController.text} ${citizenGrandFathernameController.text} ${citizenLastnameController.text}",
    //       citizenBloodType: selectedBloodType ?? "",
    //       village: villageController.text,
    //       birthDate: _dateController.text,
    //       image: _selectedImage!,
    //       branch: selectedBranch ?? "لم يتم اختيار الفرع",
    //     ),
    //   ),
    // );
  }

  void _validateRequiredFields() {
    void check(String key, TextEditingController controller) {
      if (controller.text.isEmpty) fieldErrors[key] = true;
    }

    check('citizenName', citizenNameController);
    check('citizenFathername', citizenFathernameController);
    check('citizenGrandFathername', citizenGrandFathernameController);
    check('citizenLastname', citizenLastnameController);
    check('citizenHighCertificate', citizenHighCertificateController);
    check('citizenMajored', citizenMajoredController);
    check('citizenProfession', citizenProfessionController);
    check('citizenWorkplace', citizenWorkplaceController);
    check('citizenIsolation', citizenIsolationController);
    check('citizenNeighborhood', citizenNeighborhoodController);
    check('citizenStreet', citizenStreetController);
    check('citizenHouse', citizenHouseController);
    check('fatherName', fatherNameController);
    check('fatherDadname', fatherDadnameController);
    check('fatherGrandname', fatherGrandnameController);
    check('fatherLastname', fatherLastnameController);
    check('motherName', motherNameController);
    check('motherDadname', motherDadnameController);
    check('motherGrandname', motherGrandnameController);
    check('motherLastname', motherLastnameController);
    check('witness1Name', witness1Name);
    check('witness1Work', witness1Work);
    check('witness2Name', witness2Name);
    check('witness2Work', witness2Work);
    check('requestDate', requestDateController);
    check('promulgateDate', promulgateDateController);
    check('village', villageController);

    if (selectedBloodType == null) fieldErrors['citizenBloodType'] = true;
    if (!isAcknowledgmentChecked) fieldErrors['acknowledgment'] = true;
    if (_selectedImage == null) fieldErrors['image'] = true;
    if (_selectedImagepaper == null) fieldErrors['imagePaper'] = true;
    if (selectedBranch == null) fieldErrors['branch'] = true;
  }

  Widget _buildTextFieldWithController(
      String hintText, TextEditingController controller, String errorKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
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
          ),
          if (fieldErrors.containsKey(errorKey) && fieldErrors[errorKey]!)
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'الحقل الفارغ مطلوب',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String hintText, List<String> items,
      {String? selectedValue, ValueChanged<String?>? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue, // تعيين القيمة المختارة في فصيلة الدم
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
        onChanged: (value) {
          setState(() {
            if (hintText == 'المحافظة') {
              selectedgovernorates = value; // تم تغيير المحافظة
              selectedDistricts = null; // إعادة تعيين المديرية
            } else if (hintText == 'المديرية') {
              if (selectedgovernorates == null) {
                // عرض رسالة تنبيه إذا تم محاولة اختيار المديرية قبل اختيار المحافظة
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('يجب عليك اختيار المحافظة أولاً'),
                  ),
                );
                return;
              }
              selectedDistricts = value; // تم تغيير المديرية
            }
            if (onChanged != null) {
              onChanged(value); // استدعاء الدالة الممررة لتحديث القيمة
            }
          });
        },
      ),
    );
  }

  Widget _buildDatePickerField(String hintText,
      TextEditingController controller, Function(DateTime) onDateSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
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
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
            onDateSelected(picked);
          }
        },
      ),
    );
  }

  // Widget _buildNumberField(
  //     String hintText, int maxLength, TextEditingController controller) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         TextField(
  //           controller: controller,
  //           maxLength: maxLength,
  //           keyboardType: TextInputType.phone,
  //           onChanged: (value) {
  //             if (hintText == 'رقم الهاتف') {
  //               if (value.isEmpty) {
  //                 return;
  //               }

  //               // التحقق فقط بعد إدخال أول رقمين
  //               if (value.length >= 2) {
  //                 RegExp regex = RegExp(r'^(73|71|70|78|77)');

  //                 if (!regex.hasMatch(value)) {
  //                   controller.clear(); // حذف الإدخال الخاطئ
  //                   setState(() {
  //                     fieldErrors['phone'] = true;
  //                   });
  //                 } else {
  //                   setState(() {
  //                     fieldErrors['phone'] = false;
  //                   });
  //                 }
  //               }
  //             }
  //           },
  //           decoration: InputDecoration(
  //             hintText: hintText,
  //             hintStyle: const TextStyle(color: Colors.white70),
  //             filled: true,
  //             fillColor: Colors.white.withOpacity(0.1),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide.none,
  //             ),
  //           ),
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //         if (hintText == 'رقم الهاتف' && fieldErrors['phone'] == true)
  //           const Padding(
  //             padding: EdgeInsets.only(top: 4.0),
  //             child: Text(
  //               'يجب أن يبدأ الرقم بـ 77 او 73 او 71 او 70 او 78',
  //               style: TextStyle(color: Colors.red, fontSize: 12),
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }
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
