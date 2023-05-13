import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/admin_controller.dart';
import 'package:ticketing_system/view/screens/dashboard.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../controller/user_controller.dart';
import '../../../model/project_model.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/alert_message.dart';
import '../../widgets/drawer.dart';
import '../../widgets/project_tile.dart';
import '../notification.dart';
import '../profile_settings/profile_settings.dart';
import 'assign_project.dart';

class AllProjects extends StatefulWidget {

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {

  // Color black_color= Color(0xff2c2b2b);
  TextEditingController searchvalue=TextEditingController();

  List<Project> selected_project=[];
  List<Project>   all_projects=[
  ];
  bool loaded_projects=false;
  int searchlength=0;
  getAllProjects()async{
    List<Project> projects=await Admin.getAllProjects();
    all_projects=projects;
    if (all_projects.length >= 6) {
      for (int i = 0; i < 6; i++) {
        selected_project.add(all_projects[i]);
      }
    } else {
      for (int i = 0; i < all_projects.length; i++) {
        selected_project.add(all_projects[i]);
      }
    }
    all_projects.length>=0?loaded_projects=true:null;
    setState(() {

    });
  }
  String length='0';
  getUnReadNotificationLength()async{
    length=await User.getUnreadableNotificationLength();
    myValueNotifier.value=length;
    setState(() {
      ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUnReadNotificationLength();
    getAllProjects();
    // if (all_projects.length >= 6) {
    //   for (int i = 0; i < 6; i++) {
    //     selected_project.add(all_projects[i]);
    //   }
    // } else {
    //   for (int i = 0; i < all_projects.length; i++) {
    //     selected_project.add(all_projects[i]);
    //   }
    // }
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    var selectedPageNumber = 3;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Dashboard()),ModalRoute.withName('/'),);
        return true;
      },
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus;
          currentFocus=FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar:  AppBar(backgroundColor:_themeProvider.primaryColor,foregroundColor: _themeProvider.primaryColorLight,
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
          drawer: Container(
              width: width*.7,
              child: DrawerPage()
          ),body: SingleChildScrollView(
            child: Container(width:width,height:height,
            decoration: _themeProvider.path==null?BoxDecoration(color:_themeProvider. backgroundColor,):
            BoxDecoration(
              color:_themeProvider. backgroundColor,
              image:  DecorationImage(
                image: AssetImage(_themeProvider.path!),
                fit: BoxFit.cover,
              ),),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: _themeProvider.primaryColorLight,)),
                      Container(color: _themeProvider.white_color,
                        width: width*.7,
                        height: height*.052,
                        child: TextFormField(
                          controller:searchvalue,
                          onChanged: (value){
                            List<Project> projectss=[];
                            if(value==''){

                              setState(() {
                                projectss=[];
                                searchlength=0;
                                if (all_projects.length >= 6) {
                                  for (int i = 0; i < 6; i++) {
                                    selected_project.add(all_projects[i]);

                                  }
                                  setState(() {

                                  });
                                } else {
                                  for (int i = 0; i < all_projects.length; i++) {
                                    selected_project.add(all_projects[i]);
                                  }}
                              });
                            }
                            selected_project=[];
                            for(int i=0;i<all_projects.length;i++){

                              if( ( all_projects[i].name).toLowerCase().contains(value.toLowerCase())){

                                projectss.add(all_projects[i]);
                                setState(() {
                                  if (projectss.length >= 6) {
                                    for (int i = 0; i < 6; i++) {
                                      selected_project=projectss;

                                    }
                                    setState(() {

                                    });
                                  } else {
                                    for (int i = 0; i < projectss.length; i++) {
                                      selected_project=projectss;
                                    }}
                                });
                              }
                            }
                            setState(() {
                              searchlength=projectss.length;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: IconButton(icon: Icon(Icons.search),onPressed: (){},),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintText: '${gettranslated(context, "Search..")}',
                            hintStyle: TextStyle(color: Color(0xff8e8c8c)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: _themeProvider.light_border_color),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color:_themeProvider.light_border_color,
                                )),
                          ),
                        ),
                      )
                    ],),
                ),//box**********************************************************
                Container(
                  width: width*.9,height: height*.75,
                  decoration: BoxDecoration(
                    //   color: Color(0xffe4eef3),
                      border: Border(
                          top: BorderSide( width: 3,color:_themeProvider.white_color, // Color(0xff2c2b2b)
                          )     , bottom: BorderSide( width: 3,color:_themeProvider.light_border_color ),
                          left: BorderSide( width: 3,color:_themeProvider.light_border_color ),
                          right: BorderSide( width: 3,color:_themeProvider.light_border_color )
                      )
                    //  borderRadius:BorderRadius.circular(8),
                  ),child: Column(children: [
                  Container(
                      width: width*.9,
                      height: height*.07,
                      decoration: BoxDecoration(
                        color: _themeProvider.dividerColor,
                        // border: Border.all(color:Color(0xff8e8c8c),),
                        borderRadius:BorderRadius.circular(6),
                      ),child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Row(
                          children: [
                            Text('${gettranslated(context, "All Projects")}',style: TextStyle(color: _themeProvider.primaryColorLight,fontWeight: FontWeight.w600,fontSize: 18),)


                          ],
                        ),
                        GestureDetector(
                            onTap: (){
                              projectAssign.value=="false"?
                              Alertmessage(context,'${gettranslated(context,"Not have a permission")}',_themeProvider,width,height):
                              Navigator.of(context).push( createRoute(AssignProject(projects:all_projects,)));
                            },
                            child:Container(
                                width: width*.33,
                                height: height*.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: _themeProvider.primaryColor),borderRadius: BorderRadius.circular(6)
                                ),
                                child: Center(child:  Text('${gettranslated(context, "Assign Project +")}'))))
                      ],),
                  )),
                  SizedBox(height: height*.56,
                    child: projectAccess.value=="false"?
                    Center(child: Text('${gettranslated(context, "Not have a permission",)}', style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: _themeProvider.primaryColorLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),),)
                        :loaded_projects!=true?Center(child: CircularProgressIndicator(color: _themeProvider.primaryColorLight,),):
                    all_projects  .length==0?Center(child:  Text('${gettranslated(context, "There is no Projects...")}', style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: _themeProvider.primaryColorLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,

                    ),),):ListView.builder(
                        itemCount: selected_project.length,
                        itemBuilder:(context,i){

                          return  InkWell(
                              onTap: (){
                          //      Navigator.of(context).push( createRoute(CustomerDetails(customer: selected_project[i],)));
                              },
                              child: ProjectTile(width,height,selected_project[i],_themeProvider)
                          );
                        }),),



                  NumberPagination(
                    onPageChanged: (int pageNumber) {
                      var ii=0;
                      print(pageNumber);
                      selected_project=[];
                      int skip= (pageNumber-1)*6;

                      for(int i=skip;ii<6&&i<all_projects.length;i++){

                        selected_project.add(all_projects[i]);
                        ii++;

                      }
                      setState(() {

                        selectedPageNumber = pageNumber;
                        selected_project;
                      });

                    },threshold: 4,fontSize: width*.05,
                    pageTotal:searchlength==0?(all_projects.length/6).ceil():(searchlength/6).ceil(),
                    pageInit: 1, // picked number when init page
                    colorPrimary: _themeProvider.white_color,
                    colorSub:_themeProvider.primaryColor,
                  ),
                ],),
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
