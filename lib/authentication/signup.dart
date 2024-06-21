import 'package:app_docbao/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/widget_support.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "", confirmPassword = "";
  bool _isObscure = true;
  bool _isConfirmObscure = true;

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Đăng ký thành công",
              style: TextStyle(fontSize: 20.0),
            )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Mật khẩu của bạn phải có 6 kí tự",
              style: TextStyle(fontSize: 18),
            ),
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Tài khoản đã tồn tại ",
              style: TextStyle(fontSize: 18),
            ),
          )));
        }
      }
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
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = mailcontroller.text;
                          name = namecontroller.text;
                          password = passwordcontroller.text;
                          confirmPassword = confirmPasswordController.text;
                        });
                        if (password == confirmPassword) {
                          registration();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              "Mật khẩu không khớp",
                              style: TextStyle(fontSize: 18),
                            ),
                          ));
                        }
                      }
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.5,
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
                                "Đăng Ký",
                                style: AppWidget.HeadlineTextFeildStyle(),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập tên';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Tên của bạn',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: Icon(Icons.person_outlined)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: mailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập Password';
                                  }
                                  return null;
                                },
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                    hintText: 'Mật khẩu',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: Icon(Icons.password_outlined),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập lại Password';
                                  }
                                  return null;
                                },
                                obscureText: _isConfirmObscure,
                                decoration: InputDecoration(
                                    hintText: 'Nhập lại mật khẩu',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: Icon(Icons.password_outlined),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isConfirmObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmObscure = !_isConfirmObscure;
                                        });
                                      },
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = mailcontroller.text;
                                      name = namecontroller.text;
                                      password = passwordcontroller.text;
                                      confirmPassword = confirmPasswordController.text;
                                    });
                                    if (password == confirmPassword) {
                                      registration();
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                          "Mật khẩu không khớp",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ));
                                    }
                                  }
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
                                        "ĐĂNG KÝ",
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bạn đã có tài khoản?",
                            style: AppWidget.semiBoldTextFeildStyle(),
                          ),
                          Text(
                            " Đăng nhập",
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
