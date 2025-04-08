// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lastcard/constants.dart';
// import 'package:lastcard/pages/services_page.dart';

// class ModifyCardPage extends StatefulWidget {
//   const ModifyCardPage({super.key});

//   @override
//   State<ModifyCardPage> createState() => _ModifyCardPageState();
// }

// class _ModifyCardPageState extends State<ModifyCardPage> {
//   final picker = ImagePicker();
//   XFile? _fatherIdImage;
//   XFile? _universityCertificate;
//   XFile? _highSchoolCertificate;
//   XFile? _courtApproval;
//   Map<String, bool> fieldErrors = {};
//   //api
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController idNumberController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController phone_numberController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String? fullName;
//   String? idNumber;
//   String? wrongDate;
//   String? rightDate;
//   String? newphone_number;
//   String? courtPaper; // صورة ورقة المحكمة
//   String? highSchool; // صورة شهادة الثانوية
//   String? fatherId; // صورة البطاقة الشخصية للأب

//   Future<void> _pickImagefather(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _fatherIdImage = pickedFile; // استخدام XFile مباشرة
//       });
//     }
//   }

//   Future<void> _pickImageuniversity(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _universityCertificate = pickedFile; // استخدام XFile مباشرة
//       });
//     }
//   }

//   Future<void> _pickImagehighSchool(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _highSchoolCertificate = pickedFile; // استخدام XFile مباشرة
//       });
//     }
//   }

//   Future<void> _pickImagecourt(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _courtApproval = pickedFile; // استخدام XFile مباشرة
//       });
//     }
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(color: Colors.white, fontSize: 18),
//     );
//   }

//   Widget _buildTextField({
//     required String hintText,
//     required Function(String?) onSaved,
//     TextInputType keyboardType = TextInputType.text,
//     int? maxLength,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         keyboardType: keyboardType,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: const TextStyle(color: Colors.white70),
//           filled: true,
//           fillColor: Colors.white.withOpacity(0.1),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           counterText: '', // لإخفاء عداد الحروف
//         ),
//         style: const TextStyle(color: Colors.white),
//         onSaved: onSaved,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return '$hintText مطلوب';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildButton() {
//     return Center(
//       child: TextButton(
//         onPressed: () {
//           if (_formKey.currentState?.validate() ?? false) {
//             _formKey.currentState?.save();
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('تم تعديل البيانات بنجاح')),
//             );
//           }
//         },
//         style: TextButton.styleFrom(
//           foregroundColor: Colors.black,
//           textStyle: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           backgroundColor: Colors.white,
//           minimumSize: const Size(300, 50), // تحديد حجم الزر
//         ),
//         child: const Text('حفظ التعديلات'),
//       ),
//     );
//   }

//   Widget _buildImagePickerField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle('  إضافة صورة بطاقة الأب الشخصية:'),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//               ),
//               builder: (context) {
//                 return Wrap(
//                   children: [
//                     ListTile(
//                       leading:
//                           const Icon(Icons.camera_alt, color: kPrimaryColor),
//                       title: const Text('التقاط صورة'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImagefather(ImageSource.camera);
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.image, color: kPrimaryColor),
//                       title: const Text('اختر من المعرض'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImagefather(ImageSource.gallery);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Container(
//             width: double.infinity,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.white70),
//             ),
//             child: _fatherIdImage != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(_fatherIdImage!.path), // تحويل XFile إلى File
//                       width: double.infinity,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.camera_alt, color: Colors.white70, size: 40),
//                       SizedBox(height: 8),
//                       Text(
//                         'اضغط لإضافة صورة',
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//         if (fieldErrors.containsKey('image') && fieldErrors['image']!)
//           const Padding(
//             padding: EdgeInsets.only(top: 4.0),
//             child: Text(
//               'صورة المستخدم مطلوبة',
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }

// //الشهاده الجامعيه
//   Widget _buildImagePickerFieldUnv() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(' إضافة صورة للشهاده الجامعية إن وجد:'),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//               ),
//               builder: (context) {
//                 return Wrap(
//                   children: [
//                     ListTile(
//                       leading:
//                           const Icon(Icons.camera_alt, color: kPrimaryColor),
//                       title: const Text('التقاط صورة'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImageuniversity(ImageSource.camera);
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.image, color: kPrimaryColor),
//                       title: const Text('اختر من المعرض'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImageuniversity(ImageSource.gallery);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Container(
//             width: double.infinity,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.white70),
//             ),
//             child: _universityCertificate != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(_universityCertificate!.path), // تحويل XFile إلى File
//                       width: double.infinity,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.camera_alt, color: Colors.white70, size: 40),
//                       SizedBox(height: 8),
//                       Text(
//                         'اضغط لإضافة صورة ',
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//         if (fieldErrors.containsKey('image') && fieldErrors['image']!)
//           const Padding(
//             padding: EdgeInsets.only(top: 4.0),
//             child: Text(
//               'صورة المستخدم مطلوبة',
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }

