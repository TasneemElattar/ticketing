import 'package:flutter/material.dart';
import 'package:ticketing_system/model/user_model.dart';


class UserProvider extends ChangeNotifier{
  UserModel? userModel;

  setuserProfile(UserModel user){
    userModel=user;
    notifyListeners();
  }

}