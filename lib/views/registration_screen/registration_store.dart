import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';

class RegistrationStore with ChangeNotifier{
  UserService? service;
  bool createVerif = false;
  RegistrationStore({this.service});

  createVerification(String email, String password, String name)async{
    try{
      await service!.createUser(email, password, name);
      createVerif = true;
      debugPrint('sucess');
    }catch(e){
      debugPrint('erro store $e');
    }
  }
}