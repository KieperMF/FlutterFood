import 'package:flutter/material.dart';
import 'package:flutter_food/services/auth_service.dart';

class HomeStore with ChangeNotifier{
  HomeStore({required this.service});
  AuthService service;

  logout(){
    service.logout();
  }
}