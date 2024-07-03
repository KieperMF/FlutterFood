import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_food/services/auth_service.dart';

class UserStore with ChangeNotifier{
  AuthService? service;
  User? user;

  UserStore({
    this.service
  });

  getUser(){
    user = service!.getUser();
  }

  logout(){
    service!.logout();
  }
}