import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/ticket_controller.dart';
import 'package:ticketing_system/view/screens/employee/add_new_employee.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';
import 'package:ticketing_system/view/widgets/snackbar.dart';
import 'dart:io';
import '../../../controller/login_controller.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/ticket_category.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../dashboard.dart';
import '../notification.dart';

class CreateTicket extends StatefulWidget {

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {


  TextEditingController title_controller=TextEditingController();
  TextEditingController description_controller=TextEditingController();

  TicketCategory? dropdownvalue;
  TicketSubCategory? dropdownvalue2;
  TicketProjects? dropdownvalue3;
  File? file;
  String selectedfilepath='';
  static List<TicketCategory> ticket_categories=[];
  List<TicketSubCategory> subcategories=[];
  List <TicketProjects> ticket_projects=[];

  getTicketCategories()async{
  ticket_categories=  await TicketController.getTicketCategories();

    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTicketCategories();
     title_controller.text='';
     description_controller.text='';
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
  //  var selectedPageNumber = 3;
  //   SubCategoriesProvider subcategory_provider=Provider.of<SubCategoriesProvider>(context);
  //   ProjectsProvider project_provider=Provider.of<ProjectsProvider>(context);
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider _adminprovider =Provider.of<AdminProvider>(context);
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
          child: SingleChildScrollView(
            child: Padding(
            padding:  EdgeInsets.symmetric(vertical: height*.01,horizontal: width*.04),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*.01,horizontal: width*.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: _themeProvider.primaryColorLight,)),
                      SizedBox(width: width*.15,),
                      Text('${gettranslated(context, "Add Ticket")}',
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
                    padding:  EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: width*.27,),
                          file==null? InkWell(
                            onTap: ()async{
                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowMultiple: false,
                                allowedExtensions: ['jpg', 'jpeg', 'png'],
                              );

                              if (result != null) {
                               setState(() {
                                 file = File(result.files.single.path!);
                                // File imageFile = File(file.toString());
                                 selectedfilepath=(file!.path!);
                                 log(selectedfilepath);
                               });
                              } else {
                                // User canceled the picker
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: width*.28,
                              height: height*.04,
                              decoration: BoxDecoration(
                                  border: Border.all(color: _themeProvider.primaryColorLight),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal:width*.01),
                                child: Row(
                                  children: [
                                    Text('${gettranslated(context, "Attach File")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
                                    Icon(Icons.attachment_outlined,color: _themeProvider.primaryColorLight,)
                                  ],
                                ),
                              ),
                            ),
                          ):Expanded(
                            child: Container(
                              width: width*.35,
                              height: height*.04,
                              decoration: BoxDecoration(
                                  border: Border.all(color: _themeProvider.primaryColorLight),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal:width*.01),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(file!.path.split('/').last,style: TextStyle(fontSize: width*.034),overflow: TextOverflow.ellipsis)),
                                    InkWell(
                                        onTap: (){
                                          file=null;
                                          selectedfilepath='';
                                          setState(() {

                                          });
                                        },
                                        child: Icon(Icons.clear,color: _themeProvider.primaryColorLight,))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],),
                 Row(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     custom_text('${gettranslated(context, "Ticket Title")}',height,_themeProvider),
                     requireText(context,width, height)
                   ],
                 ),

