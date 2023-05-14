
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/view/widgets/button.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../login/login_screen.dart';
import '../notification.dart';
import 'change_image.dart';

class DeactiveAccount extends StatefulWidget {
  @override
  State<DeactiveAccount> createState() => _DeactiveAccountState();
}

class _DeactiveAccountState extends State<DeactiveAccount> {
  Color black_color = Color(0xff2c2b2b);

  Color purple = Color(0xffd8cfed);
  bool isCkecked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider=Provider.of<AdminProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeProvider.primaryColor,
        foregroundColor: _themeProvider.primaryColorLight,
        elevation: 0,
        title: Text(
          '${gettranslated(context, "Profile")}',
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            color:_themeProvider.primaryColorLight,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
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

          //  IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      drawer: Container(width: width * .7, child: DrawerPage()),
      body: Container(width:width,height:height,
    decoration: _themeProvider.path==null?BoxDecoration(color:_themeProvider. backgroundColor,):
    BoxDecoration(
    color:_themeProvider. backgroundColor,
    image:  DecorationImage(
    image: AssetImage(_themeProvider.path!),
    fit: BoxFit.cover,
    ),),
        child: Stack(
          children: [
            Container(
              width: width,
              height: height * .09,
              color: _themeProvider.primaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.01,vertical: height*.03),
              child: IconButton(
                  icon: Icon(Icons.arrow_back,color: _themeProvider.primaryColorLight,),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),     Positioned(
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
                child: Text('${gettranslated(context, "Change Your Image")}',style: TextStyle(color: _themeProvider.primaryColorLight),))),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .04, vertical: height * .023),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * .18,
                  ),
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
                padding:  EdgeInsets.symmetric(
                    horizontal: width * .03, vertical: height * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height*.01,),
                      Text(
                    '${gettranslated(context, "Deactive Your Account")}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: _themeProvider.primaryColorLight,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 18,
                        letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w500,
                        height: 1),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Text(
                    '${gettranslated(context, "Once you delete your account, you can not access your account with the same credentials. You need to re-register your account.")}',
                    style: TextStyle(height: 1.5,color: _themeProvider.primaryColorLight),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          side: BorderSide(color: _themeProvider.primaryColorLight),
                          checkColor: _themeProvider.primaryColor,
                          activeColor: _themeProvider.primaryColorLight.withOpacity(0.3),
                          value: this.isCkecked,
                          onChanged: (value) {
                            setState(() {
                              this.isCkecked = value!;
                            });
                          },
                        ),
                         Text(
                            "${gettranslated(context, "I have read and agree to the Terms of services")}",
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              color: _themeProvider.primaryColorLight,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            ))
                      ],
                    ),
                  ),
                ],),
              ),
            ),SizedBox(height: height*.02,),
                  InkWell(
                    onTap: ()async{
                      final storage = new GetStorage();
                if(isCkecked==true){
                  var status=     await User.deactive_account();
                  status==200?[ScaffoldMessenger.of(context)
                      .showSnackBar(showsnack(width,_themeProvider,'Account decativated successfully..',Icons.check)),

                      storage.write('token', null),
                      storage.write('isAdmin', null),
                      storage.write('user_id', null),
                      storage.write('user_email', null),
                      Navigator.pop(context),
                      Navigator.of(context).push( createRoute(LoginScreen()))
                  ]:ScaffoldMessenger.of(context)
                      .showSnackBar(showsnack(width,_themeProvider,"something wrong !",Icons.error));
                }else{
                  ScaffoldMessenger.of(context)
                      .showSnackBar(showsnack(width,_themeProvider,"Please Agree these terms !",Icons.error));
                }
                    },
                    child: Button(title: '${gettranslated(context, "Deactive Your Account")}',),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
