
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/model/customer_model.dart';
import 'package:ticketing_system/view/screens/customer/all_customers.dart';
import 'package:ticketing_system/view/screens/employee/add_new_employee.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';

import 'dart:io';
import '../../../controller/admin_controller.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/get_time_zone.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../notification.dart';
import '../profile_settings/profile_detail.dart';

class AddCustomer extends StatefulWidget {
  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  // Color black_color= Color(0xff2c2b2b);

  TextEditingController first_name_controller = TextEditingController();
  TextEditingController last_name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController mobile_number_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController country_controller = TextEditingController();
  TextEditingController time_zone_controller = TextEditingController();
  List<String> timeZoneList = [];

  gettimezones() async {
    timeZoneList = await FlutterNativeTimezone.getAvailableTimezones();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    first_name_controller.text = '';
    last_name_controller.text = '';
    password_controller.text = '';
    mobile_number_controller.text = '';
    email_controller.text = '';
    country_controller.text = '';
    time_zone_controller.text = '';
    gettimezones();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var selectedPageNumber = 3;
    // SubCategoriesProvider subcategory_provider=Provider.of<SubCategoriesProvider>(context);
    // ProjectsProvider project_provider=Provider.of<ProjectsProvider>(context);
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
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
          title: Text('SVITSM',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: _themeProvider.primaryColorLight,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.15,
              )),
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
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(ProfileSettings()));
                },
                icon: Icon(
                  Icons.account_circle,
                  size: 27,
                ))
          ],
        ),
        drawer: Container(width: width * .7, child: DrawerPage()),
        body: Container(
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
          child: Container(
            height: height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * .01, horizontal: width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * .008, horizontal: width * .04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: _themeProvider.primaryColorLight,
                              )),
                          SizedBox(
                            width: width * .1,
                          ),
                          Text('${gettranslated(context, "Add New Customer")}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: _themeProvider.primaryColorLight,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.15,
                              )),
                        ],
                      ),
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
                                  color: _themeProvider.light_border_color))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .02, vertical: height * .01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                custom_text(
                                    '${gettranslated(context, "First Name")}', height, _themeProvider),
                                requireText(context,width, height)
                              ],
                            ),
                            MyTextField(
                              hinttext: '${gettranslated(context, "First Name")}',
                              controllerValue: first_name_controller,
                            ),
                            Row(
                              children: [
                                custom_text(
                                    '${gettranslated(context, "Last Name")}', height, _themeProvider),
                                requireText(context,width, height)
                              ],
                            ),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Last Name")}',
                              controllerValue: last_name_controller,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                custom_text('${gettranslated(context, "Password")}', height, _themeProvider),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * .018),
                                    child: Text(
                                      '${gettranslated(context, "(please, copy and save it)")}',
                                      style: TextStyle(
                                          color:
                                              _themeProvider.primaryColorLight),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: height * 0.008,
                                  ),
                                  child: requireText(context,width, height),
                                )
                              ],
                            ),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Password")}',
                              controllerValue: password_controller,
                            ),
                            custom_text(
                                '${gettranslated(context, "Mobile Number")}', height, _themeProvider),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Mobile Number")}',
                              controllerValue: mobile_number_controller,
                            ),
                            Row(children: [
                              custom_text('${gettranslated(context, "Email")}', height, _themeProvider),
                              requireText(context,width, height)
                            ]),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Email")}',
                              controllerValue: email_controller,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTileD('${gettranslated(context, "Country")}', height, _themeProvider),
                                requireText(context,width, height)
                              ],
                            ),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Country")}',
                              controllerValue: country_controller,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTileD('${gettranslated(context, "Time Zone")}', height, _themeProvider),
                                requireText(context,width, height)
                              ],
                            ),
                            GetTimeZones(
                                width,
                                height,
                                "${gettranslated(context, "Time Zone")}",
                                _themeProvider,
                                time_zone_controller,
                                timeZoneList),
                            SizedBox(
                              height: height * .01,
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            InkWell(
                                onTap: () async {
                                  Loader.show(context,
                                      progressIndicator:
                                          CircularProgressIndicator(
                                        color: _themeProvider.primaryColorLight,
                                      ));
                                  if (timeZoneList
                                      .contains(time_zone_controller.text)) {
                                    Customer customer = Customer(
                                        date: "",
                                        userType: "",
                                        first_name: first_name_controller.text,
                                        last_name: last_name_controller.text,
                                        password: password_controller.text,
                                        mobile_number:
                                            mobile_number_controller.text,
                                        email: email_controller.text,
                                        country: country_controller.text,
                                        timezone: time_zone_controller.text);

                                    if (first_name_controller.text == '' ||
                                        password_controller.text == '' ||
                                        email_controller.text == '' ||
                                        last_name_controller.text == '' ||
                                        time_zone_controller.text == '' ||
                                        country_controller.text == '') {
                                      Loader.hide();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showsnack(
                                              width,
                                              _themeProvider,
                                              '${gettranslated(context, "Please Complete data !")}',
                                              Icons.error));
                                    } else {
                                      //add
                                      var status =
                                          await Admin.addCustomer(customer);
                                      status == 200
                                          ? [
                                              Loader.hide(),
                                              Navigator.of(context).push(
                                                  createRoute(AllCustomers())),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(showsnack(
                                                      width,
                                                      _themeProvider,
                                                      '${gettranslated(context, "added successfully")}',
                                                      Icons.check))
                                            ]
                                          : [
                                              Loader.hide(),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(showsnack(
                                                      width,
                                                      _themeProvider,
                                                      '${gettranslated(context, "Please enter valid data !")}',
                                                      Icons.error))
                                            ];
                                    }
                                  } else {
                                    Loader.hide();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        showsnack(
                                            width,
                                            _themeProvider,
                                            '${gettranslated(context, "Please select from timezones list !")}',
                                            Icons.error));
                                  }
                                },
                                child: Button(title: '${gettranslated(context, "Create Customer")}'))
                          ],
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

custom_text(String title, height, ThemeProvider provider) {
  return Padding(
    padding: EdgeInsets.only(bottom: height * .02, top: height * .02),
    child: Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: provider.primaryColorLight,
          fontFamily: 'Source Sans Pro',
          fontSize: 17,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.w500,
          height: 1),
    ),
  );
}
