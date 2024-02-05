import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class MapConfirmationPage extends StatefulWidget {
  const MapConfirmationPage({Key? key}) : super(key: key);

  @override
  _MapConfirmationPageState createState() => _MapConfirmationPageState();
}

class _MapConfirmationPageState extends State<MapConfirmationPage> {
  Position? _currentPosition;
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission(); // ตรวจสอบสถานะ permission ใน initState
  }

  void _checkLocationPermission() async {
    // ตรวจสอบสถานะ permission ของ location
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // ถ้ายังไม่ได้รับการอนุญาตให้เข้าถึง location
      var result = await Permission.location.request();
      if (result.isDenied) {
        // ถ้าผู้ใช้ปฏิเสธการให้สิทธิ์
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Required'),
            content:
                Text('Please enable Location Permission to use this feature.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      _getCurrentLocation(); // หากสิทธิ์ถูกอนุญาตให้ดึงตำแหน่งปัจจุบัน
    }
  }

  void _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void openLocationSettings() async {
    const platform = MethodChannel('location_settings');
    try {
      await platform.invokeMethod('openLocationSettings');
    } on PlatformException catch (e) {
      print("Failed to open location settings: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Location'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('current-location'),
                        position: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                      ),
                    },
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // ใส่โค้ดเมื่อผู้ใช้คลิกปุ่มยืนยันตำแหน่ง
                  },
                  child: Text(
                    'Confirm Location',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
    );
  }
}
