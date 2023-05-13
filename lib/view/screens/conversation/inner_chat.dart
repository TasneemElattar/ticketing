import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';

import '../../../controller/page_route.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/employee.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../notification.dart';
import 'inner_real_conversation.dart';

class InnerChat extends StatefulWidget {
  @override
  State<InnerChat> createState() => _InnerChatState();
}

class _InnerChatState extends State<InnerChat> {
  // Color black_color= Color(0xff2c2b2b);

  TextEditingController group_name_controller = TextEditingController();
  TextEditingController employee_controller = TextEditingController();
  List<Employee> All_employees = [

  ];
  List<Employee> selected_employees = [];
  Employee? selected_employee = null;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var selectedPageNumber = 3;
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
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
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(NotificationScreen()));
                },
                icon: Icon(Icons.notifications)),
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
                          Text('Inner Conversation',
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
                            SizedBox(
                              height: height * .03,
                            ),
                            Container(
                              height: height * .05,
                              child: TypeAheadFormField(
                                direction: AxisDirection.down,
                                textFieldConfiguration: TextFieldConfiguration(
                                  onTap: () {
                                    // ge items
                                  },
                                  style: TextStyle(
                                      color: _themeProvider.primaryColorLight),
                                  controller: employee_controller,
                                  decoration: InputDecoration(
                                      fillColor: _themeProvider.textfieldColor,
                                      contentPadding: EdgeInsets.all(5),
                                      isDense: true,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: _themeProvider.primaryColor),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: _themeProvider.primaryColor,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: _themeProvider.primaryColor,
                                          )),
                                      hintText: 'Select Employee',
                                      hintStyle: TextStyle(
                                          color: _themeProvider
                                              .primaryColorLight
                                              .withOpacity(0.5)),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: _themeProvider.primaryColorLight,
                                      )),
                                ),
                                suggestionsCallback: (pattern) {
                                  return All_employees.where((element) =>
                                      element.first_name
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()));
                                },
                                itemBuilder: (_, Employee ittem) => ListTile(
                                  title: Text(ittem.first_name.toString()),
                                ),
                                onSuggestionSelected: (Employee val) {
                                  setState(() {
                                    selected_employee = val;
                                    //alert*********************************************************************************************
                                    selected_employees.add(selected_employee!);
                                  });
                                },
                                getImmediateSuggestions: true,
                                hideSuggestionsOnKeyboardHide: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select ';
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            GridView.count(
                                shrinkWrap: true,
                                childAspectRatio: 3,
                                crossAxisCount: 3,
                                crossAxisSpacing: width * .01,
                                mainAxisSpacing: height * .01,
                                children: List.generate(
                                    selected_employees.length, (index) {
                                  return Container(
                                    width: width * .42,
                                    height: height * .02,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _themeProvider
                                                .primaryColorLight),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .01,
                                          vertical: height * 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            selected_employees[index].first_name,
                                            style: TextStyle(
                                                fontSize: width * .034),
                                          )),
                                          InkWell(
                                              onTap: () {
                                                selected_employees.remove(
                                                    selected_employees[index]);
                                                //if added tag added before alert
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                color: _themeProvider
                                                    .primaryColorLight,
                                                size: 18,
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                            SizedBox(
                              height: height * .01,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(InnerRealConversation(
                                    selected_emps: selected_employees,
                                  )));
                                },
                                child: Button(title: 'go to conversation'))
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
