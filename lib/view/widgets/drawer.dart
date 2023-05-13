import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/provider/admin_provider.dart';
import 'package:ticketing_system/view/screens/canned%20response/all_canned_res.dart';
import 'package:ticketing_system/view/screens/dashboard.dart';
import 'package:ticketing_system/view/screens/login/login_screen.dart';
import 'package:ticketing_system/view/screens/settings.dart';
import 'package:ticketing_system/view/screens/tickets/all_tickets.dart';
import 'package:ticketing_system/view/screens/tickets/create_ticket.dart';
import '../../controller/page_route.dart';
import '../../controller/provider/theme_provider.dart';
import '../../controller/ticket_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/ticket_model.dart';
import '../../services/localization_methods.dart';
import '../screens/article/all_articles.dart';
import '../screens/customer/all_customers.dart';
import '../screens/employee/all_employee.dart';
import '../screens/groups/all_groups.dart';
import '../screens/profile_settings/profile_settings.dart';
import '../screens/projects/all_projects.dart';
import 'alert_message.dart';
class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}
ValueNotifier<String> version_app= ValueNotifier<String>("");
class _DrawerPageState extends State<DrawerPage> {

  Color black_color= Color(0xff2c2b2b);
  @override
  List<Ticket> my_assign_Tickets=[];
  List<Ticket> assign_Tickets=[];
  List<Ticket> my_Tickets=[];
  List<Ticket> overdue_tickets=[];
  bool loadmytickets=false;bool loadassign=false;bool loadmyassign=false;
  getmyAssignTickets()async{
    List<Ticket> ticketsApi  = await TicketController.getMyassignTickets(true);
    my_assign_Tickets=ticketsApi.reversed.toList();
    List<Ticket> ticketsApi2=await TicketController.getMyassignTickets(false);
    assign_Tickets=ticketsApi2.reversed.toList();
    if (!mounted) return;
    setState(() {
     loadmyassign=true;
     loadassign=true;
    });
  }
  getmyTickets()async{
    List<Ticket> ticketsApi  = await TicketController.getMyassignTickets(true);
    my_Tickets=ticketsApi.reversed.toList();

    setState(() {
loadmytickets=true;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getmyAssignTickets();
    getmyTickets();


  }
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    AdminProvider _adminprovider =Provider.of<AdminProvider>(context);
    return Drawer(
      backgroundColor: _themeProvider.backgroundColor,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: height*.05),
        children: [

          ListTile(
            leading: Icon(Icons.dashboard,color: _themeProvider.primaryColorLight,),
            title:  Text('${gettranslated(context, "Dashboard")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => Dashboard(),
                ),
                    (route) => false,//if you want to disable back feature set to false
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts,color: _themeProvider.primaryColorLight,),
            title:  Text('${gettranslated(context, "Profile Settings")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push( createRoute(ProfileSettings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add_outlined,color: _themeProvider.primaryColorLight,),
            title:  Text('   ${gettranslated(context, "Add Ticket")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              Navigator.pop(context);
             ticketcreate.value=="false"?  Alertmessage(context,'${gettranslated(context,"Not have a permission")}',_themeProvider,width,height): Navigator.of(context).push( createRoute(CreateTicket()));
            },),
      _adminprovider.admin?
      ExpansionTile(
        leading:SvgPicture.asset(
          'assets/images/confirmation_number4.svg',
          color: _themeProvider.primaryColorLight,
        ),trailing: Icon(Icons.expand_more,color: _themeProvider.primaryColorLight,),
        title:  Text('${gettranslated(context, "Tickets")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
        children: [
          ListTile(
            leading:SizedBox(width: width*.02,),
            title:  Text('${gettranslated(context, "All Tickets")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              Navigator.pop(context);
              _adminprovider.setPermission(_adminprovider.allTicketspermission);
              Navigator.of(context).push( createRoute(AllTickets(status: 'all',dropdownvalue: 'All Tickets',all_tickets:_adminprovider.tickets,
            )));
            },),

          ListTile(
            leading:  SizedBox(width: width*.02,),
            title:  Row(
              children: [
                Text('${gettranslated(context, "My Tickets")}',
                  style: TextStyle(color:loadmytickets? _themeProvider.primaryColorLight:_themeProvider.primaryColorLight.withOpacity(0.5)),),
                SizedBox(width: width*.01,),
                loadmytickets?SizedBox():Icon(Icons.search,color: _themeProvider.primaryColorLight.withOpacity(0.5),)
              ],
            ),
            onTap: () {
           if(loadmytickets==true){
             Navigator.pop(context);
             _adminprovider.setPermission(_adminprovider.myTicketspermission);
             Navigator.of(context).push( createRoute(AllTickets(status: 'my_tickets',dropdownvalue: 'My Tickets',all_tickets: my_Tickets)));

           }
            },),
          ListTile(
            leading:  SizedBox(width: width*.02,),
            title:  Row(
              children: [
                Text('${gettranslated(context, "Assigned Tickets")}',
                  style: TextStyle(color:loadassign? _themeProvider.primaryColorLight:_themeProvider.primaryColorLight.withOpacity(0.5)),),
                SizedBox(width: width*.01,),
                loadassign?SizedBox():Icon(Icons.search,color: _themeProvider.primaryColorLight.withOpacity(0.5),)
              ],
            ),
            onTap: () {
              if(loadassign==true){
                Navigator.pop(context);
                _adminprovider.setPermission(_adminprovider.assignedTicketspermission);
                Navigator.of(context).push( createRoute(AllTickets(status: 'assign',dropdownvalue: 'Assigned Tickets',all_tickets: assign_Tickets)));

              } },),
          ListTile(
            leading:  SizedBox(width: width*.02,),
            title:  Row(
              children: [
                Text('${gettranslated(context, "My Assigned Tickets")}',
                  style: TextStyle(color: loadmyassign?_themeProvider.primaryColorLight:_themeProvider.primaryColorLight.withOpacity(0.5)),),
            SizedBox(width: width*.01,),
             loadmyassign?SizedBox():Icon(Icons.search,color: _themeProvider.primaryColorLight.withOpacity(0.5),)
              ],
            ),
            onTap: () {
            if(loadmyassign==true){
              Navigator.pop(context);
              _adminprovider.setPermission(_adminprovider.myAssignedTicketspermission);
              Navigator.of(context).push( createRoute(AllTickets(status: 'my_assign',dropdownvalue: "My Assigned Tickets",all_tickets: my_assign_Tickets,)));

            } },),
          ListTile(
            leading:  SizedBox(width: width*.02,),
            title:  Text('${gettranslated(context, "Overdue Tickets")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              Navigator.pop(context);
              _adminprovider.setPermission(_adminprovider.overdueTicketspermission);
              Navigator.of(context).push( createRoute(AllTickets(status: 'overdue',dropdownvalue:"Overdue Tickets",all_tickets: _adminprovider.tickets,)));
            },),
          // ListTile(
          //   leading: SizedBox(width: width*.02,),
          //   title:  Text('Closed Tickets',style: TextStyle(color: _themeProvider.primaryColorLight),),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.of(context).push( createRoute(AllTickets(status:'closed' ,dropdownvalue: 'Closed Tickets',all_tickets: _adminprovider.tickets,)));
          //   },),
        ],)

          :Column(children: [
        ListTile(
          leading: Icon(Icons.local_activity_outlined,color: _themeProvider.primaryColorLight,),
          title:  Text('${gettranslated(context, "All Tickets")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
          onTap: () {
            Navigator.pop(context);
            _adminprovider.setPermission(_adminprovider.allTicketspermission);
            Navigator.of(context).push( createRoute(AllTickets(status: 'all',dropdownvalue: 'All Tickets',all_tickets:_adminprovider.tickets,)));
          },)

         ],),
       _adminprovider.admin?   Column(
         children: [
           ListTile(
                leading: Icon(Icons.badge_outlined,color: _themeProvider.primaryColorLight,),
                title:  Text('${gettranslated(context, "Employees")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push( createRoute(AllEmployee()));
                },),
           ListTile(
             leading: Icon(Icons.support_agent_outlined,color: _themeProvider.primaryColorLight,),
             title:  Text('${gettranslated(context, "Customers")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
             onTap: () {
               Navigator.pop(context);
               Navigator.of(context).push( createRoute(AllCustomers()));
             },),
           ListTile(
             leading: Icon(Icons.view_list_outlined,color: _themeProvider.primaryColorLight,),
             title:  Text('${gettranslated(context, "Projects")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
             onTap: () {
               Navigator.pop(context);
               Navigator.of(context).push( createRoute(AllProjects()));
             },),ListTile(
             leading: Icon(Icons.workspaces_outline,color: _themeProvider.primaryColorLight,),
             title:  Text('${gettranslated(context, "Groups")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
             onTap: () {
               Navigator.pop(context);
               Navigator.of(context).push( createRoute(AllGroups()));
             },),
           ListTile(
             leading: Icon(Icons.sticky_note_2_outlined,color: _themeProvider.primaryColorLight,),
             title:  Text('${gettranslated(context, "Canned Responses")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
             onTap: () {
               Navigator.pop(context);
               Navigator.of(context).push( createRoute(AllCannedResponse()));
             },),
           ListTile(
             leading: Icon(Icons.article_outlined,color: _themeProvider.primaryColorLight,),
             title:  Text('${gettranslated(context, "Articles")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
             onTap: () {
               Navigator.pop(context);
               Navigator.of(context).push( createRoute(AllArticles()));
             },),
         ],
       ):SizedBox(),
          ListTile(
            leading: Icon(Icons.settings,color: _themeProvider.primaryColorLight,),
            title:  Text('${gettranslated(context, "SETTINGS")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push( createRoute(Settings()));
            },),
          SizedBox(),
          ListTile(
            leading: Icon(Icons.settings,color: _themeProvider.primaryColorLight,),
            title:  Text('${gettranslated(context, "Logout")}',style: TextStyle(color: _themeProvider.primaryColorLight),),
            onTap: () {
              final storage = new GetStorage();
              storage.write('token', null);
              storage.write('isAdmin', null);
              storage.write('user_id', null);
              storage.write('user_email', null);
              Navigator.pop(context);
              Navigator.of(context).push( createRoute(LoginScreen()));
            },),
          ListTile(

            title:  Center(child: Text('${gettranslated(context, "Version")} ${version_app.value}',style: TextStyle(color: _themeProvider.primaryColorLight,fontWeight: FontWeight.w600),)),
          ),
        ],
      ),
    );
  }
}
