import 'package:flutter/material.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';

import '../../services/localization_methods.dart';

Alertmessage(BuildContext context,String errormesg,ThemeProvider themeProvider,double width,double height){
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