// //شهاده الثانوية
//   Widget _buildImagePickerFieldSchool() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(' إضافة صورة شهاده الثانوية:'),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//               ),
//               builder: (context) {
//                 return Wrap(
//                   children: [
//                     ListTile(
//                       leading:
//                           const Icon(Icons.camera_alt, color: kPrimaryColor),
//                       title: const Text('التقاط صورة'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImagehighSchool(ImageSource.camera);
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.image, color: kPrimaryColor),
//                       title: const Text('اختر من المعرض'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImagehighSchool(ImageSource.gallery);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Container(
//             width: double.infinity,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.white70),
//             ),
//             child: _highSchoolCertificate != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(_highSchoolCertificate!.path), // تحويل XFile إلى File
//                       width: double.infinity,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.camera_alt, color: Colors.white70, size: 40),
//                       SizedBox(height: 8),
//                       Text(
//                         'اضغط لإضافة صورة  ',
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//         if (fieldErrors.containsKey('image') && fieldErrors['image']!)
//           const Padding(
//             padding: EdgeInsets.only(top: 4.0),
//             child: Text(
//               'صورة المستخدم مطلوبة',
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }

// //ورقه المحكمة
//   Widget _buildImagePickerFieldChart() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(
//             ' إضافة صورة ورقه قبول المحكمة على تغيير أسمك او تاريخ ميلادك:'),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//               ),
//               builder: (context) {
//                 return Wrap(
//                   children: [
//                     ListTile(
//                       leading:
//                           const Icon(Icons.camera_alt, color: kPrimaryColor),
//                       title: const Text('التقاط صورة'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImagecourt(ImageSource.camera);
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.image, color: kPrimaryColor),
//                       title: const Text('اختر من المعرض'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImagecourt(ImageSource.gallery);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Container(
//             width: double.infinity,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.white70),
//             ),
//             child: _courtApproval != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(_courtApproval!.path), // تحويل XFile إلى File
//                       width: double.infinity,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.camera_alt, color: Colors.white70, size: 40),
//                       SizedBox(height: 8),
//                       Text(
//                         'اضغط لإضافة صورة ',
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//         if (fieldErrors.containsKey('image') && fieldErrors['image']!)
//           const Padding(
//             padding: EdgeInsets.only(top: 4.0),
//             child: Text(
//               'صورة المستخدم مطلوبة',
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }



//   void _saveChanges() {
//     if (_formKey.currentState!.validate()) {
//       if (courtPaper == null || highSchool == null || fatherId == null) {
//         setState(() {}); // تحديث الواجهة لإظهار الأخطاء تحت الصور
//       } else {
//         // قم بحفظ البيانات لأن جميع الحقول ممتلئة
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("تم حفظ التعديلات بنجاح")),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 117, 144, 175),
//         title: const Text(
//           'استمارة تعديل بطاقة شخصية',
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ServicesPage()),
//             );
//           },
//         ),
//       ),
//       backgroundColor: kPrimaryColor, // لون الخلفية
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'معلومات التعديل:',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//                 const SizedBox(height: 10),
//                 _buildTextField(
//                   hintText: 'الاسم الكامل الجديد ',
//                   onSaved: (value) {
//                     fullName = value;
//                   },
//                 ),
//                 _buildTextField(
//                   hintText: 'رقم الهوية',
//                   onSaved: (value) {
//                     idNumber = value;
//                   },
//                   keyboardType: TextInputType.number,
//                   maxLength: 11,
//                 ),
//                 _buildTextField(
//                   hintText: 'تاريخ الميلاد الخطى',
//                   onSaved: (value) {
//                     wrongDate = value;
//                   },
//                 ),
//                 _buildTextField(
//                   hintText: 'تاريخ الميلاد الصحيح',
//                   onSaved: (value) {
//                     rightDate = value;
//                   },
//                 ),
//                 _buildNumberField(
//                   'رقم الهاتف',
//                   9,
//                   phone_numberController,
//                   // onSaved: (value) {
//                   //   newphone_number = value;
//                   // },
                  
