
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/provider/admin_provider.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/model/ticket_model.dart';
import 'package:ticketing_system/view/screens/dashboard.dart';
import 'package:ticketing_system/view/screens/settings.dart';
import 'package:ticketing_system/view/screens/tickets/ticket_detail.dart';

import '../../../controller/page_route.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../controller/ticket_controller.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/alert_message.dart';
import '../../widgets/dashboard_ticket_tile.dart';
import '../../widgets/drawer.dart';

import '../notification.dart';
import '../profile_settings/profile_settings.dart';
import 'create_ticket.dart';
import 'package:translator/translator.dart';
class AllTickets extends StatefulWidget {
  String status;
  String? dropdownvalue;
  List<Ticket> all_tickets;


  AllTickets({required this.status,required this.all_tickets, this.dropdownvalue = 'All Tickets'});

  @override
  State<AllTickets> createState() => _AllTicketsState();
}

class _AllTicketsState extends State<AllTickets> {
  // Color black_color= Color(0xff2c2b2b);
  TextEditingController searchvalue = TextEditingController();

  List<Ticket> selected_tickets = [];
  List<Ticket> tickets = [];

 // List<Ticket> Active_Tickets = [];

 // List<Ticket> Closed_Tickets = [];
//  List<Ticket> onhold_Tickets = []; //admin
  List<Ticket> my_Tickets = [];
  List<Ticket> assign_Tickets = [];
  List<Ticket> my_assign_Tickets = [];
  List<Ticket> overdue_Tickets = [];
 //String  dropdownvalue='';
 String dropdownvalue3='All Tickets';
 String status='All';
  int searchlength=0;
  var items = [
    'All Tickets',
    // 'Active Tickets',
    // 'Closed Tickets',
    // 'On-hold Tickets'

  ];

  var items_admin = [
    'All Tickets',
    //'Active Tickets',
   // 'Closed Tickets',
  //  'On-hold Tickets',
    'My Tickets',
    'Assigned Tickets',
    "My Assigned Tickets",
    'Overdue Tickets',
  ];


