import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _History createState() => _History();
}

class _History extends State<History> {
  // รับค่า collection
  // ในที่นี้ไม่ได้ใช้ user ในการดึงข้อมูล
  // หากคุณต้องการใช้ข้อมูลจาก Firestore ควรเพิ่มการใช้ StreamBuilder หรือ FutureBuilder
  // เพื่อดึงข้อมูลจาก Firestore และแสดงผลใน Widget ได้
  // CollectionReference user = FirebaseFirestore.instance.collection('user');

  String? _selectedValue;
  int selectedOption = 1;

  List<DropdownMenuItem<String>> items = [
    'Number 261',
    'Number 262',
    'Number 263',
    'Number 264',
    'Number 265',
    'Number 266',
    'Number 267',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black, // สีเริ่มต้น
          fontSize: 14,
        ),
      ),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Your Recent History')),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(),
                color: Colors.black,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_circle, color: Colors.red),
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value as String?;
                    });
                    print('----- value ------');
                    print(_selectedValue);
                  },
                  hint: Text(
                    "Please Select Number",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: _selectedValue,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: selectedOption,
                  activeColor: Colors.green,
                  onChanged: (int? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
                Radio<int>(
                  value: 2,
                  groupValue: selectedOption,
                  activeColor: Colors.yellow,
                  onChanged: (int? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
                Radio<int>(
                  value: 3,
                  groupValue: selectedOption,
                  activeColor: Colors.red,
                  onChanged: (int? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
