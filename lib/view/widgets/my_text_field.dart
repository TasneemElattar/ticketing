import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/theme_provider.dart';
import '../../services/localization_methods.dart';

class MyTextField extends StatefulWidget {
  String hinttext='';
  TextEditingController controllerValue;
  bool emailprofile;
  bool login;
  MyTextField({required this.hinttext,required this.controllerValue,this.emailprofile=false,this.login=false});
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool seen=false;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    return  Container(
        width: width*82,
        height: height*.047,
      child: TextFormField(obscureText: widget.hinttext=='${gettranslated(context, "Password")}'||
          widget.hinttext=='${gettranslated(context, "Old Password")}'||widget.hinttext=='${gettranslated(context, "New Password")}'||
      widget.hinttext=='${gettranslated(context, "Confirm Password")}'?!seen:seen,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: _themeProvider.primaryColorLight),
        controller: widget.controllerValue,
      validator: widget.emailprofile?(value){
       if(value!=''){
         if (EmailValidator.validate(value!)) {
           return null;
         }
         return "${gettranslated(context, "* please enter valid email")}";

       }
      }:widget.login?(value){
        if(value==null||value==''){


          return "${gettranslated(context, "* please fill email and password !")}";}
    }:null,
      decoration: InputDecoration(fillColor:_themeProvider.textfieldColor,filled: true,
        contentPadding: EdgeInsets.all(5),suffixIcon:widget.hinttext=='${gettranslated(context, "Password")}'||
              widget.hinttext=='${gettranslated(context, "Old Password")}'||widget.hinttext=='${gettranslated(context, "New Password")}'||
          widget.hinttext=='${gettranslated(context, "Confirm Password")}'?
          Padding(
            padding:  EdgeInsets.only(bottom: 8.0),
            child: IconButton(onPressed: (){
            setState(() {
              seen=!seen;
            });
            }, icon: Icon(seen?Icons.remove_red_eye_outlined:Icons.remove_red_eye,color: _themeProvider.primaryColorLight,)),
          ):null ,
       // hintText: widget.hinttext,
        hintStyle: TextStyle(color:_themeProvider.primaryColorLight.withOpacity(0.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color:_themeProvider.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color:_themeProvider.primaryColor,
            ))
      ),
    ),
    );
  }
}