  getoverdue(){

    List<Ticket> overduelist=[];
    for(int i=0;i<widget.all_tickets!.length;i++){
      if(widget.all_tickets![i].overdue=='Overdue'){

        overduelist.add(widget.all_tickets![i]);
      }
    }
    overdue_Tickets=overduelist;

    setState(() {

    });
  }
  getmyAssignTickets()async{
    List<Ticket> ticketsApi  = await TicketController.getMyassignTickets(true);
    my_assign_Tickets=ticketsApi.reversed.toList();
    List<Ticket> ticketsApi2=await TicketController.getMyassignTickets(false);
    assign_Tickets=ticketsApi2.reversed.toList();
 setState(() {

 });
  }
  getmyTickets()async{
    List<Ticket> ticketsApi  = await TicketController.getMyassignTickets(true);
    my_Tickets=ticketsApi.reversed.toList();

    setState(() {

    });
  }
  List<String>statusList=['All'];
  getStatusFilter()async{
  List<String> status=await User.getTicketStatusFilter();
  for(int i=0;i<status.length;i++){
    statusList.add(status[i]);
  }

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
  GoogleTranslator translator = GoogleTranslator();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatusFilter();
    getUnReadNotificationLength();

   // getclosed();
    getoverdue();
   // getactives();
  //  getonhold();
    getmyAssignTickets();
    getmyTickets();
  //  getoverdue();
  //   if (widget.status == 'active') {
  //     log('acri');log(Active_Tickets.toString());
  //     tickets = Active_Tickets;
  //   }
  //   else if (widget.status == 'closed') {
  //     tickets = Closed_Tickets;
  //   }
  //   else if (widget.status == 'on-hold') {
  //     tickets = onhold_Tickets;
  //   }
     if (widget.status == 'my_tickets') {

    setState(() {
     if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
       tickets = widget.all_tickets;
     }
      if(closedTickets.value=="false"){
        if ( widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if( widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add( widget.all_tickets[i]);
            }}
        } else {
          for (int i = 0;
          i <  widget.all_tickets.length;
          i++) {
            if( widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add( widget.all_tickets[i]);}
          }
        }
      }if(onholdTicketsv.value=="false"){
        if ( widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if( widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add( widget.all_tickets[i]);
            }

          }
        } else {
          for (int i = 0;
          i <  widget.all_tickets.length;
          i++) {
            if( widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add( widget.all_tickets[i]);}
          }}
      }
    });
    }else if (widget.status == 'assign') {
       if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
      tickets = widget.all_tickets;}
      if(closedTickets.value=="false"){
        if (widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if(widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);
            }}
        } else {
          for (int i = 0;
          i < widget.all_tickets.length;
          i++) {
            if(widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);}
          }
        }
      }if(onholdTicketsv.value=="false"){
        if (widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if(widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);
            }

          }
        } else {
          for (int i = 0;
          i < widget.all_tickets.length;
          i++) {
            if(widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);}
          }}
      }
      setState(() {

      });
    }else if (widget.status == 'my_assign') {
       if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
      tickets = widget.all_tickets;}
      if(closedTickets.value=="false"){
        if (widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if(widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);
            }}
        } else {
          for (int i = 0;
          i < widget.all_tickets.length;
          i++) {
            if(widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);}
          }
        }
      }if(onholdTicketsv.value=="false"){
        if (widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if(widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);
            }

          }
        } else {
          for (int i = 0;
          i < widget.all_tickets.length;
          i++) {
            if(widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);}
          }}
      }
      setState(() {

      });
    }else if (widget.status == 'overdue') {
 List<Ticket>overdues=[];
      for(int i=0;i<widget.all_tickets.length;i++){
        if(widget.all_tickets[i].overdue=='Overdue'){

          overdues.add(widget.all_tickets[i]);
        }
      }
      if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
      tickets = overdues;}
 if(closedTickets.value=="false"){log('here');
   if (overdues.length >= 6) {
     for (int i = 0; i < 6; i++) {
       if(overdues![i].status=='Closed'){}else{
        setState(() {
          selected_tickets
              .add(overdues[i]);
        });
       }}

   } else {
     for (int i = 0;
     i < overdues.length;
     i++) {
       if(overdues![i].status=='Closed'){}else{
         setState(() {
           selected_tickets
               .add(overdues[i]);
         });
       }
     }
   }
 }if(onholdTicketsv.value=="false"){
   if (overdues.length >= 6) {
     for (int i = 0; i < 6; i++) {
       if(overdues![i].status=='On-Hold'){}else{
         selected_tickets
             .add(overdues[i]);
       }

     }
   } else {
     for (int i = 0;
     i < overdues.length;
     i++) {
       if(overdues![i].status=='On-Hold'){}else{
         selected_tickets
             .add(overdues[i]);}
     }}
 }
      setState(() {

      });
    }
    else if (widget.status == 'all') {
      if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
      tickets = widget.all_tickets!;}
      if(closedTickets.value=="false"){
        if (widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if(widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);
            }}
        } else {
          for (int i = 0;
          i < widget.all_tickets.length;
          i++) {
            if(widget.all_tickets![i].status=='Closed'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);}
          }
        }
      }if(onholdTicketsv.value=="false"){
        if (widget.all_tickets.length >= 6) {
          for (int i = 0; i < 6; i++) {
            if(widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);
            }

          }
        } else {
          for (int i = 0;
          i < widget.all_tickets.length;
          i++) {
            if(widget.all_tickets![i].status=='On-Hold'){}else{
              selected_tickets
                  .add(widget.all_tickets[i]);}
          }}
      }
    }
    // tickets=widget.all_tickets;
    if (tickets.length >= 6) {
      for (int i = 0; i < 6; i++) {
        selected_tickets.add(tickets[i]);
      }
    } else {
      for (int i = 0; i < tickets.length; i++) {
        selected_tickets.add(tickets[i]);
      }
    }
  }
