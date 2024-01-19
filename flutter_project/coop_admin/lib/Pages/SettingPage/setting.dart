import 'package:coop_admin/Pages/Login&SinginPage/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
            Container(
              child: Row(
                children: [],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print('Sign Out');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                },
                child: Text('LogOut'))
          ],
        ),
      ),
    );
  }
}
