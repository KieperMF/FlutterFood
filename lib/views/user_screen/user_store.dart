import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/user_model.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class UserStore with ChangeNotifier{
  UserService? service;
  User? user;
  UserModel userModel = UserModel();

  UserStore({
    this.service
  });

  getUser()async{
    user = service!.getUserUid();
    userModel = await service!.getUserAllInfos();
    notifyListeners();
  }

  logout(){
    service!.logout();
  }

  getImageFromGalery()async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    await service!.uploadUserPhoto(user!.uid, image!.path);
    userModel = await service!.getUserAllInfos();
    notifyListeners();
  }
}