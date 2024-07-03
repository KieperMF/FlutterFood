import 'package:flutter/material.dart';
import 'package:flutter_food/services/auth_service.dart';

class RegistrationStore with ChangeNotifier{
  AuthService? service;
  bool createVerif = false;
  RegistrationStore({this.service});

  createVerification(String email, String password, String name)async{
    debugPrint('$email');
      debugPrint('$password');
      debugPrint('$name');
    try{
      debugPrint('$email');
      debugPrint('$password');
      debugPrint('$name');
      await service!.createUser(email, password, name);
      createVerif = true;
      debugPrint('sucess');
    }catch(e){
      debugPrint('erro store $e');
    }
  }
}