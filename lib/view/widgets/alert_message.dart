import 'package:flutter/material.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';

import '../../controller/provider/admin_provider.dart';
import '../../main.dart';
import '../../services/localization_methods.dart';
import '../screens/splash_screen.dart';

Alertmessage(BuildContext context,String errormesg,ThemeProvider themeProvider,double width,double height,{ String? theme_name ="", bool splash = false, String? path ="",  String? splashPath = "",AdminProvider? admin}){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title:  Text("Warning !",  style: TextStyle(color:themeProvider.primaryColor),),
            content:  Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.03),
              child: Text(errormesg,  style: TextStyle(color:themeProvider.primaryColor),),
            ),
            actions: [
              Container(
                width: width*.35,
                height: height*.045,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      splash?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MysPLASH(themename: theme_name,path: path,splash_path: splashPath,isAdmin:admin?.admin))):null;


                    },
                    child:  Text(
                      "try again",
                      style: TextStyle(color: themeProvider.primaryColorLight),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
                      backgroundColor:
                      MaterialStateProperty.all(themeProvider.primaryColor),
                    )),
              )

            ]
        );
      });}