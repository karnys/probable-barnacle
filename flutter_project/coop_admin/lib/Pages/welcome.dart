import 'package:coop_admin/Pages/Login.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Stack(
          alignment: const Alignment(0.6, 1.1),
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Color(0xffCADDF6),
                  Color(0xff357BDB)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                image: DecorationImage(
                  image: AssetImage('assets/images/it-technocom.png'),
                ),
              ),
            ),
            Image(image: AssetImage('assets/images/programmer.png'))
          ],
        ),
      ),
    );
  }
}
