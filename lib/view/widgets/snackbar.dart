import 'package:flutter/material.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';

showsnack(width, ThemeProvider themeProvider,String text,IconData icon){
  return  SnackBar(backgroundColor: themeProvider.primaryColor,
    content: Row(
      children: [
        Icon(
          icon,
          color: themeProvider.primaryColorLight,
        ),
        SizedBox(
          width: width * .03,
        ),
        Expanded(
          child: Text(
            text,style: TextStyle(color: themeProvider.primaryColorLight ),),
        ),
      ],
    ),
   
  );


}
