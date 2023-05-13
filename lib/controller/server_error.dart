import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Serevererror{

  static anErroroccured(w,h,bool server){
    Get.defaultDialog(
      title:"",
      backgroundColor: Color(0xFFFEF9C5),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.symmetric(horizontal: w*.057,vertical: h*.05),
      content: Text(server?"Some thing went wrong, please try again later":"Please check your connection and try again",
        style: TextStyle(
            fontSize: w*.045,
            fontWeight: FontWeight.w600,
            color: Color(0xFF90391E)
        ),

      ),

      actions: [
        ElevatedButton(
          onPressed: (){
            Get.back();
          },

          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: w*.13)),
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF90391E)),
              shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),

                  )
              )
          ),
          child: Text("Ok",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: w*.04
            ),

          ),
        ),

      ],


    );
  }

}