//                 ),
//                 const SizedBox(height: 10),
//                 _buildImagePickerField(),
//                 const SizedBox(height: 10),
//                 _buildImagePickerFieldUnv(),
//                 const SizedBox(height: 10),
//                 _buildImagePickerFieldSchool(),
//                 const SizedBox(height: 10),
//                 _buildImagePickerFieldChart(),
//                 const SizedBox(height: 100),
//                 _buildButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNumberField(
//       String hintText, int maxLength, TextEditingController controller,
//       {Function(String?)? onSaved}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             controller: controller,
//             maxLength: maxLength,
//             keyboardType: TextInputType.phone_number,
//             onChanged: (value) {
//               if (hintText == 'رقم الهاتف') {
//                 if (value.isEmpty) {
//                   return;
//                 }

//                 // التحقق فقط بعد إدخال أول رقمين
//                 if (value.length >= 2) {
//                   RegExp regex = RegExp(r'^(73|71|70|78|77)');

//                   if (!regex.hasMatch(value)) {
//                     controller.clear(); // حذف الإدخال الخاطئ
//                     setState(() {
//                       fieldErrors['phone_number'] = true;
//                     });
//                   } else {
//                     setState(() {
//                       fieldErrors['phone_number'] = false;
//                     });
//                   }
//                 }
//               }
//             },
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: const TextStyle(color: Colors.white70),
//               filled: true,
//               fillColor: Colors.white.withOpacity(0.1),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             style: const TextStyle(color: Colors.white),
//           ),
//           if (hintText == 'رقم الهاتف' && fieldErrors['phone_number'] == true)
//             const Padding(
//               padding: EdgeInsets.only(top: 4.0),
//               child: Text(
//                 'يجب أن يبدأ الرقم بـ 77 او 73 او 71 او 70 او 78',
//                 style: TextStyle(color: Colors.red, fontSize: 12),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// // }
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lastcard/constants.dart';
// import 'package:lastcard/pages/services_page.dart';

// class ModifyCardPage extends StatefulWidget {
//   const ModifyCardPage({super.key});

//   @override
//   State<ModifyCardPage> createState() => _ModifyCardPageState();
// }

// class _ModifyCardPageState extends State<ModifyCardPage> {
//   final picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
  
//   // تخزين الصور المختارة
//   final Map<String, XFile?> _images = {
//     "fatherId": null,
//     "universityCertificate": null,
//     "highSchoolCertificate": null,
//     "courtApproval": null,
//   };

//   // تخزين الأخطاء لكل صورة
//   final Map<String, String?> _imageErrors = {
//     "fatherId": null,
//     "universityCertificate": null,
//     "highSchoolCertificate": null,
//     "courtApproval": null,
//   };

//   // متحكمات حقول النص
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController idNumberController = TextEditingController();
//   final TextEditingController wrongDateController = TextEditingController();
//   final TextEditingController rightDateController = TextEditingController();
//   final TextEditingController phone_numberController = TextEditingController();

//   // أخطاء الحقول النصية
//   final Map<String, bool> fieldErrors = {
//     'phone_number': false,
//   };

//   Future<void> _pickImage(String key, ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _images[key] = pickedFile;
//         _imageErrors[key] = null; // إزالة الخطأ عند اختيار صورة
//       });
//     }
//   }

//   bool validateImages() {
//     bool isValid = true;
//     setState(() {
//       _imageErrors.forEach((key, _) {
//         if (_images[key] == null && key != "universityCertificate") {
//           _imageErrors[key] = "هذه الصورة مطلوبة";
//           isValid = false;
//         } else {
//           _imageErrors[key] = null;
//         }
//       });
//     });
//     return isValid;
//   }

//   bool validateForm() {
//     bool isFormValid = _formKey.currentState?.validate() ?? false;
//     bool areImagesValid = validateImages();
//     return isFormValid && areImagesValid;
//   }

