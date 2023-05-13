import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/provider/admin_provider.dart';
import 'package:ticketing_system/controller/ticket_controller.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/model/dashboard_model.dart';
import 'package:ticketing_system/view/screens/login/login_screen.dart';
import 'package:ticketing_system/view/screens/notification.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/screens/tickets/all_tickets.dart';
import 'package:ticketing_system/view/screens/tickets/ticket_detail.dart';

import '../../controller/login_controller.dart';
import '../../controller/page_route.dart';
import '../../controller/provider/theme_provider.dart';
import '../../model/ticket_model.dart';
import '../../services/localization_methods.dart';
import '../widgets/dashboard_box_ticket.dart';
import '../widgets/dashboard_ticket_tile.dart';
import '../widgets/drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}
ValueNotifier<String> myValueNotifier = ValueNotifier<String>('0');
class _DashboardState extends State<Dashboard> {
  final storage = new GetStorage();
  List<Ticket> tickets = [];
  late DashboardModel dashboardModel = DashboardModel(
      allTicketsCount: 0,
      activeTicketsCount: 0,
      closedTicketsCount: 0,
      assignedTicketsCount: 0,
      myAssignedTicketsCount: 0,
      myTicketsCount: 0,
      onHoldTicketsCount: 0,
      overdueTicketsCount: 0);
  @override
  int pageIndex = 0;
  bool loaded_tickets = false;
  final pageController = PageController(viewportFraction: 1 / 2);

  getDahboard() async {
    DashboardModel dashboardmo = await User.getTicketsNumberDahboard();
    User.expired_token
        ? [
            storage.write('token', null),
            storage.write('isAdmin', null),
            storage.write('user_id', null),
            storage.write('user_email', null),
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          ]
        : null;
    dashboardModel = dashboardmo;
     setState(() {});
  }

  getAllTickets() async {
    List<Ticket> ticketsApi = await TicketController.getAllTickets();
    tickets = ticketsApi.reversed.toList();
    ticketsApi.length >= 0 ? loaded_tickets = true : null;

    setState(() {});
  }
getPermission()async{
  List<Map<String,String>> permissions=await User.getPermissions();
   setState(() {

   });
}
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getDahboard();
    getPermission();

    getAllTickets();
  }
  String length='0';
