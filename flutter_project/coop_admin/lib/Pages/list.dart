import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? selectedHistoryItem; // ปรับปรุงประเภทของตัวแปร

  void onChanged(String? selectedValue) {
    // อัปเดต state เมื่อมีการเลือกรายการประวัติ
    setState(() {
      selectedHistoryItem = selectedValue;
    });

    // ดำเนินการเพิ่มเติมตามต้องการ
    print('Selected history item: $selectedValue');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Center(
              child: Text(
                'Your Recent History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 30),
            DropdownButton<String?>(
              style: TextStyle(fontSize: 20, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              dropdownColor: Colors.red,
              hint: Text(
                'Select No.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconSize: 30,
              iconEnabledColor: Colors.red,
              iconDisabledColor: Colors.red,
              items: [
                DropdownMenuItem(child: Text('No.251'), value: 'No.251'),
                DropdownMenuItem(child: Text('No.252'), value: 'No.252'),
                DropdownMenuItem(child: Text('No.253'), value: 'No.253'),
                DropdownMenuItem(child: Text('No.254'), value: 'No.254'),
                DropdownMenuItem(child: Text('No.255'), value: 'No.255'),
                DropdownMenuItem(child: Text('No.256'), value: 'No.256'),
                DropdownMenuItem(child: Text('No.257'), value: 'No.257'),
                DropdownMenuItem(child: Text('No.258'), value: 'No.258'),
              ],
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
