import 'package:app_docbao/pages/all_coin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../authentication/login.dart';
import '../models/coin_model.dart';
import 'all_categories.dart';
import 'all_news.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: _user != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/logo.png'),
                        radius: 30,
                      ),
                      SizedBox(height: 20),
                      Text(
                        _user!.email ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Bạn chưa đăng nhập vào tài khoản',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          ListTile(
            leading: Image(image: AssetImage("images/home.png"),width: 30,height: 30,),
            title: Text('Trang chủ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image(image: AssetImage("images/usa.png"),width: 30,height: 30,),
            title: Text('Tin tức về Mỹ'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllCategoriesNews()));
            },
          ),

          ListTile(
            leading: Image(image: AssetImage("images/apple.png"),width: 30,height: 30,),
            title: Text('Tin tức về Apple'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllNews(news: "Tin tức về Apple")));
            },
          ),
          ListTile(
            leading: Image(image: AssetImage("images/tc.png"),width: 30,height: 25,),
            title: Text('Tin tức về TechCrunch'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllNews(news: "Tin tức về TechCrunch")));
            },
          ),
          ListTile(
            leading: Image(image: AssetImage("images/coin.png"),width: 30,height: 30,),
            title: Text('Tin tức về Coin'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllCoins(coins: coinList)));
              },
          ),
          ListTile(
            leading: Image(image: AssetImage("images/logout.png"),width: 30,height: 25,),
            title: Text('Đăng xuất'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
            },
          ),
        ],
      ),
    );
  }
}
