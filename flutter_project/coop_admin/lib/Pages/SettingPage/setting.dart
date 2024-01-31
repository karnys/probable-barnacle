import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coop_admin/Pages/Login&SinginPage/login.dart';
import 'package:coop_admin/Pages/SettingPage/settinginfo.dart';
import 'package:coop_admin/read%20data/get_user_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 500,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Container(
                    child: Text(
                      'Setting',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.only(left: 30, top: 30),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.email!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'General',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
                title: Text(
                  'Acount Info',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingInfo()));
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            SizedBox(
              height: 330,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[100],
                    elevation: 1,
                    padding: EdgeInsets.only(
                        left: 100, right: 100, top: 15, bottom: 15)),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print('Sign Out');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                },
                child: Text(
                  'LogOut',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
