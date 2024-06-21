import 'package:app_docbao/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // final storage = FirebaseStorage.instance;
  WidgetsFlutterBinding.ensureInitialized(

  );
  await Firebase.initializeApp(

      options: FirebaseOptions(
          apiKey: "AIzaSyA9gTRjWvQkab9wdKdFFSjMw2YyAiF3By0",
          projectId: "appdocbao-9d33b",
          messagingSenderId: "13077254718",
          appId: " 1:13077254718:android:b8cb6e07477d9d3960b76f",
          storageBucket: "appdocbao-9d33b.appspot.com"
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LandingPage()
    );
  }
}

