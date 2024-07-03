import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/firebase_options.dart';
import 'package:flutter_food/views/bottom_navigation_bar.dart';
import 'package:flutter_food/views/login_screen/login_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stream(),
    );
  }
}

class Stream extends StatelessWidget {
  const Stream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(), 
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const GoogleNavBar();
        }else{
          return LoginPage.create();
        }
      });
  }
}
