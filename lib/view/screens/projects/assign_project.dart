import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/admin_controller.dart';
import 'package:ticketing_system/model/project_model.dart';
import 'package:ticketing_system/view/screens/dashboard.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/screens/projects/all_projects.dart';
import 'package:ticketing_system/view/widgets/button.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/ticket_category.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/snackbar.dart';
import '../notification.dart';

class AssignProject extends StatefulWidget {
  List<Project> projects;
  AssignProject({required this.projects});
  @override
  State<AssignProject> createState() => _AssignProjectState();
}

class _AssignProjectState extends State<AssignProject> {

getProjectCategories()async{
  List<TicketProjects> itemss= await Admin.getprojectCategories();
  items=itemss;
 setState(() {

 });
}

  List<TicketProjects> items = [];
  Project? dropdownvalue;
  TicketProjects? dropdownvalue2;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProjectCategories();
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
                        Text('${gettranslated(context, "Assign Project")}',
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

                          custom_text('${gettranslated(context, "Projects")}',height,_themeProvider),

                          Container(
                              height: height * .05,
                              width: width * .9,
                              decoration: BoxDecoration(color: _themeProvider.backgroundColor,
                                  border: Border.all(color: _themeProvider.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                  child: DropdownButtonFormField<Project>(
                                      icon:    Icon(
                                          Icons.arrow_drop_down,
                                          color:_themeProvider.primaryColorLight.withOpacity(0.5)),
                                      dropdownColor: _themeProvider.backgroundColor,
                                      items: widget.projects.map((Project project) {
                                        return new DropdownMenuItem(
                                            value: project, child: Text(project.name));
                                      }).toList(),
                                      onChanged: (Project? project) {


                                        dropdownvalue = project;

                                        setState(() {});
                                      },
                                      value: dropdownvalue,
                                      decoration: InputDecoration.collapsed(


                                          fillColor: Colors.grey[200], hintText: '${gettranslated(context, "Please select")}',

                                       )))),
                          custom_text('${gettranslated(context, "Categories")}',height,_themeProvider),

                          Container(
                              height: height * .05,
                              width: width * .9,
                              decoration: BoxDecoration(color: _themeProvider.backgroundColor,
                                  border: Border.all(color: _themeProvider.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                  child: DropdownButtonFormField<TicketProjects>(
                                      icon:    Icon(
                                          Icons.arrow_drop_down,
                                          color:_themeProvider.primaryColorLight.withOpacity(0.5)),
                                      dropdownColor: _themeProvider.backgroundColor,
                                      items: items.map((TicketProjects  item) {
                                        return  DropdownMenuItem(
                                            value: item, child: Text(item.name));
                                      }).toList(),
                                      onChanged: (TicketProjects? item) {

                                        dropdownvalue2 = item!;

                                        setState(() {});
                                      },
                                      value: dropdownvalue2,
                                      decoration: InputDecoration.collapsed(


                                        fillColor: Colors.grey[200], hintText: '${gettranslated(context, "Please select")}',

                                      )))),
                          SizedBox(height: height*.03,),
                          InkWell(
                              onTap: ()async{
                         if(dropdownvalue2==null||dropdownvalue==null){
                           ScaffoldMessenger.of(context)
                               .showSnackBar(showsnack(width, _themeProvider, '${gettranslated(context, "Please select project and category !")}', Icons.error));

                         }else{
                           Loader.show(context,progressIndicator:CircularProgressIndicator(color: _themeProvider.primaryColorLight,));

                           var statuscode=      await Admin.assignProject(project_id: dropdownvalue!.id, category_id: dropdownvalue2!.id);
                           statuscode==200?[
                             Loader.hide(),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(showsnack(width, _themeProvider, '${gettranslated(context, "The project were successfully assigned")}', Icons.check)),
                                Navigator.of(context).push(createRoute(AllProjects()))
                           ]:[
                             Loader.hide(),
                             ScaffoldMessenger.of(context)
                                 .showSnackBar(showsnack(width, _themeProvider, '${gettranslated(context, "The project were not assigned !")}', Icons.error))
                           ];
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