//   void _saveChanges() {
//     if (validateForm()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تم تعديل البيانات بنجاح')),
//       );
//       // هنا يمكنك إضافة منطق حفظ البيانات أو إرسالها للخادم
//     }
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(color: Colors.white, fontSize: 18),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String hintText,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     int? maxLength,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: const TextStyle(color: Colors.white70),
//           filled: true,
//           fillColor: Colors.white.withOpacity(0.1),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           counterText: '',
//         ),
//         style: const TextStyle(color: Colors.white),
//         validator: validator ?? (value) {
//           if (value == null || value.isEmpty) {
//             return '$hintText مطلوب';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildImagePickerField(String key, String title, {bool required = true}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(title),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () => _showImageSourceDialog(key),
//           child: Container(
//             width: double.infinity,
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(
//                 color: _imageErrors[key] != null ? Colors.red : Colors.white70,
//               ),
//             ),
//             child: _images[key] != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(_images[key]!.path),
//                       width: double.infinity,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.camera_alt, color: Colors.white70, size: 40),
//                       SizedBox(height: 8),
//                       Text(
//                         'اضغط لإضافة صورة',
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//         if (_imageErrors[key] != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: Text(
//               _imageErrors[key]!,
//               style: const TextStyle(color: Colors.red, fontSize: 14),
//             ),
//           ),
//       ],
//     );
//   }

//   void _showImageSourceDialog(String key) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//       ),
//       builder: (context) => Wrap(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.camera_alt, color: kPrimaryColor),
//             title: const Text('التقاط صورة'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickImage(key, ImageSource.camera);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.image, color: kPrimaryColor),
//             title: const Text('اختر من المعرض'),
//             onTap: () {
//               Navigator.pop(context);
//               _pickImage(key, ImageSource.gallery);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildphone_numberField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             controller: phone_numberController,
//             maxLength: 9,
//             keyboardType: TextInputType.phone_number,
//             onChanged: (value) {
//               if (value.isEmpty) return;

//               if (value.length >= 2) {
//                 RegExp regex = RegExp(r'^(73|71|70|78|77)');
//                 setState(() {
//                   fieldErrors['phone_number'] = !regex.hasMatch(value);
//                 });
//               }
//             },
//             decoration: InputDecoration(
//               hintText: 'رقم الهاتف',
//               hintStyle: const TextStyle(color: Colors.white70),
//               filled: true,
//               fillColor: Colors.white.withOpacity(0.1),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//               counterText: '',
//             ),
//             style: const TextStyle(color: Colors.white),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'رقم الهاتف مطلوب';
//               }
//               if (value.length != 9) {
//                 return 'يجب أن يتكون رقم الهاتف من 9 أرقام';
//               }
//               if (fieldErrors['phone_number'] == true) {
//                 return 'يجب أن يبدأ الرقم بـ 77 او 73 او 71 او 70 او 78';
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _saveChanges,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           textStyle: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           minimumSize: const Size(300, 50),
//         ),
//         child: const Text('حفظ التعديلات'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 117, 144, 175),
//         title: const Text(
//           'استمارة تعديل بطاقة شخصية',
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ServicesPage()),
//             );
//           },
//         ),
//       ),
//       backgroundColor: kPrimaryColor,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'معلومات التعديل:',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//                 const SizedBox(height: 10),
//                 _buildTextField(
//                   hintText: 'الاسم الكامل الجديد',
//                   controller: nameController,
//                 ),
//                 _buildTextField(
//                   hintText: 'رقم الهوية',
//                   controller: idNumberController,
//                   keyboardType: TextInputType.number,
//                   maxLength: 11,
//                 ),
//                 _buildTextField(
//                   hintText: 'تاريخ الميلاد الخطأ',
//                   controller: wrongDateController,
//                 ),
//                 _buildTextField(
//                   hintText: 'تاريخ الميلاد الصحيح',
//                   controller: rightDateController,
//                 ),
//                 _buildphone_numberField(),
//                 const SizedBox(height: 10),
//                 _buildImagePickerField(
//                   "fatherId",
//                   "إضافة صورة بطاقة الأب الشخصية:",
//                 ),
//                 const SizedBox(height: 10),
//                 _buildImagePickerField(
//                   "universityCertificate",
//                   "إضافة صورة للشهادة الجامعية إن وجد:",
//                   required: false,
//                 ),
//                 const SizedBox(height: 10),
//                 _buildImagePickerField(
//                   "highSchoolCertificate",
//                   "إضافة صورة شهادة الثانوية:",
//                 ),
//                 const SizedBox(height: 10),
//                 _buildImagePickerField(
//                   "courtApproval",
//                   "إضافة صورة ورقة المحكمة (إذا كنت تعدل الاسم أو تاريخ الميلاد):",
//                 ),
//                 const SizedBox(height: 20),
//                 _buildSubmitButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
    
//   }
  
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/services_page.dart';

class ModifyCardPage extends StatefulWidget {
  const ModifyCardPage({super.key});

  @override
  State<ModifyCardPage> createState() => _ModifyCardPageState();
}

