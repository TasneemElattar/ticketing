import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/model/notification_model.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/screens/tickets/ticket_detail.dart';
import '../../../controller/page_route.dart';
import '../../controller/provider/theme_provider.dart';
import '../../controller/ticket_controller.dart';
import '../../model/ticket_model.dart';
import '../../services/localization_methods.dart';
import '../widgets/drawer.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  // Color black_color= Color(0xff2c2b2b);
  TextEditingController searchvalue=TextEditingController();
  List<NotificationModel> selectednotifications=[];
  List<NotificationModel> notifications=[];
  bool loaded=false;
getNotification()async{
  List<NotificationModel>notificationsapi=await User.getusernotification();
  notifications=notificationsapi;
  notificationsapi.length>=0?loaded=true:null;
  log('length ${notifications.length}');
  if (notifications.length >= 6) {
    for (int i = 0; i < 6; i++) {
      selectednotifications.add(notifications[i]);
    }
  } else {
    for (int i = 0; i < notifications.length; i++) {
      selectednotifications.add(notifications[i]);
    }
  }
  setState(() {

  });
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   getNotification();


  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    var selectedPageNumber = 3;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar:  AppBar(backgroundColor:_themeProvider.primaryColor,foregroundColor:_themeProvider.primaryColorLight,
        title:  Text('SVITSM',
            style: TextStyle(
              fontFamily: 'Roboto',
              color:_themeProvider.primaryColorLight,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.15,

            )
        ),actions: [IconButton(onPressed: (){
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
        child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: height*.01,horizontal: width*.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: _themeProvider.primaryColorLight,)),
                SizedBox(width: width*.15,),
                Text('${gettranslated(context, "All Notifications")}',
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
          ),//box**********************************************************
          Container(
            width: width*.9,height: height*.75,
            decoration: BoxDecoration(
              //   color: Color(0xffe4eef3),
            //  border: Border.all(color:Color(0xff8e8c8c),),
          //    borderRadius:BorderRadius.circular(8),
            border:    Border(
                    top: BorderSide( width: 3,color:_themeProvider.white_color, // Color(0xff2c2b2b)
                    )     , bottom: BorderSide( width: 3,color:_themeProvider.light_border_color ),
                    left: BorderSide( width: 3,color:_themeProvider.light_border_color ),
                    right: BorderSide( width: 3,color:_themeProvider.light_border_color )
                )
            ),child: Column(children: [
            Container(
                width: width*.9,
                height: height*.07,
                decoration: BoxDecoration(
                  color:_themeProvider.dividerColor,
                  // border: Border.all(color:Color(0xff8e8c8c),),
                  borderRadius:BorderRadius.circular(6),
                ),child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('${gettranslated(context, "All Notifications")}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color:_themeProvider.primaryColorLight,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.15,

                      )
                  ),
              ]
            )),),
            SizedBox(height: height*.56,
              child:loaded!=true?Center(child: CircularProgressIndicator(color: _themeProvider.primaryColorLight,),):
              notifications.length==0?Center(child:  Text('There is no Notifications...', style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: _themeProvider.primaryColorLight,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,

              ),),):
              ListView.builder(
                  itemCount: selectednotifications.length,
                  itemBuilder:(context,i){
                    return  InkWell(
                        onTap: ()async{
 //                          Ticket ticket = Ticket(
 //                              subject: '',
 //                              status: '',
 //                              created_at_date: '',
 //                              attached_files: []);
 // log(selectednotifications[i].ticket_id);
 //                          ticket = await TicketController
 //                              .getTicketDetail(selectednotifications[i].ticket_id);
 //                          Navigator.of(context)
 //                              .push(createRoute(TicketDetail(
 //                            id: selectednotifications[i].ticket_id,
 //                            ticket: ticket,fromdashboard: true,
 //                          )));
                          Ticket ticket = Ticket(
                              subject: '',
                              status: '',
                              created_at_date: '',
                              attached_files: []);
                         if( selectednotifications[i].readAt==null) {
                           await User.readNotification(selectednotifications[i].id);
                         }
                          ticket = await TicketController
                              .getTicketDetail(selectednotifications[i].ticket_id);
                          Navigator.of(context)
                              .push(createRoute(TicketDetail(
                            id: selectednotifications[i].ticket_id,
                            ticket: ticket,fromdashboard: true,
                          )));
                        },
                        child: notificationTicketTile(context,width,height,selectednotifications[i],_themeProvider)
                    );
                  }),),



            NumberPagination(
              onPageChanged: (int pageNumber) {
                var ii=0;
                print(pageNumber);
                selectednotifications=[];
                int skip= (pageNumber-1)*6;

                for(int i=skip;ii<6&&i<notifications.length;i++){

                  print(notifications[i].title);
                  selectednotifications.add(notifications[i]);
                  ii++;

                }
                setState(() {

                  selectedPageNumber = pageNumber;
                  selectednotifications;
                });

              },threshold: 4,fontSize: width*.05,
              pageTotal:(notifications.length/6).ceil(),
              pageInit: 1, // picked number when init page
              colorPrimary:_themeProvider.white_color,
              colorSub:_themeProvider.primaryColor,
            ),
          ],),
          )
        ],
    ),
      ),
    );
  }
}
