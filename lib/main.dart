import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';
import 'package:ticketing_system/controller/provider/user_provider.dart';
import 'package:ticketing_system/services/localization.dart';
import 'package:ticketing_system/services/localization_methods.dart';
import 'package:ticketing_system/view/screens/settings.dart';
import 'package:ticketing_system/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controller/login_controller.dart';
import 'controller/provider/admin_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String? token_main ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  GetStorage storage = GetStorage();
  String? themename = await storage.read('name_theme');
  print('in main $themename');
  String? path = await storage.read('path');
  String? splash_path = await storage.read('frame_splash_path');
  print('splash $splash_path');
   token_main = await storage.read('token');
  bool? isAdmin = await storage.read('isAdmin');
 Auth.user_id= await storage.read('user_id')??'';
 Auth.user_email=await storage.read('user_email')??'';
  Auth.username=await storage.read('user_name')??'';
  Auth.user_image=await storage.read('user_image')??'';
  log('admin main $isAdmin   ${Auth.user_image}');
  runApp(MyApp(themename: themename, path: path,splash_path: splash_path,isAdmin:isAdmin));
}

class MyApp extends StatefulWidget {

  String? themename;
  String? path;
  String? splash_path;
  bool? isAdmin;
  MyApp({required this.themename, required this.path,required this.splash_path,required this.isAdmin});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(),),
        // ChangeNotifierProvider(create: (_) => SubCategoriesProvider(),),
        // ChangeNotifierProvider(create: (_) => ProjectsProvider(),),
        ChangeNotifierProvider(create: (_)=>AdminProvider()),
        ChangeNotifierProvider(create: (_)=>UserProvider())

      ],
      child: SimpleBuilder(
        builder: (context) {


          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Ticketing',
              //  theme: bluee,
              home: MysPLASH(themename: widget.themename,path: widget.path,splash_path:widget.splash_path,isAdmin:widget.isAdmin));
        },
      ),

    );
  }
}
class MysPLASH extends StatefulWidget {
  static void setTheLocale(BuildContext context,Locale? locale) async {
    _MysPLASHState? localSatate = context.findAncestorStateOfType<_MysPLASHState>();
    localSatate!.setlocale(locale);

  }

  String? themename;
  String? path;
  String? splash_path;
  bool? isAdmin;
  MysPLASH({required this.themename, required this.path,required this.splash_path,required this.isAdmin});

  @override
  State<MysPLASH> createState() => _MysPLASHState();
}

class _MysPLASHState extends State<MysPLASH> {
  @override
  Locale? _locale;

  void setlocale(Locale? locale) {
    if(locale!=null ) {
      setState(() {
        _locale = locale;
      });
    }

  }

  void getLocal()async{
    _locale = await getlocale();
    setState(() {

    });
    print(_locale?.languageCode);
  }

  void initState() {
    super.initState();
       getLocal();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context,listen: false);
      AdminProvider _adminprovider =Provider.of<AdminProvider>(context,listen: false);
        _adminprovider.setAdmin(widget.isAdmin??false);
      if (widget.themename == 'dark_blue' ){
        _themeProvider.setDarkBlue();
      }else  if (widget.themename == 'dark_pink' ){
        _themeProvider.setDarkBink();
      }else  if (widget.themename == 'dark_purple' ){
        _themeProvider.setDarkBurple();
      }else  if (widget.themename == 'light_blue' ){
        _themeProvider.setLightBlue();
      }else  if (widget.themename == 'light_pink' ){
        _themeProvider.setLightBink();
      }else  if (widget.themename == 'light_blue_gray' ){
        _themeProvider.setLightBlueGrey();
      }else{
        _themeProvider.setLightBlue();
      }




    });
  }
  @override
  Widget build(BuildContext context) {
  //  AdminProvider _adminprovider =Provider.of<AdminProvider>(context);

    // if(widget.isAdmin==true){ _adminprovider.setAdmin();};
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ticketing System',
        //  theme: bluee,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'EG')
        ],
        locale: _locale ,
        localizationsDelegates: [
          SetLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate

        ],
        localeResolutionCallback: (locale, supportedlocales) {
          for (var suppotedlocale in supportedlocales) {
            if (locale!.languageCode == suppotedlocale.languageCode &&
                locale.countryCode == suppotedlocale.countryCode) {
              language.value=suppotedlocale.languageCode;
              return suppotedlocale;
            }
          }
          language.value=supportedlocales.first.languageCode;
          return supportedlocales.first;
        },
        home: SplashScreen(theme_name: widget.themename, splash_path:widget.splash_path,path:widget.path));
  }
}
