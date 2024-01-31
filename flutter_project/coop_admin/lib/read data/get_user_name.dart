import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // รับค่า collection
    CollectionReference user = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data =
              snapshot.data?.data() as Map<String, dynamic>?;

          // ตรวจสอบว่าฟิลด์ 'time' ไม่เป็น null
          if (data != null && data['time'] != null) {
            // แปลง timestamp เป็น DateTime
            DateTime dateTime = (data['time'] as Timestamp).toDate();

            // แสดงผลวันที่และเวลา
            String formattedDateTime = '${dateTime.hour}:${dateTime.minute}';

            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ), // ปรับค่าตามที่ต้องการ
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${data['number']}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${data['user name']}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    formattedDateTime,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('ไม่มีข้อมูลเวลาที่ใช้ได้');
          }
        }
        return Text('กำลังโหลดข้อมูล...');
      },
    );
  }
}
