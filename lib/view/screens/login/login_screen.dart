
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';
import 'package:ticketing_system/view/screens/login/login_user.dart';
import 'package:ticketing_system/view/widgets/button.dart';

import '../../../controller/login_controller.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/server_error.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/alert_message.dart';
import '../../widgets/my_text_field.dart';
import '../dashboard.dart';
import 'forget_password.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked=false;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider _adminprovider =Provider.of<AdminProvider>(context);
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus;
        currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
    width:width,height:height,
    decoration: _themeProvider.path==null?BoxDecoration(color:_themeProvider. backgroundColor,):
    BoxDecoration(
    color:_themeProvider. backgroundColor,
    image:  DecorationImage(
    image: AssetImage(_themeProvider.path!),
    fit: BoxFit.cover,
    ),),
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150,),
                   Container(
                     decoration: BoxDecoration(
                         border: Border(
                             top: BorderSide(
                               width: 3, color: _themeProvider.white_color, // Color(0xff2c2b2b)
                             ),
                             bottom:
                             BorderSide(width: 3, color: _themeProvider.light_border_color),
                             left:
                             BorderSide(width: 3, color: _themeProvider.light_border_color),
                             right: BorderSide(
                                 width: 3, color: _themeProvider.light_border_color))),
                     child: Padding(
                       padding:  EdgeInsets.symmetric(vertical:height*.03,horizontal: width*.02),
                       child: Form(
                         key: _formKey,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Center(child: Text('${gettranslated(context, "Customer Login")}',style: TextStyle(
                                 fontSize: width*.054,color: _themeProvider.primaryColorLight,fontWeight: FontWeight.bold),)),
                             SizedBox(height: height*.03,),
                             Text('${gettranslated(context, "Email")}', style: TextStyle(
                               fontFamily: 'SourceSansPro',
                               color: _themeProvider.primaryColorLight,
                               fontSize: 16,
                               fontWeight: FontWeight.w400,
                               fontStyle: FontStyle.normal,

                             ),),SizedBox(height: height*.02,),
                             MyTextField(hinttext: '${gettranslated(context, "Email")}',controllerValue: email_controller,login: true,),
                             SizedBox(height: height*.02,),
                             Text('${gettranslated(context, "Password")}', style: TextStyle(
                               fontFamily: 'SourceSansPro',
                               color: _themeProvider.primaryColorLight,
                               fontSize: 16,
                               fontWeight: FontWeight.w400,
                               fontStyle: FontStyle.normal,

                             ),),SizedBox(height: height*.02,),
                             MyTextField(hinttext: '${gettranslated(context, "Password")}',controllerValue: password_controller,login: true,),
                             // Row(
                             //   children: [
                             //     Checkbox(
                             //       side: BorderSide(color: _themeProvider.primaryColorLight),
                             //       checkColor: _themeProvider.primaryColorLight,
                             //       activeColor: Color(0xff8e8c8c).withOpacity(0.3),
                             //       value: this.isChecked,
                             //       onChanged: ( value) {
                             //         setState(() {
                             //           this.isChecked = value!;
                             //         });
                             //       },
                             //     ),
                             //      Text("Remember me",
                             //         style: TextStyle(
                             //           fontFamily: 'SourceSansPro',
                             //           color: _themeProvider.primaryColorLight,
                             //           fontSize: 13,
                             //           fontWeight: FontWeight.w600,
                             //           fontStyle: FontStyle.normal,
                             //
                             //
                             //         )
                             //     ),
                             //     SizedBox(height: height*.1,)
                             //   ],
                             // ),
                             SizedBox(height: height*.04,),
                             InkWell(
                                 onTap:()async{
                                   FocusManager.instance.primaryFocus?.unfocus();
                                   final storage = new GetStorage();
                               if(_formKey.currentState!.validate()){
                                 try{
                                   final result = await InternetAddress.lookup('example.com');
                                   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

                                     Loader.show(context,progressIndicator:CircularProgressIndicator(color: _themeProvider.primaryColorLight,));
                                     await Auth.NewCustomerlogin(context,email_controller.text, password_controller.text);
                                     Loader.hide();
                                     _adminprovider.setAdmin(Auth.isAdmin);
                                     log('admin ${Auth.isAdmin}');
                                     Auth.status==200&&Auth.errormesssage=='no'&&Auth.active_status=='1'?[
                                     Navigator.of(context).push( createRoute(Dashboard())),
                                       _adminprovider.setuserImage(Auth.user_image)
                                     ]
                                         :Auth.status==200&&Auth.errormesssage=='no'&&Auth.active_status=='0'?[
                                     Alertmessage(context,'${gettranslated(context, "This Account account is deactivated !")}',_themeProvider,width,height),
                                   storage.write('token', null),
                                   storage.write('isAdmin', null),
                                   storage.write('user_id', null),
                                   storage.write('user_email', null),
                                       _adminprovider.setuserImage(Auth.user_image)
                                     ]:
                                     Alertmessage(context,'${gettranslated(context, "something wrong or may be not a customer")}',_themeProvider,width,height);
                                   }

                                 }on SocketException catch (_) {
                                   Serevererror.anErroroccured(width, height, false);
                                   Loader.hide();
                                   print('not connected');
                                 }
                               }

                                 },
                                 child: Button(title: '${gettranslated(context, "Sign in")}')),
                             SizedBox(height: 15,),
                             // InkWell(
                             //   onTap: (){
                             //     Navigator.of(context).push( createRoute(ForgetPassword()));
                             //   },
                             //   child: Text("Forget password",
                             //       style: TextStyle(
                             //         fontFamily: 'SourceSansPro',
                             //         color:_themeProvider.primaryColorLight,
                             //         fontSize: 13,
                             //         fontWeight: FontWeight.w600,
                             //         fontStyle: FontStyle.normal,
                             //
                             //
                             //       )
                             //   ),
                             // ),
                             SizedBox(height: height*.04,),

                             InkWell(
                               onTap: (){
                                 Navigator.of(context).push( createRoute(LoginUserScreen()));
                               },
                               child: Center(
                                 child: Text("${gettranslated(context, "Login from here If you are user")}",
                                     style: TextStyle(
                                       fontFamily: 'SourceSansPro',
                                       color:_themeProvider.primaryColorLight.withOpacity(0.7),
                                       fontSize: 13,decoration: TextDecoration.underline,
                                       fontWeight: FontWeight.w600,
                                       fontStyle: FontStyle.normal,


                                     )
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
