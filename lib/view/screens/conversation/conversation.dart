import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/admin_controller.dart';
import 'package:ticketing_system/model/message_model.dart';
import 'package:ticketing_system/view/screens/conversation/inner_chat.dart';
import 'package:ticketing_system/view/screens/conversation/show_sent_image.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';
import '../../../../controller/page_route.dart';
import '../../../controller/login_controller.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/ticket_model.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/drawer.dart';
import '../../widgets/message_chat.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../notification.dart';
import '../tickets/ticket_detail.dart';

class ConversationScreen extends StatefulWidget {
  String ticket_id; String status;
  Ticket ticket; bool fomdashboard;
  ConversationScreen({required this.ticket_id, required this.status,required this.ticket,required this.fomdashboard});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController text_controller = TextEditingController();

  List<MessageModel> messages = [];
  File? file;
  String selectedfilepath='';
  final _scrollController =  ScrollController();
bool loaded_messages=false;
  getTicketMessages(String ticket_id)async{
    List<MessageModel> messagesApi=await Admin.getAllMessages(ticket_id);
    messages=messagesApi;
    log(widget.ticket_id.toString());
    messagesApi.length >= 0 ? loaded_messages = true : null;

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      messagesApi.length>0? _scrollController.animateTo(
          _scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn) : null;

    });
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTicketMessages(widget.ticket_id).then((result){

     });

   //  SchedulerBinding.instance?.addPostFrameCallback((_) {
   //   double height=MediaQuery.of(context).size.height;
     // loaded_messages?_scrollController.animateTo(_scrollController.position.maxScrollExtent,
     //      duration: const Duration(milliseconds: 1),
     //      curve: Curves.fastOutSlowIn):null;
  //   _scrollController.animateTo(height * .8,
  //       duration: const Duration(milliseconds: 1),
  //       curve: Curves.fastOutSlowIn);
// setState(() {
//
// });

   //  });


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    AdminProvider _adminprovider =
        Provider.of<AdminProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).push(createRoute(TicketDetail(id: widget.ticket_id,ticket: widget.ticket!, fromdashboard: widget
          .fomdashboard,)));
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(createRoute(TicketDetail(id: widget.ticket_id,ticket: widget.ticket, fromdashboard: widget
                                  .fomdashboard,)));
                            },
                            icon: Icon(Icons.arrow_back),
                            color: _themeProvider.primaryColorLight,
                          ),
                          SizedBox(
                            width: width * .15,
                          ),
                          Center(
                            child: Text('${gettranslated(context, "Conversation")}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: _themeProvider.primaryColorLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.15,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .53,
                      child: loaded_messages != true
                          ? Center(
                        child: CircularProgressIndicator(
                          color: _themeProvider.primaryColorLight,
                        ),
                      )
                          : messages.length == 0
                          ? Center(
                        child: Text(
                          '${gettranslated(context, "There is no Replies...")}',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: _themeProvider.primaryColorLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                      :ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, i) {
                            bool me = messages[i].userId!=null;

                            return me==false
                                ? chat_Me(context,width, height,messages[i], true,
                                    _themeProvider, _adminprovider.admin)
                                : chat_Me(context,width,height, messages[i], false,
                                    _themeProvider, _adminprovider.admin);
                          })
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${gettranslated(context, "Reply")}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _themeProvider.primaryColorLight),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * .8,
                              height: height * .17,
                              decoration: BoxDecoration(
                                  color: _themeProvider.box_description,
                                  border:
                                      Border.all(color: _themeProvider.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                style: TextStyle(
                                    color: _themeProvider.primaryColorLight),
                                keyboardType: TextInputType.multiline,
                                maxLines: 1000,
                                controller: text_controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: width * .02),
                                  labelText: '${gettranslated(context, "Enter Your Reply here")}',
                                  labelStyle: TextStyle(
                                      color: _themeProvider.primaryColorLight
                                          .withOpacity(0.5)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),InkWell(
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

                                    });
                                    Navigator.of(context).push( createRoute(ShowSentImage(status: widget.status,image: file!,ticket: widget.ticket,theme: _themeProvider,ticket_id: widget.ticket_id,
                                    text:text_controller.text,fromdashboard: widget.fomdashboard,)));
                                  } else {
                                    // User canceled the picker
                                  }
                                  setState(() {});
                                },
                                child: Icon(Icons.attach_file,color: _themeProvider.primaryColorLight,))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Row(
                      mainAxisAlignment: _adminprovider.admin
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        // _adminprovider.admin
                        //     ? InkWell(
                        //         onTap: () {
                        //           Navigator.of(context)
                        //               .push(createRoute(InnerChat()));
                        //         },
                        //         child: Text(
                        //           '${gettranslated(context, "inner chat")}',
                        //           style: TextStyle(
                        //             color: _themeProvider.primaryColorLight,
                        //             decoration: TextDecoration.underline,
                        //           ),
                        //         ))
                        //     : SizedBox(),
                        SizedBox(),
                        InkWell(
                          onTap: () async{

                            log(widget.status);
                            FocusScopeNode currentFocus;
                            currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                    if(text_controller.text!=''){
                      var statuscode=     await Admin.sendMessage(file_path: '',
                          ticket_id: widget.ticket_id, message: text_controller.text, ticket_status: widget.status);
                      if( statuscode==200) {
                        log(statuscode.toString());

                        setState(() {

                          this.messages.add(MessageModel(
                              message: text_controller.text,
                              date: DateTime.now().toString(),
                              messageOwner: Auth.username, userId: '1',media: []));
                          text_controller.clear();
                          SchedulerBinding.instance!.addPostFrameCallback((_) {
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                          });
                        });
                      }else{
                        ScaffoldMessenger.of(context)
                            .showSnackBar(showsnack(width, _themeProvider, '${gettranslated(context, "can not send !")}', Icons.error));
                      }
                    }else{
                      ScaffoldMessenger.of(context)
                          .showSnackBar(showsnack(width, _themeProvider, '${gettranslated(context, "can not send !")}', Icons.error));
                    }
                            setState(() {
                              // _scrollController.animateTo(height * .89,
                              //     duration: const Duration(milliseconds: 1),
                              //     curve: Curves.fastOutSlowIn);
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent);

                            });
                          },
                          child: Container(
                              width: width * .3,
                              child: Button(title: '${gettranslated(context, "Send Reply")}')),
                        ),
                      ],
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
