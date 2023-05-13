import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';
import 'package:ticketing_system/main.dart';
import 'package:ticketing_system/view/screens/login/login_screen.dart';

import '../../controller/page_route.dart';
import '../../controller/provider/admin_provider.dart';
import '../../controller/user_controller.dart';
import '../widgets/drawer.dart';
import 'dashboard.dart';
import 'old_version.dart';

class SplashScreen extends StatefulWidget {
  String? theme_name;
  String? splash_path;
  String? path;
  SplashScreen({this.theme_name,required this.splash_path,this.path});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void getversion()async{
    await User.getVersion();
  }

  void initState() {

    super.initState();
    getversion();


    Future.delayed(const Duration(seconds: 6), () {
      if(version_app.value=="1.1"){
        token_main==null||token_main==''?   Navigator.of(context)
            .pushReplacement(createRoute(LoginScreen())):Navigator.of(context).push( createRoute(Dashboard())); // Prints after 1 second.
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OldVersion()));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: widget.path == null
          ? BoxDecoration(
          color: _themeProvider.backgroundColor)
          : BoxDecoration(
            //  color: _themeProvider.backgroundColor,
              image: DecorationImage(
                image: AssetImage(widget.path!),
                fit: BoxFit.cover,
              ),
            ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.theme_name == 'light_blue' ||widget.theme_name==null||
                  widget.theme_name == 'light_pink' ||
                  widget.theme_name == 'light_blue_gray'
              ? SizedBox(
                  height: height * .26,
                )
              : SizedBox(
                  height: height * .14,
                ),
     widget.splash_path==null?Center(
       child: SvgPicture.asset(
         'assets/images/frame_splash.svg',
       ),
     )    :Center(
            child: SvgPicture.asset(
              widget.splash_path!,
            ),
          ),
        ],
      ),
    ));
  }
}