@override
  void didUpdateWidget(covariant AllTickets oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    setState(() {
      widget.dropdownvalue='${gettranslated(context, "${widget.dropdownvalue}")}';
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var selectedPageNumber = 3;
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context,);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Dashboard()),
          ModalRoute.withName('/'),
        );
        return true;
      },
      child: GestureDetector(
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
                )),leading: Builder(builder: (context) {
        return IconButton(
        icon: Icon(
        Icons.menu,
        color: _themeProvider.primaryColorLight,
        ),
        onPressed: () {
      //  adminProvider.setTickets(widget.all_tickets);
        FocusManager.instance.primaryFocus?.unfocus();
        Scaffold.of(context).openDrawer();});
        }),
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
                 //   adminProvider.setTickets(widget.all_tickets);
                  },
                  icon: Icon(
                    Icons.account_circle,
                    size: 27,
                  ))
            ],
          ),
          drawer: Container(width: width * .7, child: DrawerPage()),
          body: SingleChildScrollView(
            child: Container(
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * .01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: _themeProvider.primaryColorLight,
                            )),
                        Container(
                          color: _themeProvider.white_color,
                          width: width * .7,
                          height: height * .052,
                          child: TextFormField(
                            onChanged: (value){
                              List<Ticket> searchTickets=[];
                              if(value==''){

                                setState(() {
                                  selected_tickets=[];
                                  searchlength=0;
                                  if (tickets.length >= 6) {
                                    for (int i = 0; i < 6; i++) {
                                      selected_tickets.add(tickets[i]);

                                    }
                                    setState(() {

                                    });
                                  } else {

                                    for (int i = 0; i < tickets.length; i++) {
                                      selected_tickets.add(tickets[i]);
                                    }}
                                });
                              }
                              selected_tickets=[];
                              for(int i=0;i<tickets.length;i++){

                                if( ( tickets[i].subject).toLowerCase().contains(value.toLowerCase())){

                                  searchTickets.add(tickets[i]);
                                  setState(() {
                                    if (searchTickets.length >= 6) {
                                      for (int i = 0; i < 6; i++) {
                                        selected_tickets.add(searchTickets[i]);

                                      }
                                      setState(() {

                                      });
                                    } else {
                                      for (int i = 0; i < searchTickets.length; i++) {
                                        selected_tickets.add(searchTickets[i]);
                                      }}
                                  });
                                  searchlength=searchTickets.length;
                                  setState(() {

                                  });
                                }
                              }

                            },
                            controller: searchvalue,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.all(5),
                              hintText: '${gettranslated(context, "Search..")}',
                              hintStyle: TextStyle(color: Color(0xff8e8c8c)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: _themeProvider.light_border_color),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: _themeProvider.light_border_color,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //box**********************************************************
                  Container(
                    width: width * .93,
                    height: height * .77,
                    decoration: BoxDecoration(
                        //   color: Color(0xffe4eef3),
                        border: Border(
                            top: BorderSide(
                              width: 3,
                              color:
                                  _themeProvider.white_color, // Color(0xff2c2b2b)
                            ),
                            bottom: BorderSide(
                                width: 3,
                                color: _themeProvider.light_border_color),
                            left: BorderSide(
                                width: 3,
                                color: _themeProvider.light_border_color),
                            right: BorderSide(
                                width: 3,
                                color: _themeProvider.light_border_color))
                        //  borderRadius:BorderRadius.circular(8),
                        ),
                    child: Column(
                      children: [
                        Container(
                            width: width * .93,
                            height: height * .07,
                            decoration: BoxDecoration(
                              color: _themeProvider.dividerColor,
                              // border: Border.all(color:Color(0xff8e8c8c),),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  adminProvider.admin
                                      ? DropdownButton(
                                          underline: SizedBox(),
                                          // Initial Value
                                          value: widget.dropdownvalue,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: _themeProvider
                                                .primaryColorLight,
                                          ),
                                          selectedItemBuilder: (context) {
                                            return items_admin
                                                .map<Widget>((String item) {
                                              return Container(
                                                child: Center(
                                                  child: Text(item,
                                                      style:  TextStyle(
                                                        fontFamily:
                                                            'SourceSansPro',
                                                        color:
                                                            _themeProvider.primaryColorLight,
                                                        fontSize: width*.036,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      )),
                                                ),
                                              );
                                            }).toList();
                                          },
                                          // Array list of items
                                          items:
                                              items_admin.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text('${gettranslated(context, items)}'),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) async {
                                            status='All';
                                         if(newValue=="My Tickets"){
                                           adminProvider.setPermission(adminProvider.myTicketspermission);
                                         }else if (newValue=="Assigned Tickets"){
                                           adminProvider.setPermission(adminProvider.assignedTicketspermission);
                                         }else if (newValue=="My Assigned Tickets"){
                                           adminProvider.setPermission(adminProvider.myAssignedTicketspermission);
                                         }else if (newValue=="Overdue Tickets"){
                                           adminProvider.setPermission(adminProvider.overdueTicketspermission);
                                         }else{
                                           adminProvider.setPermission(adminProvider.allTicketspermission);
                                         }
                                            selected_tickets = [];

                             // 'My Tickets'  'Assigned Tickets'   'My assign Tickets'    'Overdue Tickets',
                                             if (newValue ==
                                                'My Tickets') {

                                              this.tickets = my_Tickets;
                                             if(onholdTicketsv.value=="true"&&closedTickets.value=="true"){
                                               if (tickets.length >= 6) {
                                                 for (int i = 0; i < 6; i++) {
                                                   selected_tickets
                                                       .add(tickets[i]);
                                                 }
                                               } else {
                                                 for (int i = 0;
                                                 i < tickets.length;
                                                 i++) {
                                                   selected_tickets
                                                       .add(tickets[i]);
                                                 }
                                               }
                                             }
                                              if(closedTickets.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }if(onholdTicketsv.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }
                                            }
                                            else if (newValue ==
                                                'Assigned Tickets') {


                                              this.tickets = assign_Tickets;
                                             if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
                                               if (tickets.length >= 6) {
                                                 for (int i = 0; i < 6; i++) {
                                                   selected_tickets
                                                       .add(tickets[i]);
                                                 }
                                               } else {
                                                 for (int i = 0;
                                                 i < tickets.length;
                                                 i++) {
                                                   selected_tickets
                                                       .add(tickets[i]);
                                                 }
                                               }
                                             }
                                              if(closedTickets.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }

                                              }if(onholdTicketsv.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }
                                            }
                                            else if (newValue ==
                                                'My Assigned Tickets') {

                                              this.tickets = my_assign_Tickets;
                                             if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
                                               if (tickets.length >= 6) {
                                                 for (int i = 0; i < 6; i++) {
                                                   selected_tickets
                                                       .add(tickets[i]);
                                                 }
                                               } else {
                                                 for (int i = 0;
                                                 i < tickets.length;
                                                 i++) {
                                                   selected_tickets
                                                       .add(tickets[i]);
                                                 }
                                               }
                                             } if(closedTickets.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }if(onholdTicketsv.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }
                                            }
                                            else if (newValue ==
                                                'Overdue Tickets') {
                                               this.tickets = overdue_Tickets;
                                               if (onholdTicketsv.value ==
                                                   "true" &&
                                                   closedTickets.value ==
                                                       "true") {
                                                 if (tickets.length >= 6) {
                                                   for (int i = 0; i < 6; i++) {
                                                     selected_tickets
                                                         .add(tickets[i]);
                                                   }
                                                 } else {
                                                   for (int i = 0;
                                                   i < tickets.length;
                                                   i++) {
                                                     selected_tickets
                                                         .add(tickets[i]);
                                                   }
                                                 }
                                               }if(closedTickets.value=="false"){
                                                 if (tickets.length >= 6) {
                                                   for (int i = 0; i < 6; i++) {
    if(tickets![i].status=='Closed'){}else{
      selected_tickets
          .add(tickets[i]);
    }

                                                   }
                                                 } else {
                                                   for (int i = 0;
                                                   i < tickets.length;
                                                   i++) {
    if(tickets![i].status=='Closed'){}else{
                                                     selected_tickets
                                                         .add(tickets[i]);}
                                                   }
                                                 }




                                               }if(onholdTicketsv.value=="false"){
                                                 if (tickets.length >= 6) {
                                                   for (int i = 0; i < 6; i++) {
                                                     if(tickets![i].status=='On-Hold'){}else{
                                                       selected_tickets
                                                           .add(tickets[i]);
                                                     }

                                                   }
                                                 } else {
                                                   for (int i = 0;
                                                   i < tickets.length;
                                                   i++) {
                                                     if(tickets![i].status=='On-Hold'){}else{
                                                       selected_tickets
                                                           .add(tickets[i]);}
                                                   }
                                                 }




                                               }
                                             }
                                              else {
                                               tickets = widget.all_tickets!;
                                              if(closedTickets.value=="true"&&onholdTicketsv.value=="true"){
                                                adminProvider.setPermission(allTicketsv.value);

                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    selected_tickets
                                                        .add(tickets[i]);
                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    selected_tickets
                                                        .add(tickets[i]);
                                                  }
                                                }
                                              }if(closedTickets.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='Closed'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }if(onholdTicketsv.value=="false"){
                                                if (tickets.length >= 6) {
                                                  for (int i = 0; i < 6; i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);
                                                    }

                                                  }
                                                } else {
                                                  for (int i = 0;
                                                  i < tickets.length;
                                                  i++) {
                                                    if(tickets![i].status=='On-Hold'){}else{
                                                      selected_tickets
                                                          .add(tickets[i]);}
                                                  }
                                                }




                                              }

                                              }



                                            setState(()  {

                                              widget.dropdownvalue = newValue;//My Assigned Tickets
                                            });
                                          }):
                                  Text('${gettranslated(context, "All Tickets")}',style: TextStyle(color: _themeProvider.primaryColorLight),)

                                ,  SizedBox(width: width*.02,),Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(status,style: TextStyle(color: _themeProvider.primaryColorLight
                                          ,fontSize: width*.031,overflow: TextOverflow.ellipsis),)),
                                        PopupMenuButton<String>(icon: Icon(Icons.arrow_drop_down,color: _themeProvider.primaryColorLight,size: width*.07,),
                                            initialValue: items.first,
                                            // Callback that sets the selected popup menu item.
                                            onSelected: (String item) {
                                            setState(() {
                                              dropdownvalue3 =  item;


                                              status=dropdownvalue3;
                                              if(status=="Closed"){
                                                adminProvider.setPermission(closedTickets.value);
                                              }else if (status=="On-Hold"){
                                                adminProvider.setPermission(onholdTicketsv.value);
                                              }
                                            });
                                               if(dropdownvalue3=='All'){

                                                 if (tickets.length >= 6) {
                                                   selected_tickets=[];
                                                   for (int i = 0; i < 6; i++) {
                                                     selected_tickets.add(tickets[i]);
                                                   }
                                                 } else {
                                                   selected_tickets=[];
                                                   for (int i = 0;i < tickets.length;i++) {
                                                     selected_tickets.add(tickets[i]);
                                                   }}
                                                 setState(() {

                                                 });
                                               }else{

                                                 List<Ticket> newselected=[];
                                                 for(int i=0;i<tickets.length;i++){
                                                   if(tickets[i].status==item){

                                                     newselected.add(tickets[i]);
                                                   }
                                                 }

                                                 if (newselected.length >= 6) {
                                                   selected_tickets=[];
                                                   for (int i = 0; i < 6; i++) {
                                                     selected_tickets.add(newselected[i]);
                                                   }
                                                 } else {
                                                   selected_tickets=[];
                                                   for (int i = 0;i < newselected.length;i++) {
                                                     selected_tickets.add(newselected[i]);
                                                   }}
                                                 setState(() {

                                                 });
                                               }

                                           },
                                            itemBuilder: (BuildContext context) => statusList.map((e) =>
                                                PopupMenuItem<String>(
                                                      value: e,
                                                      child: Text(e),
                                                    )
                                            ).toList()
                                            // [
                                            //   PopupMenuItem<String>(
                                            //     value: items.first,
                                            //     child: Text('Item 1'),
                                            //   )
                                            //
                                            // ]

                                        ),
                                      ],
                                    ),
                                  ),
                                  ///////

                                  //////
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          ticketcreate.value=="false"?  Alertmessage(context,'${gettranslated(context,"Not have a permission")}',_themeProvider,width,height):            Navigator.of(context)
                                              .push(createRoute(CreateTicket()));
                                        },
                                        child: Container(
                                            width: width * .21,
                                            height: height * .1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: _themeProvider
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Center(
                                                child:  Text('${gettranslated(context, "Add Ticket")}',style: TextStyle(fontSize: width*.036),)))),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: height * .56,
                          child:adminProvider.permission=="false"?
                          Center(child: Text('${gettranslated(context, "Not have a permission",)}', style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: _themeProvider.primaryColorLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),),)

                              :selected_tickets.length == 0
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
                          ): ListView.builder(
                              itemCount: selected_tickets.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                    onTap: ()async {
    Ticket ticket=Ticket(subject: '', status: '', created_at_date: '',attached_files: []);

    ticket= await TicketController.getTicketDetail(selected_tickets[i].ticket_id);
                                      Navigator.of(context)
                                          .push(createRoute(TicketDetail(
                                        id: selected_tickets[i].ticket_id,
                                        ticket: ticket,fromdashboard: false,
                                      )));
                                    },
                                    child: TicketTile(
                                        width,
                                        height,
                                        selected_tickets[i].subject,
                                        selected_tickets[i].status,
                                      selected_tickets[i].created_at_date,
                                        false,
                                        _themeProvider));
                              }),
                        ),
                        NumberPagination(
                          onPageChanged: (int pageNumber) {
                            var ii = 0;

                            selected_tickets = [];
                            int skip = (pageNumber - 1) * 6;

                            for (int i = skip;
                                ii < 6 && i < tickets.length;
                                i++) {

                              selected_tickets.add(tickets[i]);
                              ii++;
                            }
                            setState(() {
                              selectedPageNumber = pageNumber;
                              selected_tickets;
                            });
                          },
                          threshold: 4,
                          fontSize: width * .05,
                          pageTotal:searchlength==0?(tickets.length/6).ceil():(searchlength/6).ceil(),
                          pageInit: 1,
                          // picked number when init page
                          colorPrimary: _themeProvider.white_color,
                          colorSub: _themeProvider.primaryColor,
                        ),
                      ],
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
