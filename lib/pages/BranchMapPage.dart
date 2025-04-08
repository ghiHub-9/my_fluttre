import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BranchMapPage extends StatefulWidget {
  @override
  _BranchMapPageState createState() => _BranchMapPageState();
}

class _BranchMapPageState extends State<BranchMapPage> {
  final MapController _mapController = MapController();

  final List<Map<String, dynamic>> branches = [
    {
      'name': 'المركز الرئيسي',
      'position': const LatLng(15.3540, 44.2060), // صنعاء الأمانة - ديوان المصلحة
    },
    {
      'name': 'فرع قسم 14 اكتوبر',
      'position': const LatLng(15.3690, 44.1910), // صنعاء الأمانة - مديرية معين
    },
    {
      'name': 'فرع قسم شرطة 22 مايو',
      'position': const LatLng(15.3650, 44.1950), // صنعاء الأمانة - مديرية معين
    },
    {
      'name': 'قسم شرطة حدة',
      'position': const LatLng(15.3800, 44.2100), // صنعاء الأمانة - مديرية السبعين
    },
    {
      'name': 'فرع قسم شرطة شميلة',
      'position': const LatLng(15.3850, 44.2150), // صنعاء الأمانة - مديرية السبعين
    },
    {
      'name': 'فرع قسم شرطة جمال جميل',
      'position': const LatLng(15.3550, 44.2150), // صنعاء القديمة
    },
    {
      'name': 'فرع قسم شرطة الثورة',
      'position': const LatLng(15.3600, 44.2200), // صنعاء الأمانة - مديرية الصافية
    },
    {
      'name': 'فرع قسم شرطة الحصبة',
      'position': const LatLng(15.3500, 44.2250), // صنعاء الأمانة - مديرية الثورة
    },
    {
      'name': 'فرع قسم شرطة بني الحارث',
      'position': const LatLng(15.4375, 44.2176), // منطقة بني الحارث
    },
    {
      'name': 'فرع قسم شرطة الشهيد الاحمر',
      'position': const LatLng(15.3450, 44.2300), // صنعاء الأمانة - مديرية الثورة
    },
  ];

  @override
  void dispose() {
    _mapController.dispose(); // Clean up resources when leaving the page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختر الفرع لإستلام بطاقتك')),
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          center: LatLng(15.3694, 44.1910), // وسط صنعاء
          zoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app', // Important for loading issues
          ),
          MarkerLayer(
            markers: branches.map((branch) {
              return Marker(
                point: branch['position'],
                width: 100.0, // Adjust the marker width
                height: 100.0, // Adjust the marker height
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, branch['name']);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 40),
                      const SizedBox(height: 4), // Space between icon and name
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 150), // Increase the width of the text container
                          child: Text(
                            branch['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, // Align the text to the center
                            maxLines: null, // Allow the text to wrap and span multiple lines
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
