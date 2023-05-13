import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/screens/tickets/all_tickets.dart';
import 'package:ticketing_system/view/screens/tickets/create_ticket.dart';
import 'package:ticketing_system/view/screens/tickets/show_ticket_image.dart';
import 'package:ticketing_system/view/widgets/button.dart';
import 'dart:io';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/ticket_model.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/snackbar.dart';
import '../conversation/conversation.dart';
import '../dashboard.dart';
import '../notification.dart';

class TicketDetail extends StatefulWidget {
  String id;
Ticket ticket;
bool fromdashboard;
  TicketDetail({required this.id,required this.ticket,required this.fromdashboard});

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  File? file;

//Ticket ticket=Ticket(subject: '', status: '', created_at_date: '');
// getTicketDetail(String id)async{
//  ticket= await TicketController.getTicketDetail(id);
//  setState(() {
//  });
// }
// @override
  List<String> statuslist = [];
String dropdownvalue='';
  getTicketMessageStatus() async {
    List<String> statusapi = await User.getTicketStatusFilterformessage();
    statuslist = statusapi;

    setState(() {

    });
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

  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.id);
    getUnReadNotificationLength();
    dropdownvalue=widget.ticket!.status;
    getTicketMessageStatus();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context,);
    return WillPopScope(
      onWillPop: () async {
        widget.fromdashboard ? Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Dashboard()),
          ModalRoute.withName('/'),) :
        Navigator.pushReplacement(context, createRoute(
            AllTickets(status: 'all', all_tickets: adminProvider.tickets)));
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
            width: width, height: height,
            decoration: _themeProvider.path == null ? BoxDecoration(
              color: _themeProvider.backgroundColor,) :
            BoxDecoration(
              color: _themeProvider.backgroundColor,
              image: DecorationImage(
                image: AssetImage(_themeProvider.path!),
                fit: BoxFit.cover,
              ),),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,
                                color: _themeProvider.primaryColorLight,)),
                          SizedBox(
                            width: width * .15,
                          ),
                          Text('${gettranslated(context, "Ticket Details")}',
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
                              bottom:
                              BorderSide(width: 3,
                                  color: _themeProvider.light_border_color),
                              left:
                              BorderSide(width: 3,
                                  color: _themeProvider.light_border_color),
                              right: BorderSide(
                                  width: 3,
                                  color: _themeProvider.light_border_color))),
                      child: Padding(
                        padding: EdgeInsets.all(width * .02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: custom_text(
                                    widget.ticket!.subject, height, width,
                                    _themeProvider),)

                              ],
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.ticket.updated_at_date == ''
                                    ? ''
                                    : '${gettranslated(context, "Last update on :")} ${(DateFormat.yMd()
                                    .add_jm()
                                    .format(DateTime.parse(
                                    widget.ticket.updated_at_date)))}',
                                  style: TextStyle(
                                      color: _themeProvider.primaryColorLight
                                          .withOpacity(0.599)),
                                ),
                              ],),
                            custom_text('${gettranslated(context, "Ticket Description")}', height, width,
                                _themeProvider),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width * .03),
                              child: Text(widget.ticket!.description,
                                style: TextStyle(
                                    color: _themeProvider.primaryColorLight),),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02,),
                    //   Divider(color: Colors.white,height: height*.01,thickness: height*.006,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                width: 3,
                                color: _themeProvider
                                    .white_color, // Color(0xff2c2b2b)
                              ),
                              bottom:
                              BorderSide(width: 3,
                                  color: _themeProvider.light_border_color),
                              left:
                              BorderSide(width: 3,
                                  color: _themeProvider.light_border_color),
                              right: BorderSide(
                                  width: 3,
                                  color: _themeProvider.light_border_color))),
                      child: Padding(
                        padding: EdgeInsets.all(width * .02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            custom_text('${gettranslated(context, "Ticket Information")}', height, width,
                                _themeProvider),
                            Padding(
                              padding: EdgeInsets.only(left: width * .02),
                              child: Column(
                                children: [
                                  rowdetail('${gettranslated(context, "Ticket ID")}', height, width,
                                      widget.ticket.ticket_id, _themeProvider),
                                  rowdetail(
                                      '${gettranslated(context, "Ticket Category")}', height, width,
                                      widget.ticket.category, _themeProvider),
                                  widget.ticket?.sub_category == null ||
                                      widget.ticket?.sub_category == 'null' ||
                                      widget.ticket?.sub_category == ''
                                      ? SizedBox()
                                      : rowdetail(
                                      '${gettranslated(context, "Ticket Sub Category")}', height,
                                      width, widget.ticket!.sub_category,
                                      _themeProvider),
                                  widget.ticket?.project == null ||
                                      widget.ticket?.project == 'null' ||
                                      widget.ticket?.project == ''
                                      ? SizedBox()
                                      : rowdetail('${gettranslated(context, "Project")}', height, width,
                                      widget.ticket!.project, _themeProvider),
                                  rowdetail('${gettranslated(context, "Created at")}', height, width,
                                      widget.ticket.created_at_date == ''
                                          ? ''
                                          : '${(DateFormat.yMd()
                                          .add_jm()
                                          .format(DateTime.parse(
                                          widget.ticket.created_at_date)))}',
                                      _themeProvider),
                                  rowdetail('${gettranslated(context, "Ticket Status")}', height, width,
                                      widget.ticket!.status, _themeProvider,
                                      status: true,
                                      statuss: widget.ticket!.status),


                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * .01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          '${gettranslated(context, "Attached files :")}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: _themeProvider
                                                  .primaryColorLight,
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15,
                                              letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w500,
                                              height: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  widget.ticket.attached_files.length > 0
                                      ? Column(
                                    children: widget.ticket.attached_files.map((
                                        e) =>
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height * .01),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  SizedBox(width: width * .05,),
                                                  Expanded(child: InkWell(
                                                      onTap: () async {
                                                        Navigator.of(context)
                                                            .push(createRoute(
                                                            ShowTicketImage(
                                                                image: e)));
                                                        //
                                                        // try{
                                                        //   if (!await launchUrl(Uri.parse(e))) {
                                                        //     ScaffoldMessenger.of(context)
                                                        //         .showSnackBar(showsnack(width, _themeProvider, 'cann\'t open !', Icons.error));
                                                        //   }
                                                        // }catch(e){
                                                        //   ScaffoldMessenger.of(context)
                                                        //       .showSnackBar(showsnack(width, _themeProvider, 'cann\'t open !', Icons.error));
                                                        //
                                                        // }
                                                      },
                                                      child: Text(
                                                        e, style: TextStyle(
                                                        color: _themeProvider
                                                            .primaryColorLight,
                                                        decoration: TextDecoration
                                                            .underline,),)))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                        .toList(),
                                  )
                                      : Text("${gettranslated(context, "There is no files..")}",
                                    style: TextStyle(
                                        color: _themeProvider.primaryColorLight
                                            .withOpacity(.599)),)

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    InkWell(
                        onTap: () {
                           log('status here ${widget.ticket!.status}');

                          Navigator.of(context).push(createRoute(
                              ConversationScreen(ticket_id: widget.ticket.ticket_id,
                                status: statuslist.contains(widget.ticket!.status)?widget.ticket!.status:'',
                                ticket: widget.ticket,
                                fomdashboard: widget.fromdashboard,)));
                        },
                        child: Button(title: '${gettranslated(context, "Conversation")}')),
                    SizedBox(
                      height: height * .01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(createRoute(CreateTicket()));
                      },
                      child: Container(
                          width: width * 81,
                          height: height * .046,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _themeProvider.primaryColorLight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('${gettranslated(context, "Create New Ticket +")}',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: _themeProvider.primaryColorLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                )),
                          )),
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


  rowdetail(title, height, width, info, ThemeProvider provider,
      {bool status = false, String statuss = ''}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * .01, horizontal: width * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${title} :',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: provider.primaryColorLight,
                fontFamily: 'Source Sans Pro',
                fontSize: 15,
                letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.w500,
                height: 1),
          ), SizedBox(width: width * .05,),
          Expanded(child: Text(
            info, style: TextStyle(color: provider.primaryColorLight),)),
          status ?
          PopupMenuButton<String>(icon: Icon(
            Icons.arrow_drop_down, color: provider.primaryColorLight,
            size: width * .07,),
              initialValue: dropdownvalue,
              // Callback that sets the selected popup menu item.
              onSelected: (String item) {
                setState(() {
                  dropdownvalue = item;
                  widget.ticket!.status=dropdownvalue;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(showsnack(
                      width, provider, '${gettranslated(context, "Status will be changed when send reply")}',
                      Icons.check));
                });
              },
              itemBuilder: (BuildContext context) =>statuslist.map((e) =>
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

          )
              : SizedBox()
        ],
      ),
    );
  }
}
custom_text(String title, height, width,ThemeProvider provider) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: height * .01),
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
