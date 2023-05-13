import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:ticketing_system/controller/page_route.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';
import 'package:ticketing_system/view/screens/conversation/conversation.dart';
import 'dart:io';

import '../../../controller/admin_controller.dart';
import '../../../model/ticket_model.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/button.dart';
import '../../widgets/snackbar.dart';
class ShowSentImage extends StatefulWidget {
  File image;
  ThemeProvider theme;
  String ticket_id;
  String status;
  String text;bool fromdashboard; Ticket ticket;
  ShowSentImage({required this.image,required this.theme,required this.status,required this.ticket_id,required this.text,required this.fromdashboard,required this.ticket});

  @override
  State<ShowSentImage> createState() => _ShowSentImageState();
}

class _ShowSentImageState extends State<ShowSentImage> {
 TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height*.05,),
            InkWell(
              onTap: (){Navigator.pop(context);},
              child: Padding(
                padding:  EdgeInsets.only(right: width*.82),
                child: Icon(Icons.arrow_back,color: widget.theme.primaryColorLight,),
              ),
            ),
            SizedBox(
                height: height*.6,width: width,
                child: Image.file(widget.image)),
            SizedBox(height: height*.02,),
            Container(
              width: width * .8,
              height: height * .2,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: widget.theme.box_description,
                  border:
                  Border.all(color: widget.theme.primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                style: TextStyle(
                    color: widget.theme.primaryColorLight),
                keyboardType: TextInputType.multiline,
                maxLines: 1000,
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: width * .02),
                  labelText: '${gettranslated(context, "Enter Your Reply here")}',
                  labelStyle: TextStyle(
                      color: widget.theme.primaryColorLight
                          .withOpacity(0.5)),
                  border: InputBorder.none,
                ),
              ),
            ),SizedBox(height: height*.01,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async{
           if(textEditingController.text==''){
             ScaffoldMessenger.of(context)
                 .showSnackBar(showsnack(width, widget.theme, '${gettranslated(context, "Enter Your Reply here")}', Icons.error));
           }else{
             Loader.show(context,progressIndicator:CircularProgressIndicator(color: widget.theme.primaryColorLight,));

             FocusScopeNode currentFocus;
             currentFocus = FocusScope.of(context);
             if (!currentFocus.hasPrimaryFocus) {
               currentFocus.unfocus();
             }
             var statuscode= await Admin.sendMessage(file_path: widget.image.path,
                 ticket_id: widget.ticket_id, message: textEditingController.text, ticket_status: widget.status);
             statuscode==200? [
               Loader.hide(),
               textEditingController.clear(),
               Navigator.of(context).push(createRoute(ConversationScreen(ticket_id: widget.ticket_id, status: '',
                 ticket: widget.ticket,fomdashboard: widget.fromdashboard,)))

                      ]:[
               Loader.hide(),
               ScaffoldMessenger.of(context)
                   .showSnackBar(showsnack(width, widget.theme, '${gettranslated(context, "can not send !")}', Icons.error))

             ];
           }
            },
                    child: Container(
                        width: width * .3,
                        child: Button(title: '${gettranslated(context, "Send Reply")}')),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
