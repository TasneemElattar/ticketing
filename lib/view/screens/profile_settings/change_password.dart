
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/view/widgets/alert_message.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../controller/provider/user_provider.dart';
import '../../../controller/user_controller.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/button.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../notification.dart';
import 'change_image.dart';

class ChangePassword extends StatelessWidget {

  // Color black_color = Color(0xff2c2b2b);
  // Color purple = Color(0xffd8cfed);
  TextEditingController oldPassword_controller=TextEditingController();
  TextEditingController newPassword_controller=TextEditingController();
  TextEditingController confirm_new_Password_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider=Provider.of<AdminProvider>(context);
    UserProvider _userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: _themeProvider.primaryColor,foregroundColor: _themeProvider.primaryColorLight,elevation: 0,
        title: Text('${gettranslated(context, "Profile")}',style: TextStyle(
          fontFamily: 'SourceSansPro',
          color: _themeProvider.primaryColorLight,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,

        ),),actions: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: .01*height),
            child: Badge(label: Text(myValueNotifier.value),
              child: IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(createRoute(NotificationScreen()));

                  },
                  icon: Icon(Icons.notifications)),
            ),
          ),
          SizedBox(width: width*.07,)


        ],),
      drawer:Container(
          width: width*.7,
          child: DrawerPage()
      ),
      body: SingleChildScrollView(
        child: Container(width:width,height:height,
    decoration: _themeProvider.path==null?BoxDecoration(color:_themeProvider. backgroundColor,):
    BoxDecoration(
    color:_themeProvider. backgroundColor,
    image:  DecorationImage(
    image: AssetImage(_themeProvider.path!),
    fit: BoxFit.cover,
    ),),
          child: Stack(children: [

            Container(width: width,height: height*.09,color:_themeProvider.primaryColor,
              child: Column(children: [
                SizedBox(height: height*.01,),

              ],),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.01,vertical: height*.03),
              child: IconButton(icon: Icon(Icons.arrow_back,color:  _themeProvider.primaryColorLight,),onPressed: (){
              Navigator.pop(context);
              }),
            ),
            Positioned(
                left: width*.38,
                right: width*.39,
                top:height*.03,child: CircleAvatar(
              radius: width * .1,
              backgroundColor: _themeProvider.backgroundColor,
              backgroundImage: adminProvider.user_image==''?
              AssetImage('assets/images/icon.png') as ImageProvider
                  :NetworkImage(adminProvider.user_image),
              // Auth.user_image==''?
              // Image.asset('assets/images/icon.png',color: _themeProvider.primaryColorLight,fit: BoxFit.cover,):
              // FadeInImage(image: NetworkImage(Auth.user_image), placeholder: AssetImage('assets/images/icon.png'))

            )),
            Positioned(
                left: width*.33,
              //  right: width*.4,
                top:height*.16,child: InkWell(
                onTap: (){
                  Navigator.of(context).push( createRoute(ChangeImage()));
                },
                child: Text('${gettranslated(context, "Change Your Image")}',style: TextStyle(color:  _themeProvider.primaryColorLight),))),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*.18,),
                Container(
                  decoration: BoxDecoration(
                    //   color: Color(0xffe4eef3),
                    //  border: Border.all(color:Color(0xff8e8c8c),),
                      border: Border(
                          top: BorderSide( width: 3,color:_themeProvider.white_color, // Color(0xff2c2b2b)
                          )     , bottom: BorderSide( width: 3,color:_themeProvider.light_border_color ),
                          left: BorderSide( width: 3,color:_themeProvider.light_border_color ),
                          right: BorderSide( width: 3,color:_themeProvider.light_border_color )
                      )
                    //    borderRadius:BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:   EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*.02,),
                    Text('${gettranslated(context, "Change Password")}', textAlign: TextAlign.left, style: TextStyle(
                        color: _themeProvider.primaryColorLight,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 18,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w500,
                        height: 1
                    ),),SizedBox(height: height*.01,),
                    TextTile('${gettranslated(context, "Old Password")}',height,_themeProvider),
                    MyTextField(hinttext: '${gettranslated(context, "Old Password")}',controllerValue: oldPassword_controller,),
                    TextTile('${gettranslated(context, "New Password")}',height,_themeProvider),
                    MyTextField(hinttext: '${gettranslated(context, "New Password")}',controllerValue: newPassword_controller,),
                    TextTile('${gettranslated(context, "Confirm Password")}',height,_themeProvider),
                    MyTextField(hinttext: '${gettranslated(context, "Confirm Password")}',controllerValue: confirm_new_Password_controller,),
                ],),
                  ),),
SizedBox(height: height*.04,),
                  InkWell(
                      onTap: ()async {
                        FocusManager.instance.primaryFocus?.unfocus();
                 if(newPassword_controller.text==confirm_new_Password_controller.text){
                   var status = await User.change_password(
                       oldpassword: oldPassword_controller.text,
                       newpassword: newPassword_controller.text,
                       confirmpassword: confirm_new_Password_controller
                           .text);
                   if (status == 200 && User.err_password == 'success') {
                     ScaffoldMessenger.of(context)
                         .showSnackBar(showsnack(
                         width, _themeProvider, '${gettranslated(context, "saved successfully..")}',
                         Icons.check));
                     Navigator.pop(context);
                   } else {
                     ScaffoldMessenger.of(context)
                         .showSnackBar(showsnack(
                         width, _themeProvider, "${gettranslated(context, "something wrong !")}",
                         Icons.error));
                   }}else{
                     Alertmessage(context, 'Password does not match !', _themeProvider, width, height);
                 }

                      },           child: Button( title: '${gettranslated(context, "Save")}',))
                ],
              ),
            )

          ],),
        ),
      )
      ,
    );
  }
}
TextTile(title,height,ThemeProvider provider){
  return Padding(
    padding:  EdgeInsets.only(top: height*.03,bottom: height*.01),
    child: Text(title, textAlign: TextAlign.left, style: TextStyle(
        color:  provider.primaryColorLight,
        fontFamily: 'Source Sans Pro',
        fontSize: 16,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.w500,
        height: 1
    ),),
  );
}