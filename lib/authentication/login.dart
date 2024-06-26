import 'package:app_docbao/authentication/signup.dart';
import 'package:app_docbao/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/widget_support.dart';
import 'forgotpassword.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();

  bool _obscureText = true;

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Hiển thị SnackBar thông báo đăng nhập thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Đăng nhập thành công!',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.green, // Màu nền của SnackBar
        ),
      );

      // Chuyển hướng đến trang Home sau khi đăng nhập thành công
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Hiển thị lỗi 'Email không tồn tại' dưới trường nhập liệu Email
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email không tồn tại!',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red, // Màu nền của SnackBar
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Hiển thị lỗi 'Mật khẩu không chính xác' dưới trường nhập liệu Mật khẩu
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Mật khẩu không chính xác!',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red, // Màu nền của SnackBar
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFff5c30),
                        Color(0xFFe74b1a),
                      ])),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Text(""),
            ),
            Container(
              margin: EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Column(
                children: [
                  Center(
                    child:
                    // Text("Tran Quang Huy - 2055010127",style: TextStyle(
                    //   color: Colors.white,
                    //   fontWeight: FontWeight.bold,
                    //   fontFamily: "Popins1",
                    //   fontSize: 25
                    // ),)
                    Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Đăng Nhập",
                              style: AppWidget.HeadlineTextFeildStyle(),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: useremailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập Email';
                                }
                                if (!value.contains('@')) {
                                  return 'Định dạng Email không hợp lệ';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  email = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                prefixIcon: Icon(Icons.email_outlined),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: userpasswordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập Password';
                                }
                                return null;
                              },
                              obscureText: _obscureText,
                              onChanged: (value) {
                                setState(() {
                                  password = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Mật khẩu',
                                hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                prefixIcon: Icon(Icons.password_outlined),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPassword()));
                              },
                              child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Quên mật khẩu?",
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  )),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    email = useremailcontroller.text;
                                    password = userpasswordcontroller.text;
                                  });
                                }
                                userLogin();
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Color(0Xffff5722),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "ĐĂNG NHẬP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Poppins1',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bạn chưa có tài khoản? ",
                            style: AppWidget.semiBoldTextFeildStyle(),
                          ),
                          Text(
                            "Đăng ký",
                            style: TextStyle(
                                color: Color.fromARGB(255, 184, 166, 6),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
