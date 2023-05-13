
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/model/user_model.dart';
import 'package:ticketing_system/view/screens/profile_settings/change_image.dart';
import 'package:ticketing_system/view/widgets/snackbar.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../controller/provider/user_provider.dart';
import '../../../controller/user_controller.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/alert_message.dart';
import '../../widgets/button.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../dashboard.dart';
import '../notification.dart';

class ProfileDetail extends StatefulWidget {
UserModel user;
List <String>current_timezone;
ProfileDetail(this.user,this.current_timezone);
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  // Color black_color = Color(0xff2c2b2b);
  final TextEditingController firstName_controller = TextEditingController();

  TextEditingController lastName_controller = TextEditingController();

  TextEditingController email_controller = TextEditingController();

  TextEditingController mobile_controller = TextEditingController();

  TextEditingController country_controller = TextEditingController();

  TextEditingController timezone_controller = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstName_controller.text=widget.user.fristName=='null'?firstName_controller.text='':firstName_controller.text=widget.user.fristName!;
    lastName_controller.text=widget.user.lastName=='null'?lastName_controller.text='':lastName_controller.text=widget.user.lastName!;
    email_controller.text=widget.user.email=='null'?email_controller.text='':email_controller.text=widget.user.email!;
    mobile_controller.text=widget.user.phone=='null'?mobile_controller.text='':mobile_controller.text=widget.user.phone!;
    country_controller.text=widget.user.country=='null'?country_controller.text='':country_controller.text=widget.user.country!;
    timezone_controller.text=widget.user.timezone=='null'?timezone_controller.text='':timezone_controller.text=widget.user.timezone!;

}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider=Provider.of<AdminProvider>(context);
    UserProvider _userprovider =Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus;
        currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _themeProvider.primaryColor,
          foregroundColor: _themeProvider.primaryColorLight,
          elevation: 0,
          title: Text(
            '${gettranslated(context, "Profile")}',
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: _themeProvider.primaryColorLight,
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
          ],
        ),
        drawer: Container(width: width * .7, child: DrawerPage()),
        body: SingleChildScrollView(
         // physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: width,
            height: height,
            decoration: _themeProvider.path == null
                ? BoxDecoration(
                    color: _themeProvider.backgroundColor,
                  )
                : BoxDecoration(
                    color: _themeProvider.backgroundColor,
                    image: DecorationImage(
                      image: AssetImage(_themeProvider.path!),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                      icon: Icon(Icons.arrow_back,
                          color: _themeProvider.primaryColorLight),
                      onPressed: () {
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
                // Positioned(
                //     left: width * .39,
                //     right: width * .4,
                //     top: height * .03,
                //     child: CircleAvatar(
                //       radius: width * .1,
                //       backgroundColor: _themeProvider.backgroundColor,
                //       child:
                //       _userprovider.userModel!.image==null||_userprovider.userModel!.image=='null'?
                //       Image.asset('assets/images/icon.png',color: _themeProvider.primaryColorLight,):
                //       FadeInImage(image: NetworkImage(_userprovider.userModel!.image!), placeholder: AssetImage('assets/images/icon.png'))
                //
                //     )),
                Positioned(
                    left: width * .33,
                    //  right: width*.4,
                    top: height * .15,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(createRoute(ChangeImage()));
                        },
                        child: Text(
                          '${gettranslated(context, "Change Your Image")}',
                          style: TextStyle(
                              color: _themeProvider.primaryColorLight),
                        ))),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .07, vertical: height * .01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * .18,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                  width: 3,
                                  color: _themeProvider
                                      .white_color, // Color(0xff2c2b2b)
                                ),
                                bottom: BorderSide(
                                    width: 3,
                                    color: _themeProvider.light_border_color),
                                left: BorderSide(
                                    width: 3,
                                    color: _themeProvider.light_border_color),
                                right: BorderSide(
                                    width: 3,
                                    color: _themeProvider.light_border_color))
                            //    borderRadius:BorderRadius.circular(8),
                            ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .03, vertical: height * .01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .01,
                              ),
                              Text(
                                '${gettranslated(context, "Profile Details")}',
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
                                height: height * .01,
                              ),
                              TextTileD('${gettranslated(context, "First Name")}', height, _themeProvider),
                              MyTextField(
                                hinttext: '${gettranslated(context, "First Name")}',
                                controllerValue: firstName_controller,
                              ),
                              TextTileD('${gettranslated(context, "Last Name")}', height, _themeProvider),
                              MyTextField(
                                hinttext: '${gettranslated(context, "Last Name")}',
                                controllerValue: lastName_controller,
                              ),
                              TextTileD('${gettranslated(context, "Email")}', height, _themeProvider),
                              MyTextField(
                                hinttext: '${gettranslated(context, "Email")}',
                                controllerValue: email_controller,emailprofile: true,
                              ),
                              TextTileD(
                                  '${gettranslated(context, "Mobile Number")}', height, _themeProvider),
                              MyTextField(
                                hinttext: '${gettranslated(context, "Mobile Number")}',
                                controllerValue: mobile_controller,
                              ),
                              TextTileD('${gettranslated(context, "Country")}', height, _themeProvider),
                              MyTextField(
                                hinttext: '${gettranslated(context, "Country")}',
                                controllerValue: country_controller,
                              ),
                              TextTileD('${gettranslated(context, "Time Zone")}', height, _themeProvider),
                              // MyTextField(
                              //   hinttext: 'Time Zone',
                              //   controllerValue: timezone_controller,
                              // ),
                              get_time_zone(width, height, "${gettranslated(context, "Time Zone")}", _themeProvider)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      InkWell(
                        onTap: ()async{
                      if(profileEdit.value=="false"){
                        Alertmessage(context,'${gettranslated(context,"Not have a permission")}',_themeProvider,width,height);
                      }else{
                        FocusManager.instance.primaryFocus?.unfocus();
                        var status= await    User.update_profile(fname: firstName_controller.text??"", lastname: lastName_controller.text??"",
                            email: email_controller.text??"", phone: mobile_controller.text??"", country: country_controller.text??"",
                            timezone: timezone_controller.text??"");
                        status==200?[ScaffoldMessenger.of(context)
                            .showSnackBar(showsnack(width,_themeProvider,'${gettranslated(context, "saved successfully..")}',Icons.check)),
                          Navigator.pop(context)
                        ]:ScaffoldMessenger.of(context)
                            .showSnackBar(showsnack(width,_themeProvider,"${gettranslated(context, "something wrong !")}",Icons.error));
                      }
                       },
                        child: Button(
                          title: '${gettranslated(context, "Save")}',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget get_time_zone(width,height,String title,ThemeProvider themeProvider ){
    return Container(
      width: width*.5,
      height: height*.055,
      child: TypeAheadFormField(
        hideSuggestionsOnKeyboardHide:true,
        direction: AxisDirection.up,
        textFieldConfiguration: TextFieldConfiguration(onChanged: (value){
        },style: TextStyle(color: themeProvider.primaryColorLight),
          textDirection: TextDirection.ltr,
          controller: timezone_controller,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(filled: true,fillColor: themeProvider.textfieldColor,
            hintText: '${gettranslated(context, "select time zone")}',
            hintStyle: TextStyle(color:themeProvider.primaryColorLight.withOpacity(0.5)),
            contentPadding:
            EdgeInsets.only(
                left: 8.0,
                bottom: 8.0,
                top: 8.0),
            isDense: true,

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: themeProvider.primaryColor,
                width: 1.5,
              ),
            ),
            // labelStyle:  TextStyle(overflow: TextOverflow.visible,color: themeProvider.primaryColorLight,
            //     fontSize: width*.03
            // ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: themeProvider.primaryColor)
            ),

            suffixIcon: Icon(Icons.keyboard_arrow_down,size: width*.06,color: themeProvider.textfieldColor,),
          ),
        ),
        suggestionsCallback: (pattern) {

          return
            widget.current_timezone.where((String  element) =>
                element.toLowerCase().contains(pattern.toLowerCase()));

        },
        itemBuilder: (_,String ittem) => widget.current_timezone.length==0?Center(child: CircularProgressIndicator()):ListTile(
          title: InkWell(
            child: Row(
              children: [
                Expanded(child: Text(ittem.toString(),style: TextStyle(overflow: TextOverflow.visible,
                    fontSize: width*.037,
                ))),
                SizedBox(width: 0.05,)
              ],
            ),
          ),
        ),
        onSuggestionSelected: ( String val) async{

          timezone_controller.text=val;

          setState(() {
          });
        },
        getImmediateSuggestions: true,
        validator: (value) {
          if (value!.isEmpty) {
            return '${gettranslated(context, "Select")}';
          }
        },
      ),
    );
  }
}

TextTileD(title, height, ThemeProvider _themeprovider) {
  return Padding(
    padding: EdgeInsets.only(top: height * .01, bottom: height * .01),
    child: Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: _themeprovider.primaryColorLight,
          fontFamily: 'Source Sans Pro',
          fontSize: 16,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.w500,
          height: 1),
    ),
  );
}
