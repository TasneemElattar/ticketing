import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import 'package:ticketing_system/main.dart';
import 'package:flutter/material.dart';

import '../services/localization_methods.dart';
//String baseUrl="http://svhelp.help.svcustomer.com/";
String baseUrl = "http://help.svcustomer.com/admin"; //production

class Auth{

  static String user_id='';
  static String user_email='';
  static String username='';
  static String errormesssage='no';
  static int status=0;
  static String user_image='';
  static String active_status=''; //active 1:0
  static bool isAdmin=false;
  // static login(String email, String passsword) async {
  //   var res = await http.post(Uri.parse("${baseUrl}api/login"),
  //
  //     body: {
  //       "email": email,
  //       "password": passsword
  //     },
  //
  //   );
  //   messageFunc(res.statusCode, res.body, true);
  //   status=res.statusCode;
  //
  // }
  static NewAdminlogin(BuildContext context,String email, String passsword) async {
    var res = await http.post(Uri.parse("${baseUrl}api/oauth/token"),

      body: {
        "username":email,
        "password":passsword,
        "grant_type": "password",
        "client_id": '2',
        "client_secret": "F9wUHvYrFCZSaQfutp87cDAip5UGoAPh7QJ4VDpH",
        "provider": "users"
      },

    );
    messageFunc(context,res.statusCode, res.body, true,from_customer: false);
    status=res.statusCode;

  }
  static NewCustomerlogin(BuildContext context,String email, String passsword) async {
    var res = await http.post(Uri.parse("${baseUrl}api/oauth/token"),

      body: {
        "username":email,
        "password":passsword,
        "grant_type": "password",
        "client_id":'3',
        "client_secret": "w0XxvF4bUkuh8TY00KBBtez8cU3DhD7iKtURKHjv",
        "provider": "customers"
      },

    );
    messageFunc(context ,res.statusCode, res.body, true,from_customer: true);
    status=res.statusCode;

  }
  Future get gettoken async{
    final storage = new GetStorage();

    return await storage.read("token");
  }

  static  saveToken(String token,bool isAdmin,String user_id,String email,String name) {
    final storage = new GetStorage();
     storage.write('token', token);
     token_main=token;
     isAdmin?Auth.isAdmin=true:Auth.isAdmin=false;
    storage.write('isAdmin', isAdmin);
    storage.write('user_id', user_id);
    storage.write('user_email', email);
    storage.write('user_name', name);
    log('user_image $user_image');
    storage.write('user_image', user_image);
    Auth.errormesssage='no';
  }

  static messageFunc(BuildContext context,int responseCode, String resbody, bool auth,{bool from_customer=false}) {
    switch (responseCode) {
      case 200:
      case 201:
        {
          if(  resbody.contains('error')) {
            Auth.errormesssage = 'Invalid data';
            return;
          }
        auth?  Auth.active_status=json.decode(resbody)['data']['status'].toString():null;
          auth?  Auth.user_id=json.decode(resbody)['data']['id'].toString():null;
          auth?Auth.user_email=json.decode(resbody)['data']['email'].toString():null;
          auth?
          Auth.user_image=json.decode(resbody)['data']['image']??'':
          Auth.user_image=json.decode(resbody)['data']['image'];
          var fname=json.decode(resbody)['data']['fristName']??'';
          var lname=   json.decode(resbody)['data']['lastName']??'';
          auth?Auth.username=
             fname +' '+ lname:null;
          auth ? saveToken(json.decode(resbody)['data']['access_token'],
            from_customer?false:  true,Auth.user_id,Auth.user_email,Auth.username) : Auth.errormesssage = 'no';

          print(responseCode);
        }
        break;
      case 400:
        {
          Auth.errormesssage = '${gettranslated(context, "Invalid data")}';
          print(responseCode);
        }
        break;
      case 401:
        {
          Auth.errormesssage = '${gettranslated(context, "Invalid data")}';
          print(responseCode);
        }
        break;
      case 403:
        {
          Auth.errormesssage = '${gettranslated(context, "Invalid data")}';
          print(responseCode);
        }
        break;
      case 404:
        {
          Auth.errormesssage = '${gettranslated(context, "You did something NOT FOUND !")}';
          print(responseCode);
        }
        break;
      case 500:
        {
          Auth.errormesssage = '${gettranslated(context, "Invalid data or Server Error : we have a problem just try again later")}';
          print(responseCode);
        }
        break;
      default:
        {
          Auth.errormesssage =
          '${gettranslated(context, "Invalid data or something wrong just connect us later")}';
          print(responseCode);
        }
    }
  }
}