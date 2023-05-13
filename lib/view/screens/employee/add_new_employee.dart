import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/admin_controller.dart';
import 'package:ticketing_system/model/employee.dart';
import 'package:ticketing_system/view/screens/employee/all_employee.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';
import 'package:ticketing_system/view/widgets/get_time_zone.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../notification.dart';
import '../profile_settings/profile_detail.dart';

class AddEmployee extends StatefulWidget {
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  // Color black_color= Color(0xff2c2b2b);

  TextEditingController first_name_controller = TextEditingController();
  TextEditingController last_name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController employee_id_controller = TextEditingController();
  TextEditingController mobile_number_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController skills_controller = TextEditingController();
  TextEditingController counry_controller = TextEditingController();
  TextEditingController timezone_controller = TextEditingController();
  List<String> roles = [];
  String? dropdownvalue;
  List<String> timeZoneList = [];

  gettimezones() async {
    timeZoneList = await FlutterNativeTimezone.getAvailableTimezones();
    setState(() {});
  }
 getRoles()async{
    List<String> rolesapi=await Admin.getempRoles();
    roles=rolesapi;
    setState(() {

    });
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    first_name_controller.text = '';
    last_name_controller.text = '';
    password_controller.text = '';
    employee_id_controller.text = '';
    mobile_number_controller.text = '';
    email_controller.text = '';
    skills_controller.text = '';
    counry_controller.text = '';
    timezone_controller.text = '';
    getRoles();
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
                          Text('${gettranslated(context, "Add New Employee")}',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              children: [
                                custom_text(
                                    '${gettranslated(context, "Employee ID")}', height, _themeProvider),
                                requireText(context,width, height),
                              ],
                            ),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Employee ID")}',
                              controllerValue: employee_id_controller,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                custom_text('${gettranslated(context, "Role")}', height, _themeProvider),
                                requireText(context,width, height),
                              ],
                            ),
                            Container(
                                height: height * .05,
                                width: width * .9,
                                decoration: BoxDecoration(
                                    color: _themeProvider.backgroundColor,
                                    border: Border.all(
                                        color: _themeProvider.primaryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2),
                                    child: DropdownButtonFormField(
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: _themeProvider
                                                .primaryColorLight
                                                .withOpacity(0.5)),
                                        dropdownColor:
                                            _themeProvider.backgroundColor,
                                        items: roles.map((String lang) {
                                          return new DropdownMenuItem(
                                              value: lang,
                                              child: Text(
                                                lang,
                                                style: TextStyle(
                                                    color: _themeProvider
                                                        .primaryColorLight),
                                              ));
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          dropdownvalue = newValue!;

                                          setState(() {});
                                        },
                                        value: dropdownvalue,
                                        decoration: InputDecoration.collapsed(
                                            fillColor: Colors.grey[200],
                                            hintText: '${gettranslated(context, "Select Role")}',
                                            hintStyle: TextStyle(
                                                color: _themeProvider
                                                    .primaryColorLight
                                                    .withOpacity(0.5))
                                            //   errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                                            )))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    custom_text(
                                        '${gettranslated(context, "Password")}', height, _themeProvider),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: height * .01,
                                        ),
                                        child: Text(
                                          '${gettranslated(context, "(please, copy and save it)")}',
                                          style: TextStyle(
                                              color: _themeProvider
                                                  .primaryColorLight),
                                        ),
                                      ),
                                    ),
                                    requireText(context,width, height)
                                  ],
                                ),
                                Text(
                                  '${gettranslated(context, "must be at least 8 characters")}',
                                  style: TextStyle(
                                      color: _themeProvider.primaryColorLight
                                          .withOpacity(0.5),
                                      fontSize: width * .033),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * .01,
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                custom_text('${gettranslated(context, "Email")}', height, _themeProvider),
                                requireText(context,width, height),
                              ],
                            ),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Email")}',
                              controllerValue: email_controller,
                            ),
                            custom_text('${gettranslated(context, "Skills")}', height, _themeProvider),
                            MyTextField(
                              hinttext: '${gettranslated(context, "Skills")}',
                              controllerValue: skills_controller,
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
                              controllerValue: counry_controller,
                            ),
                            SizedBox(
                              height: height * .001,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTileD('${gettranslated(context, "Time Zone")}', height, _themeProvider),
                                requireText(context,width, height)
                              ],
                            ),
                            // MyTextField(
                            //   hinttext: 'Time Zone',
                            //   controllerValue: timezone_controller,
                            // ),
                            GetTimeZones(
                                width,
                                height,
                                "${gettranslated(context, "Time Zone")}",
                                _themeProvider,
                                timezone_controller,
                                timeZoneList),
                            SizedBox(
                              height: height * .01,
                            ),
                            InkWell(
                                onTap: () async {
                                  Loader.show(context,
                                      progressIndicator:
                                          CircularProgressIndicator(
                                        color: _themeProvider.primaryColorLight,
                                      ));

                                  Employee emp = Employee(
                                      date: '',
                                      first_name:
                                          first_name_controller.text ?? '',
                                      last_name:
                                          last_name_controller.text ?? '',
                                      role: dropdownvalue.toString() ?? '',
                                      emp_id: employee_id_controller.text ?? '',
                                      password: password_controller.text ?? '',
                                      email: email_controller.text ?? '',
                                      skills: skills_controller.text,
                                      status: '',
                                      verified: '',
                                      country: counry_controller.text,
                                      timezone: timezone_controller.text);
                                  if (timeZoneList
                                      .contains(timezone_controller.text)) {
                                    if (first_name_controller.text == '' ||
                                        employee_id_controller.text == '' ||
                                        dropdownvalue == null ||
                                        email_controller.text == '' ||
                                        last_name_controller.text == '' ||
                                        counry_controller.text == '' ||
                                        timezone_controller.text == '' ||
                                        password_controller.text == '') {
                                      Loader.hide();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showsnack(
                                              width,
                                              _themeProvider,
                                              '${gettranslated(context, "Please Complete data !")}',
                                              Icons.error));
                                    } else {
                                      //add
                                      var status = await Admin.addEmployee(emp);
                                      status == 200
                                          ? [
                                              Loader.hide(),
                                              Navigator.of(context).push(createRoute(AllEmployee())),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(showsnack(
                                                      width,
                                                      _themeProvider,
                                                      '${gettranslated(context, "added successfully")}',
                                                      Icons.check))
                                            ]
                                          : Loader.hide();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showsnack(
                                              width,
                                              _themeProvider,
                                              '${gettranslated(context, "Please enter valid data !")}',
                                              Icons.error));
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
                                child: Button(title: '${gettranslated(context, "Create Employee")}'))
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

requireText(context,width, height) {
  return Padding(
    padding:
        EdgeInsets.symmetric(vertical: height * .01, horizontal: width * .02),
    child: Text(
      '${gettranslated(context, "(required)")}',
      style: TextStyle(color: Colors.red),
    ),
  );
}

custom_text(String title, height, ThemeProvider provider) {
  return Padding(
    padding: EdgeInsets.only(bottom: height * .02, top: height * .01),
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
