import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/routes.dart';
import 'package:go_router/go_router.dart';

class RouterGuardStore with ChangeNotifier{
  RouterGuardStore({
    required this.auth
  });
  final FirebaseAuth auth;

  void startListening(){
    auth.userChanges().listen((user) {
      if(user == null){
        final context = navigatorKey.currentContext;
        if(context != null){
          context.go('/login');
        }
      }
    },);
  }
}