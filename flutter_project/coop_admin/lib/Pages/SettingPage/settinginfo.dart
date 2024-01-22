import 'package:coop_admin/Pages/SettingPage/setting.dart';
import 'package:flutter/material.dart';

class SettingInfo extends StatelessWidget {
  const SettingInfo({super.key});

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
              height: 120,
              width: 120,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            buildListTile('Name', 'Admin'),
            buildDivider(),
            buildListTile('User', 'New'),
            buildDivider(),
            buildListTile('Gender', 'Female'),
            buildDivider(),
            buildListTile('Email', 'admin123@gmail.com'),
            buildDivider(),
            buildListTile('Password', 'admin123'),
            buildDivider(),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[100],
                    elevation: 1,
                    padding: EdgeInsets.only(
                        left: 100, right: 100, top: 15, bottom: 15)),
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildListTile(String label, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Text(
          label,
          style: TextStyle(fontSize: 15),
        ),
        trailing: Container(
          width: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: TextField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration.collapsed(hintText: hintText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Divider(
        thickness: 2,
        height: 20,
      ),
    );
  }
}
