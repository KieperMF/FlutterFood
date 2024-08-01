import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';

class LoginStore with ChangeNotifier{
  LoginStore({required this.service});
  UserService? service;
  bool loginVerif = false;
  
  loginVerification(String email, String password)async{
    loginVerif = await service!.loginUser(email, password);
  }
}