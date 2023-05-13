

import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/login_controller.dart';
import 'package:ticketing_system/controller/provider/admin_provider.dart';
import 'package:ticketing_system/controller/provider/user_provider.dart';
import 'package:ticketing_system/model/user_model.dart';
import 'package:ticketing_system/view/screens/profile_settings/change_password.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_detail.dart';

import '../../../controller/page_route.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../controller/user_controller.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../dashboard.dart';
import '../notification.dart';
import 'change_image.dart';
import 'deactive_account.dart';

class ProfileSettings extends StatefulWidget {

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  // Color black_color = Color(0xff2c2b2b);
  String length='0';
  getUnReadNotificationLength()async{
    length=await User.getUnreadableNotificationLength();
    myValueNotifier.value=length;
    setState(() {
      ;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnReadNotificationLength();
  }
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
    UserProvider _userprovider =Provider.of<UserProvider>(context,listen: false);
    AdminProvider adminProvider=Provider.of<AdminProvider>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(backgroundColor: _themeProvider.primaryColor,foregroundColor: _themeProvider.primaryColorLight,elevation: 0,
      title:  Text('${gettranslated(context, "Profile")}',style: TextStyle(
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
        //  IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
     drawer: DrawerPage(),
    body: Container(width:width,height:height,
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
        ), Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.01,vertical: height*.03),
          child: IconButton(icon: Icon(Icons.arrow_back,color: _themeProvider.primaryColorLight,), onPressed: () {
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
            NetworkImage('assets/images/icon.png')
                :NetworkImage(adminProvider.user_image),
            // Auth.user_image==''?
            // Image.asset('assets/images/icon.png',color: _themeProvider.primaryColorLight,fit: BoxFit.cover,):
            // FadeInImage(image: NetworkImage(Auth.user_image), placeholder: AssetImage('assets/images/icon.png'))

        )),
        Column(
          children: [
            SizedBox(height: height*.15,),
            InkWell(
              child:  CustomListTile(context, _themeProvider.primaryColorLight,
                  Icon(Icons.manage_accounts,color: _themeProvider.primaryColorLight,),'${gettranslated(context, "Profile Details")}',_themeProvider),
              onTap: ()async{

    List<String> dd=await FlutterNativeTimezone.getAvailableTimezones();
                Loader.show(context,progressIndicator:CircularProgressIndicator(color: _themeProvider.primaryColor,));
              UserModel user=  await User.getProfileData();
              _userprovider.setuserProfile(user);
               Loader.hide();
                Navigator.of(context).push( createRoute(ProfileDetail(user,dd)));
              },
            ),InkWell(
              child:        CustomListTile(context, _themeProvider.primaryColorLight,Icon(Icons.lock,color: _themeProvider.primaryColorLight),'${gettranslated(context, "Change Password")}',_themeProvider),
              onTap: (){
                Navigator.of(context).push( createRoute(ChangePassword()));
            },
            ),
            InkWell(
              child:    CustomListTile(context, _themeProvider.primaryColorLight,Icon(Icons.image,color: _themeProvider.primaryColorLight),'${gettranslated(context, "Change Your Image")}',_themeProvider),
              onTap: (){
                Navigator.of(context).push( createRoute(ChangeImage()));
              }),
              InkWell(
                child:     CustomListTile(context, _themeProvider.primaryColorLight,Icon(Icons.pan_tool,color: _themeProvider.primaryColorLight),'${gettranslated(context, "Deactive Your Account")}',_themeProvider),
                onTap: (){
                  Navigator.of(context).push( createRoute(DeactiveAccount()));
                },)

       ],
        )

      ],),
    )
    ,
    );
  }
}
CustomListTile(context,black_color,icon,title,ThemeProvider  themeProvider){
  return  ListTile(
    leading: icon,

    title:  Text(title,style: TextStyle(color: themeProvider.primaryColorLight),),

  );
}
