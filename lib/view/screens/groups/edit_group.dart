
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';

import '../../../controller/admin_controller.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/employee.dart';
import '../../../model/group_model.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/alert_message.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../notification.dart';
import 'all_groups.dart';

class EditGroup extends StatefulWidget {
GroupModel selected_group;
EditGroup({required this.selected_group});
  @override
  State<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {

  // Color black_color= Color(0xff2c2b2b);

  TextEditingController group_name_controller=TextEditingController();
  TextEditingController employee_controller=TextEditingController();
  List<Employee>   All_employees=[
  ];
  List<Employee> selected_emps=[];
  List<String> selected_employees_names=[];
  Employee? selected_employee=null;
  @override
  getemployeesgroup(){
    for(int i =0;i<widget.selected_group.employess.length;i++){
         selected_employees_names.add(widget.selected_group.employess[i].fname+' '+widget.selected_group.employess[i].lname);
        selected_emps.add(Employee(date: "", first_name: "", last_name: "", role: "", password: "", email: "", status: "", verified: "",
            country: "", timezone: "",id: widget.selected_group.employess[i].id));
    }
    setState(() {

    });
  }

  getAllemployees()async{
    List <Employee> allemployees= await Admin.getAllTEmployees();
    All_employees=allemployees;

  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getemployeesgroup();
    getAllemployees();
   // selected_employees_names=widget.selected_group.employess;
    group_name_controller.text=widget.selected_group.group_name;

  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    var selectedPageNumber = 3;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus;
        currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar:  AppBar(backgroundColor: _themeProvider.primaryColor,foregroundColor: _themeProvider.primaryColorLight,
          title:  Text('SVITSM',
              style: TextStyle(
                fontFamily: 'Roboto',
                color:_themeProvider.primaryColorLight,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.15,

              )
          ),actions: [
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
            IconButton(onPressed: (){
              Navigator.of(context).push( createRoute(ProfileSettings()));
            }, icon: Icon(Icons.account_circle,size: 27,))],
        ),
        drawer:Container(
            width: width*.7,
            child: DrawerPage()
        ),body: Container(width:width,height:height,
        decoration: _themeProvider.path==null?BoxDecoration(color:_themeProvider. backgroundColor,):
        BoxDecoration(
          color:_themeProvider. backgroundColor,
          image:  DecorationImage(
            image: AssetImage(_themeProvider.path!),
            fit: BoxFit.cover,
          ),),
        child: Container(
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: height*.01,horizontal: width*.04),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.008,horizontal: width*.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: _themeProvider.primaryColorLight,)),
                        SizedBox(width: width*.1,),
                        Text('${gettranslated(context, "Edit Group")}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color:_themeProvider.primaryColorLight,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.15,

                            )
                        ),
                      ],),
                  ), Container(
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
                      padding:  EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          custom_text('${gettranslated(context, "Group Name")}',height,_themeProvider),

                          MyTextField(hinttext:'${gettranslated(context, "Group Name")}',controllerValue: group_name_controller,),
                          SizedBox(height: height*.01,),
                          Container(height: height*.05,
                            child: TypeAheadFormField(direction:AxisDirection.up ,
                              textFieldConfiguration: TextFieldConfiguration(
                                onTap: (){
                                  // ge items
                                },
                                style: TextStyle(color: _themeProvider.primaryColorLight),
                                controller: employee_controller,
                                decoration: InputDecoration(
                                    fillColor:_themeProvider.textfieldColor ,
                                    contentPadding: EdgeInsets.all(5),
                                    isDense: true,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color:_themeProvider.primaryColor),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color:_themeProvider.primaryColor,
                                        )),focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color:_themeProvider.primaryColor,
                                    )),
                                    hintText:'${gettranslated(context, "Select Employee")}',
                                    hintStyle: TextStyle(color:_themeProvider.primaryColorLight.withOpacity(0.5)),suffixIcon: Icon(Icons.arrow_drop_down_outlined,color: _themeProvider.primaryColorLight,)
                                ),
                              ),
                              suggestionsCallback: (pattern) {
                                return All_employees.where(( element) =>
                                    element.first_name.toLowerCase().contains(pattern.toLowerCase()));
                              },
                              itemBuilder: (_,Employee ittem) => ListTile(
                                title: Text(ittem.first_name+' '+ittem.last_name.toString()),
                              ),
                              onSuggestionSelected: (Employee val) {
                                setState(() {
                                  selected_employee = val ;
                                  if(!(  selected_employees_names.contains(selected_employee!.first_name+' '+selected_employee!.last_name))){
                                    selected_emps.add(selected_employee!);
                                    //alert*********************************************************************************************
                                    selected_employees_names.add(selected_employee!.first_name+' '+selected_employee!.last_name);
                                    employee_controller.clear();
                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(showsnack(width, _themeProvider, '${gettranslated(context, "Employee added before !")}', Icons.error));
                                    employee_controller.clear();
                                  }

                                });

                              },
                              getImmediateSuggestions: true,
                              hideSuggestionsOnKeyboardHide: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '${gettranslated(context, "Please select")}';
                                }
                              },
                            ),
                          ),SizedBox(height: height*.01,),
                          GridView.count(shrinkWrap: true,
                              childAspectRatio: 3,
                              crossAxisCount: 3,
                              crossAxisSpacing:width*.01,
                              mainAxisSpacing:height*.01,
                              children: List.generate(selected_employees_names.length, (index) {
                                return Container(
                                  width: width*.42,
                                  height: height*.02,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: _themeProvider.primaryColorLight),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal:width*.01,vertical: height*0),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(selected_employees_names[index],style: TextStyle(fontSize: width*.034),)),
                                        InkWell(
                                            onTap: (){
                                              selected_employees_names.remove(selected_employees_names[index]);
                                              selected_emps.remove(selected_emps[index]);
                                              //if added tag added before alert
                                              setState(() {

                                              });
                                            },
                                            child: Icon(Icons.clear,color: _themeProvider.primaryColorLight,size: 18,))
                                      ],
                                    ),
                                  ),
                                );
                              }
                              )),
                          SizedBox(height: height*.01,),
                          InkWell(
                              onTap: ()async{
                           if(groupsEdit.value=="false"){
                             Alertmessage(context,'${gettranslated(context,"Not have a permission")}',_themeProvider,width,height);

                           }else{
                             Loader.show(context,progressIndicator:CircularProgressIndicator(color: _themeProvider.primaryColorLight,));

                             if(group_name_controller.text!=''){
                               var status=      await Admin.editGroup(group_name_controller.text,selected_emps,
                                   widget.selected_group.id);
                               status==200?[
                                 Loader.hide(),
                                 Navigator.of(context).push(createRoute(AllGroups())),
                                 ScaffoldMessenger.of(context)
                                     .showSnackBar(showsnack(
                                     width,
                                     _themeProvider,
                                     '${gettranslated(context, "updated successfully")}',
                                     Icons.check)),
                               ]:[
                                 Loader.hide(),
                                 ScaffoldMessenger.of(context)
                                     .showSnackBar(showsnack(
                                     width,
                                     _themeProvider,
                                     '${gettranslated(context, "Invalid data or group name already used !")}',
                                     Icons.error))];
                             }else{
                               Loader.hide();
                               ScaffoldMessenger.of(context)
                                   .showSnackBar(showsnack(
                                   width,
                                   _themeProvider,
                                   '${gettranslated(context, "Please enter group name !")}',
                                   Icons.error));
                             }
                           }
                              },
                              child: Button(title: '${gettranslated(context, "Save")}'))
                        ],),
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
custom_text(String title,height,ThemeProvider provider){
  return   Padding(
    padding:  EdgeInsets.only(bottom: height*.02,top: height*.01),
    child: Text(title, textAlign: TextAlign.left, style: TextStyle(
        color:provider.primaryColorLight,
        fontFamily: 'Source Sans Pro',
        fontSize: 17,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.w500,
        height: 1
    ),),
  );
}