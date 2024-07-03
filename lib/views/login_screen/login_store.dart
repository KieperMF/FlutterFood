import 'package:flutter/material.dart';
import 'package:flutter_food/services/auth_service.dart';

class LoginStore with ChangeNotifier{
  LoginStore({required this.service});
  AuthService? service;
  bool loginVerif = false;
  
  loginVerification(String email, String password){
    loginVerif = service!.loginUser(email, password);
  }
}