getUnReadNotificationLength()async{
  length=await User.getUnreadableNotificationLength();
  log('length $length');
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

}

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);


   // adminProvider.setNotificationLength(length);
    return Scaffold(
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
            )),leading: Builder(builder: (context) {
    return IconButton(
    icon: Icon(
    Icons.menu,
    color: _themeProvider.primaryColorLight,
    ),
    onPressed: () {
      adminProvider.setTickets(tickets);

      adminProvider.setTicketPermissions(allTicketsp: allTicketsv.value,
        assignedTicketsp: assignedTicketsv.value,myAssignedTicketsp: myAssignedTicketsv.value,
        myTicketsp: myTicketsv.value,onholdTicketsp: onholdTicketsv.value,overdueTicketsp: overdueTicketsv.value,
      );
    FocusManager.instance.primaryFocus?.unfocus();
      adminProvider.setuserImage(Auth.user_image);
    Scaffold.of(context).openDrawer();

    });
            }),
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: .01*height),
            child: Badge(label: Text(myValueNotifier.value),
              child: IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(createRoute(NotificationScreen()));
                    adminProvider.setTickets(tickets);
                    adminProvider.setuserImage(Auth.user_image);
                    adminProvider.setTicketPermissions(allTicketsp: allTicketsv.value,
                      assignedTicketsp: assignedTicketsv.value,myAssignedTicketsp: myAssignedTicketsv.value,
                      myTicketsp: myTicketsv.value,onholdTicketsp: onholdTicketsv.value,overdueTicketsp: overdueTicketsv.value,
                    );
                  },
                  icon: Icon(Icons.notifications)),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(ProfileSettings()));
                adminProvider.setTickets(tickets);
                adminProvider.setuserImage(Auth.user_image);
                adminProvider.setTicketPermissions(allTicketsp: allTicketsv.value,
                  assignedTicketsp: assignedTicketsv.value,myAssignedTicketsp: myAssignedTicketsv.value,
                  myTicketsp: myTicketsv.value,onholdTicketsp: onholdTicketsv.value,overdueTicketsp: overdueTicketsv.value,
                );
              },
              icon: Icon(
                Icons.account_circle,
                size: 27,
              ))
        ],
      ),
      drawer: Container(width: width * .7, child: DrawerPage()),

      body: Container(
        height: height,
        width: width,
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
        child: Column(
          children: [
            SizedBox(
              height: height * .02,
            ),
            adminProvider.admin
                ? Column(
                    children: [
                      Container(
                        height: height * .26,
                        child: PageView(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index) {
                            setState(() {
                              // set page index to current index of page
                              pageIndex = index;
                            });
                          },
                          children: [
                            boxTicket(
                                '${gettranslated(context, "All Tickets")}',
                                dashboardModel.allTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/confirmation_number4.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "Active Tickets")}',
                                dashboardModel.activeTicketsCount,
                                Icon(
                                  Icons.local_activity_outlined,
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "Closed Tickets")}',
                                dashboardModel.closedTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/confirmation_number2.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "Assigned Tickets")}',
                                dashboardModel.assignedTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/confirmation_number3.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "My Assigned Tickets")}',
                                dashboardModel.myAssignedTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/confirmation_number3.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "My Tickets")}',
                                dashboardModel.myTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/my_ticket.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "On hold Tickets")}',
                                dashboardModel.onHoldTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/confirmation_number.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                            boxTicket(
                                '${gettranslated(context, "Overdue Tickets")}',
                                dashboardModel.overdueTicketsCount,
                                SvgPicture.asset(
                                  'assets/images/overdue_ticket.svg',
                                  color: _themeProvider.primaryColor,
                                ),
                                height,
                                width,
                                _themeProvider,
                                admin: true),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      boxTicket(
                          'All Tickets',
                          dashboardModel.allTicketsCount,
                          SvgPicture.asset(
                            'assets/images/confirmation_number4.svg',
                            color: _themeProvider.primaryColor,
                          ),
                          height,
                          width,
                          _themeProvider),
                      SizedBox(
                        height: height * .01,
                      ),
                      boxTicket(
                          'Active Tickets',
                          dashboardModel.activeTicketsCount,
                          Icon(
                            Icons.local_activity_outlined,
                            color: _themeProvider.primaryColor,
                          ),
                          height,
                          width,
                          _themeProvider),
                      SizedBox(
                        height: height * .01,
                      ),
                      boxTicket(
                          'Closed Tickets',
                          dashboardModel.closedTicketsCount,
                          SvgPicture.asset(
                            'assets/images/confirmation_number2.svg',
                            color: _themeProvider.primaryColor,
                          ),
                          height,
                          width,
                          _themeProvider),
                    ],
                  ),
            adminProvider.admin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 8; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _indicatorDotsWidget(
                              color: pageIndex == i
                                  ? _themeProvider.primaryColorLight
                                  : _themeProvider.primaryColorLight
                                      .withOpacity(0.5),
                              width: pageIndex == i ? 15 : 6),
                        ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: height * .02,
            ),
            Container(
              width: width * .9,
              height: height * .52,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        width: 3,
                        color: _themeProvider.white_color, // Color(0xff2c2b2b)
                      ),
                      bottom: BorderSide(
                          width: 3, color: _themeProvider.light_border_color),
                      left: BorderSide(
                          width: 3, color: _themeProvider.light_border_color),
                      right: BorderSide(
                          width: 3, color: _themeProvider.light_border_color))
                  //    borderRadius:BorderRadius.circular(8),
                  ),
              child: Column(
                children: [
                  Container(
                      width: width * .9,
                      height: height * .06,
                      decoration: BoxDecoration(
                        color: _themeProvider.dividerColor,
                        // color: Color(0xffe4eef3),
                        // border: Border.all(color:Color(0xff8e8c8c),),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${gettranslated(context, "Tickets")}',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: _themeProvider.primaryColorLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  adminProvider.setTickets(tickets);
                                  adminProvider.setuserImage(Auth.user_image);

                           adminProvider.setPermission(allTicketsv.value);
                           adminProvider.setTicketPermissions(allTicketsp: allTicketsv.value,
                           assignedTicketsp: assignedTicketsv.value,myAssignedTicketsp: myAssignedTicketsv.value,
                           myTicketsp: myTicketsv.value,onholdTicketsp: onholdTicketsv.value,overdueTicketsp: overdueTicketsv.value,
                           );
                                  Navigator.of(context).push(createRoute(
                                      AllTickets(
                                          status: 'all',
                                          all_tickets: tickets)));
                                },
                                child: Text(
                                  '${gettranslated(context, "View All")}',
                                  style: TextStyle(
                                      color: _themeProvider.primaryColorLight,
                                    decoration: TextDecoration.underline,),
                                ))
                          ],
                        ),
                      )),
                  SizedBox(
                    height: height * .41,
                    child:
                        loaded_tickets != true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: _themeProvider.primaryColorLight,
                            ),
                          )
                        :allTicketsv.value=="false"?
                        Center(child: Text('${gettranslated(context, "Not have a permission",)}', style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          color: _themeProvider.primaryColorLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),),): tickets.length == 0
                            ? Center(
                                child: Text(
                                  '${gettranslated(context, "There is no Tickets...")}',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    color: _themeProvider.primaryColorLight,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () async {
                                      adminProvider.setTickets(tickets);
                                      adminProvider.setuserImage(Auth.user_image);
                                      Ticket ticket = Ticket(
                                          subject: '',
                                          status: '',
                                          created_at_date: '',
                                          attached_files: []);

                                      ticket = await TicketController
                                          .getTicketDetail(tickets[i].ticket_id);
                                      Navigator.of(context)
                                          .push(createRoute(TicketDetail(
                                        id: tickets[i]!.ticket_id,
                                        ticket: ticket,fromdashboard: true,
                                      )));
                                    },
                                    child: TicketTile(
                                        width,
                                        height,
                                        tickets[i].subject,
                                        tickets[i].status,
                                        tickets[i].created_at_date,
                                        true,
                                        _themeProvider),
                                  );
                                },
                                itemCount: tickets.length>4?4:tickets.length,
                              ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _indicatorDotsWidget({
    required color,
    required double width,
  }) {
    return Container(
      height: 7,
      width: width,
      decoration: new BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
