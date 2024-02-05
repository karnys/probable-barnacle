import 'dart:async';
import 'package:coop_admin/Pages/Scaner/confirm/confirmlocation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// เพิ่ม import statement สำหรับ MapConfirmationPage

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScanResult? scanResult;
  Completer<GoogleMapController> _controller = Completer();

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  var _aspectTolerance = 0.00;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    _scan(); // เรียกใช้งานฟังก์ชันสแกนเมื่อหน้า ScannerPage โหลด
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Barcode Scanner Example'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            if (scanResult != null)
              Column(
                children: [
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Result Type'),
                          subtitle: Text(scanResult.type.toString()),
                        ),
                        ListTile(
                          title: const Text('Raw Content'),
                          subtitle: Text(scanResult.rawContent),
                        ),
                        ListTile(
                          title: const Text('Format'),
                          subtitle: Text(scanResult.format.toString()),
                        ),
                        ListTile(
                          title: const Text('Format note'),
                          subtitle: Text(scanResult.formatNote),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);

      // เมื่อสแกน QR code เสร็จสิ้น ให้เรียกใช้งานฟังก์ชันเปิดกล้อง
      _openCamera();
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // ถ้าถ่ายรูปเสร็จสมบูรณ์
        print('ถ่ายรูปเรียบร้อย: ${pickedFile.path}');
        // เปิดหน้าแผนที่เมื่อถ่ายรูปเสร็จ
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapConfirmationPage(),
          ),
        );
      } else {
        // ถ้าผู้ใช้ยกเลิกหรือมีข้อผิดพลาด
        print('ผู้ใช้ยกเลิกหรือเกิดข้อผิดพลาดในการเปิดกล้อง');
      }
    } catch (e) {
      // ถ้ามีข้อผิดพลาดในการเปิดกล้อง
      print('ข้อผิดพลาดในการเปิดกล้อง: $e');
    }
  }
}
