import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coop_admin/Pages/Login&SinginPage/forgot/forgot_pw_page.dart';
import 'package:coop_admin/Pages/navigationmenu/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:coop_admin/Service/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true;
  bool _isObscureds = true;
  bool isChecked = false;
  int _currentIndex = 0;

  //firestore

  //Text controller
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirmation = TextEditingController();
  final _userNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordConfirmation.dispose();
    _userNameController.dispose();
    _genderController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  // sign user in method
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text, password: _password.text);
  }

  // open a dialog vox to add a note
  void openNoteBox() {
    showDialog(context: context, builder: (context) => AlertDialog());
  }

  Future addUserDetails(
      String username, String gender, String email, int number) async {
    await FirebaseFirestore.instance.collection('user').add({
      'user name': username,
      'gender': gender,
      'email': email,
      'time': Timestamp.now(),
      'number': number,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 35),
                  child: Container(
                    width: 270,
                    child: MaterialSegmentedControl(
                      children: {
                        0: Text('Sign In'),
                        1: Text('Sign Up'),
                      },
                      selectionIndex: _currentIndex,
                      selectedColor: Color(0xffEF312B),
                      unselectedColor: Colors.black,
                      onSegmentTapped: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                      fillColor: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextField(
                    controller: _password,
                    obscureText: _isObscured,
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
                if (_currentIndex == 1) /*ส่วนของ Sign Up*/
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          controller: _passwordConfirmation,
                          obscureText: _isObscureds,
                          // Additional TextField for Sign Up
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle:
                                TextStyle(fontSize: 10, color: Colors.grey),
                            fillColor: Colors.grey,
                            suffixIcon: IconButton(
                              padding: EdgeInsetsDirectional.only(
                                  top: 10, start: 15),
                              onPressed: () {
                                setState(() {
                                  _isObscureds = !_isObscureds;
                                });
                              },
                              icon: _isObscureds
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle:
                                TextStyle(fontSize: 10, color: Colors.grey),
                            fillColor: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          controller: _genderController,
                          decoration: InputDecoration(
                            hintText: 'Gender',
                            hintStyle:
                                TextStyle(fontSize: 10, color: Colors.grey),
                            fillColor: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          controller: _numberController,
                          decoration: InputDecoration(
                            hintText: 'Number',
                            hintStyle:
                                TextStyle(fontSize: 10, color: Colors.grey),
                            fillColor: Colors.grey,
                          ),
                        ),
                      ),
                      // ตรวจสอบว่า password และ confirm password ตรงกันหรือไม่
                      if (_password.text.isNotEmpty &&
                          _passwordConfirmation.text.isNotEmpty &&
                          _password.text != _passwordConfirmation.text)
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Text(
                            'Password and Confirm Password do not match.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffEF312B),
                            onPrimary: Colors.white,
                            padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                          ),
                          onPressed: () {
                            // ตรวจสอบรูปแบบที่อยู่อีเมล
                            if (!_isValidEmail(_email.text)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Invalid Email'),
                                    content: Text(
                                      'Please enter a valid email address.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (_password.text !=
                                _passwordConfirmation.text) {
                              // ตรวจสอบว่า password และ confirm password ตรงกันหรือไม่
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Password Mismatch'),
                                    content: Text(
                                      'Password and Confirm Password must match.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (_password.text.length < 6) {
                              // ตรวจสอบความยาวของรหัสผ่าน
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Weak Password'),
                                    content: Text(
                                      'Password should be at least 6 characters.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // ดำเนินการ Sign Up เมื่อที่อยู่อีเมลถูกต้อง และ password ตรงกัน
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _email.text.trim(),
                                password: _password.text.trim(),
                              )
                                  .then((value) {
                                print(
                                    'Create New Account'); // TODO: ทำการบันทึกข้อมูลผู้ใช้ลงใน Firestore หรือฐานข้อมูลที่ต้องการ
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              }).onError((error, stackTrace) {
                                print('Error ${error.toString()}');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text(error.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                              //add user details
                              addUserDetails(
                                _userNameController.text.trim(),
                                _genderController.text.trim(),
                                _email.text.trim(),
                                int.parse(_numberController.text.trim()),
                              );
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_currentIndex == 0) /*  ส่วนของ Sign IN  */
                  Column(
                    children: [
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
                              activeColor: Colors.black,
                              checkColor: Colors.white,
                              hoverColor: Colors.red,
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              side: BorderSide(color: Colors.black26),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password ?',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
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
                            padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                          ),
                          onPressed: () {
                            if (_email.text.isEmpty || _password.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Incomplete Information'),
                                    content: Text(
                                      'Please enter both email and password.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (!_isValidEmail(_email.text)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Invalid Email'),
                                    content: Text(
                                      'Please enter a valid email address.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text)
                                  .then((value) {
                                print('Sign In Success');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationMenu(),
                                  ),
                                );
                              }).onError((error, stackTrace) {
                                print('Error ${error.toString()}');
                                String errorMessage =
                                    'An error occurred while signing in.';
                                if (error is FirebaseAuthException) {
                                  switch (error.code) {
                                    case 'invalid-email':
                                      errorMessage = 'Invalid email address.';
                                      break;
                                    case 'user-not-found':
                                      errorMessage = 'User not found.';
                                      break;
                                    case 'wrong-password':
                                      errorMessage = 'Incorrect password.';
                                      break;
                                    case 'user-disabled':
                                      errorMessage =
                                          'User account has been disabled.';
                                      break;
                                    default:
                                      errorMessage =
                                          'Sign in failed. Please try again later.';
                                      break;
                                  }
                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Sign In Error'),
                                      content: Text(errorMessage),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    '-OR-',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AuthService().signInWithGoogle(),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image(
                          image: AssetImage('assets/images/google.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Image(
                        image: AssetImage('assets/images/Facebook.png'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ฟังก์ชันตรวจสอบรูปแบบที่อยู่อีเมล
bool _isValidEmail(String email) {
  String emailRegex =
      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$";
  RegExp regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}