class _ModifyCardPageState extends State<ModifyCardPage> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  
  // تخزين الصور المختارة
  final Map<String, XFile?> _images = {
    "fatherId": null,
    "universityCertificate": null,
    "highSchoolCertificate": null,
    "courtApproval": null,
  };

  // متحكمات حقول النص
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController phone_numberController = TextEditingController();
  final TextEditingController wrongDateController = TextEditingController();
  final TextEditingController rightDateController = TextEditingController();

  // حساب العمر من تاريخ الميلاد
  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // عرض منتقي التاريخ
  Future<void> _selectDate(
      BuildContext context, 
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      final age = calculateAge(picked);
      if (age < 16) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يجب أن يكون العمر 16 سنة أو أكثر')),
        );
        return;
      }
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.text = formattedDate;
      _formKey.currentState?.validate();
    }
  }

  bool validateImages() {
    bool isValid = true;
    if (_images["fatherId"] == null) {
      isValid = false;
    }
    if (_images["highSchoolCertificate"] == null) {
      isValid = false;
    }
    if (_images["courtApproval"] == null) {
      isValid = false;
    }
    return isValid;
  }

  void _saveChanges() {
    // التحقق من الحقول النصية
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // التحقق من الصور المطلوبة
    if (!validateImages()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إضافة جميع الصور المطلوبة')),
      );
      return;
    }

    // إذا كانت جميع البيانات صحيحة
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعديل البيانات بنجاح')),
    );

    // الانتقال إلى صفحة الخدمات بعد ثانية واحدة
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ServicesPage()),
      );
    });
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
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
          counterText: '',
          errorStyle: const TextStyle(color: Colors.red),
        ),
        style: const TextStyle(color: Colors.white),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField({
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
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
          errorStyle: const TextStyle(color: Colors.red),
          errorMaxLines: 2,
        ),
        style: const TextStyle(color: Colors.white),
        validator: validator,
        onTap: () => _selectDate(context, controller),
      ),
    );
  }

  Widget _buildphoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: phone_numberController,
        maxLength: 9,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'رقم الهاتف',
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          counterText: '',
          errorStyle: const TextStyle(color: Colors.red),
          errorMaxLines: 2,
        ),
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'رقم الهاتف مطلوب';
          }
          if (value.length != 9) {
            return 'يجب أن يتكون رقم الهاتف من 9 أرقام';
          }
          if (!RegExp(r'^(70|71|73|77|78)').hasMatch(value.substring(0, 2))) {
            return 'يجب أن يبدأ الرقم بـ 70, 71, 73, 77 أو 78';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImagePickerField(String key, String title, {bool required = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showImageSourceDialog(key),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: required && _images[key] == null 
                    ? Colors.red 
                    : Colors.white70,
                width: 2,
              ),
            ),
            child: _images[key] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_images[key]!.path),
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
                        'اضغط لإضافة صورة',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
          ),
        ),
        if (required && _images[key] == null)
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'هذه الصورة مطلوبة',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  void _showImageSourceDialog(String key) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: kPrimaryColor),
            title: const Text('التقاط صورة'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(key, ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image, color: kPrimaryColor),
            title: const Text('اختر من المعرض'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(key, ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(String key, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images[key] = pickedFile;
      });
    }
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(300, 50),
        ),
        child: const Text('حفظ التعديلات'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 144, 175),
        title: const Text(
          'استمارة تعديل بطاقة شخصية',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'معلومات التعديل:',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  hintText: 'الاسم الكامل الجديد',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'حقل الاسم الكامل مطلوب';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  hintText: 'رقم الهوية',
                  controller: idNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'حقل رقم الهوية مطلوب';
                    }
                    if (value.length != 11) {
                      return 'يجب أن يتكون رقم الهوية من 11 رقمًا';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                ),
                _buildDateField(
                  hintText: 'تاريخ الميلاد الخطأ',
                  controller: wrongDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'حقل تاريخ الميلاد الخطأ مطلوب';
                    }
                    return null;
                  },
                ),
                _buildDateField(
                  hintText: 'تاريخ الميلاد الصحيح',
                  controller: rightDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'حقل تاريخ الميلاد الصحيح مطلوب';
                    }
                    final date = DateTime.tryParse(value);
                    if (date == null) return 'تاريخ غير صالح';
                    final age = calculateAge(date);
                    if (age < 16) return 'يجب أن يكون العمر 16 سنة أو أكثر';
                    return null;
                  },
                ),
                _buildphoneField(),
                const SizedBox(height: 10),
                _buildImagePickerField(
                  "fatherId",
                  "إضافة صورة بطاقة الأب الشخصية:",
                ),
                const SizedBox(height: 10),
                _buildImagePickerField(
                  "universityCertificate",
                  "إضافة صورة للشهادة الجامعية إن وجد:",
                  required: false,
                ),
                const SizedBox(height: 10),
                _buildImagePickerField(
                  "highSchoolCertificate",
                  "إضافة صورة شهادة الثانوية:",
                ),
                const SizedBox(height: 10),
                _buildImagePickerField(
                  "courtApproval",
                  "إضافة صورة ورقة المحكمة (إذا كنت تعدل الاسم أو تاريخ الميلاد):",
                ),
                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}