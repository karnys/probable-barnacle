import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/images/it-technocom.png')),
        ),
        leadingWidth: 200,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                    5) // สีพื้นหลังของวันที่ไม่ได้ถูกเลือก
                ),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 70,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: Colors.red,
              dayTextStyle: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.red),
              monthTextStyle: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.red),
              dateTextStyle: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
