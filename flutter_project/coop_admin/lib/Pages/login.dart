import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true; // ทำการแก้ไขตรงนี้
  bool isChecked = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffBDD9FF),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            child: Image(
              image: AssetImage('assets/images/it-technocom.png'),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          //ขนาดของ card
          height: 590,
          width: 334,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 35),
                child: ToggleSwitch(
                  minHeight: 60,
                  minWidth: 130.0,
                  cornerRadius: 30.0,
                  activeBgColors: [
                    [Color(0xffEF312B)!],
                    [Color(0xffEF312B)!],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.black,
                  inactiveFgColor: Colors.red,
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: [
                    'Sign In',
                    'Sign Up',
                  ],
                  radiusStyle: true,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter email or Username',
                    hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                    fillColor: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  obscureText: _isObscured,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                    fillColor: Colors.grey,
                    suffixIcon: IconButton(
                      padding: EdgeInsetsDirectional.only(top: 10, start: 15),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: _isObscured
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: Colors.black, // สีของช่องเช็คเมื่อถูกกด
                      checkColor: Colors.white, // สีของเช็คเมื่อถูกกด
                      hoverColor: Colors.red, // สีที่ต้องการให้เมื่อ hover
                      visualDensity: VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ), // สามารถปรับ visual density ตามความต้องการ
                      side: BorderSide(color: Colors.black26),
                      // กำหนดสีของกรอบ
                    ),
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffEF312B),
                      onPrimary: Colors.white,
                      padding: EdgeInsets.fromLTRB(100, 10, 100, 10)),
                  onPressed: () {
                    String enteredText = _controller.text;
                    print('Entered text: $enteredText');
                  },
                  child: Text(
                    'Sing In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                  child: Text(
                '-OR-',
                style: TextStyle(fontWeight: FontWeight.w300),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