                      MyTextField(hinttext: '${gettranslated(context, "Enter Ticket Title")}',controllerValue: title_controller,),

                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        custom_text('${gettranslated(context, "Ticket Category")}',height,_themeProvider),
                        requireText(context,width, height)
                      ],),

                      Container(
                          height: height * .05,
                          width: width * .9,
                          decoration: BoxDecoration(color: _themeProvider.backgroundColor,
                              border: Border.all(color: _themeProvider.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                              child: DropdownButtonFormField<TicketCategory>(
                                menuMaxHeight: height*.5,
                                  icon:    Icon(
                                      Icons.arrow_drop_down,
                                      color:_themeProvider.primaryColorLight.withOpacity(0.5)),
                                  dropdownColor: _themeProvider.backgroundColor,
                                  items: ticket_categories.map((TicketCategory lang) {
                                    return DropdownMenuItem<TicketCategory>(
                                        value: lang, child: Text(lang.categoryName,style: TextStyle(color: _themeProvider.primaryColorLight),));
                                  }).toList(),
                                  onChanged: (TicketCategory? category) {
                              setState(() {
                                subcategories=[];ticket_projects=[];
                              });
                                  if(category!.ticket_subcategories.length>0){

                                 //     subcategory_provider.setSubCategories(category.ticket_subcategories,category.ticket_subcategories.length);
                                     // log(subcategory_provider.sub_category_length.toString());
                                      setState(() {

                                        subcategories=category.ticket_subcategories;
                                        // log(' ${subcategories.length} ${subcategories[0].id}');
                                        // log(subcategories.length.toString());


                                      });

                                    }
                                  if(category!.ticket_projects.length>0){

                                //  log('in pro ${category.ticket_projects.length.toString()}')

;                                 setState(() {
                                    ticket_projects=category.ticket_projects;
}); }



                                    dropdownvalue = category;
                                    // get api subcategories & get api projects
                                    // length>=1 then list subcategories provider
                                    // length>=1 then list projects provider
                                  dropdownvalue2=null;
                                  dropdownvalue3=null;
                                    setState(() {
                                      log('drop1    ${dropdownvalue?.id}');
                                    });
                                  },
                                  value: dropdownvalue,
                                  decoration: InputDecoration.collapsed(
                                      fillColor: Colors.grey[200],

                                      hintText: '${gettranslated(context, "Enter Ticket Category")}',
                                      hintStyle: TextStyle(color:_themeProvider.primaryColorLight.withOpacity(0.5))
                                    //   errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                                  )))),

                      subcategories.length>0?
                      custom_text('${gettranslated(context, "Ticket Sub Category")}',height,_themeProvider):SizedBox(),

                      subcategories.length>0? Container(
                          height: height * .05,
                          width: width * .9,
                          decoration: BoxDecoration(
                              color: _themeProvider.backgroundColor,
                              border: Border.all(color: _themeProvider.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                              child: DropdownButtonFormField<TicketSubCategory>(
                                  menuMaxHeight: height*.5,
                                  dropdownColor: _themeProvider.backgroundColor,
                                  icon:    Icon(
                                      Icons.arrow_drop_down,
                                      color:_themeProvider.primaryColorLight.withOpacity(0.5))
                                  ,items: subcategories.map((TicketSubCategory lang) {
                                return  DropdownMenuItem<TicketSubCategory>(
                                    value: lang, child: Text(lang.categoryName,style: TextStyle(color: _themeProvider.primaryColorLight),));
                              }).toList(),
                                  onChanged: (TicketSubCategory? newValue) {

                                    dropdownvalue2 = newValue;

                                    setState(() {
                                      log('sub id ${dropdownvalue2?.id}');
                                    });
                                  },
                                  value: dropdownvalue2,
                                  decoration: InputDecoration.collapsed(


                                      fillColor: Colors.grey[200],

                                      hintText: '${gettranslated(context, "Enter Ticket sub Category")}',
                                      hintStyle: TextStyle(color: _themeProvider.primaryColorLight.withOpacity(0.5))
                                    //   errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                                  )))):SizedBox(),

                      ticket_projects.length>0?custom_text('${gettranslated(context, "Projects")}',height,_themeProvider):SizedBox(),

                        ticket_projects.length>0? Container(
                          height: height * .05,
                          width: width * .9,
                          decoration: BoxDecoration(color: _themeProvider.backgroundColor,
                              border: Border.all(color: _themeProvider.primaryColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                              child: DropdownButtonFormField<TicketProjects>(
                                  dropdownColor: _themeProvider.backgroundColor,
                                  icon:    Icon(
                                      Icons.arrow_drop_down,
                                      color:_themeProvider.primaryColorLight.withOpacity(0.5)),
                                  items: ticket_projects.map((TicketProjects lang) {
                                    return new DropdownMenuItem(
                                        value: lang, child: Text(lang.name,style: TextStyle(color: _themeProvider.primaryColorLight)));
                                  }).toList(),
                                  onChanged: (TicketProjects? newValue) {

                                    dropdownvalue3 = newValue!;
                                    // get api subcategories & get api projects
                                    // length>=1 then list subcategories provider
                                    // length>=1 then list projects provider
                                    setState(() {
                                      log('proooo ${dropdownvalue3?.id}');
                                    });
                                  },
                                  value: dropdownvalue3,
                                  decoration: InputDecoration.collapsed(


                                      fillColor: Colors.grey[200],

                                      hintText: '${gettranslated(context, 'Enter Ticket project')}',
                                      hintStyle: TextStyle(color: _themeProvider.primaryColorLight.withOpacity(0.5))
                                    //   errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                                  )))):SizedBox(),

                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                       custom_text('${gettranslated(context, 'Ticket Description')}',height,_themeProvider),
                       requireText(context,width, height)
                     ],),

                      Center(
                        child: Container(
                          width: width*.8,
                          height: height*.17,
                          decoration: BoxDecoration(
                              color: _themeProvider.box_description,
                              border: Border.all(color: _themeProvider.primaryColor),
                              borderRadius: BorderRadius.circular(10)
                          ),child: TextField(
                          style: TextStyle(color: _themeProvider.primaryColorLight),
                          keyboardType: TextInputType.multiline,
                          maxLines: 1000,
                          controller: description_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(height*.02),
                            labelText: '${gettranslated(context, "Enter Ticket Description")}',
                            labelStyle: TextStyle(color: _themeProvider.primaryColorLight.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                        ),
                        ),
                      ),SizedBox(height: height*.02,),
                      InkWell(
                          onTap: ()async{
                          if(title_controller.text==''||description_controller.text==''||dropdownvalue==null){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(showsnack(
                                width, _themeProvider, '${gettranslated(context, "Please Enter title and category and description !")}',
                                Icons.error));
                          }else{
                            Loader.show(context,progressIndicator:CircularProgressIndicator(color: _themeProvider.primaryColorLight,));
                            var status_code=   await TicketController.createTicket(subject: title_controller.text,
                                category_id: dropdownvalue?.id??'',
                                message: description_controller.text??'',
                                isAdmin: _adminprovider.admin,
                                email: Auth.user_email,
                                sub_category_id: dropdownvalue2?.id??'',
                                project_id: dropdownvalue3?.name??'',
                                file_path:selectedfilepath);
                            status_code==200?[
                              Navigator.of(context).pushReplacement( createRoute(Dashboard())),
                            ScaffoldMessenger.of(context)
                                .showSnackBar(showsnack(
                            width, _themeProvider, '${gettranslated(context, "Ticket added successfully..")}',
                            Icons.check))

                            ]: ScaffoldMessenger.of(context)
                                .showSnackBar(showsnack(
                                width, _themeProvider, '${gettranslated(context, "Can not add !")}',
                                Icons.error));
                            Loader.hide();
                          }
                          },
                          child: Button(title: '${gettranslated(context, "Create Ticket")}'))
                    ],),
                  ),
                )
              ],
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