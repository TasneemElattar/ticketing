import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticketing_system/model/message_model.dart';

import '../../controller/page_route.dart';
import '../../controller/provider/theme_provider.dart';
import '../../services/localization_methods.dart';
import '../screens/tickets/show_ticket_image.dart';

chat_Me(context,
    width,height, MessageModel message, bool me, ThemeProvider provider, bool admin) {
  return Padding(padding: EdgeInsets.only(bottom: height*.02
  ),child:  Column(
    crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * .7,
            // height: height*.15,
            color: me
                ? provider.blue_me_chat_light
                : provider.blue_customer_chat_light,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            message.message,
                            style: TextStyle(color: provider.primaryColorLight),
                          )),
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),SizedBox(height: height*.01,),
      Column(
          children: message.media.map((e) =>       Container(
            width: width * .7,
            // height: height*.15,
            color: me
                ? provider.blue_me_chat_light
                : provider.blue_customer_chat_light,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Column(
                      children: message.media.map((e) => InkWell(
                        onTap:(){
                          Navigator.of(context).push( createRoute(ShowTicketImage(image: e)));

                        },
                          child: Text(e,style: TextStyle(color: provider.primaryColorLight.withOpacity(0.6),decoration: TextDecoration.underline),))).toList()
                  )
                ],
              ),
            ),
          )).toList()
      ),
      CircleAvatar(
        backgroundColor: provider.primaryColor,
        child: Icon(
          Icons.account_circle,
          color: provider.primaryColorLight,
        ),
        radius: 15,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            message.messageOwner,
            style: TextStyle(color: provider.primaryColorLight),
          ),SizedBox(height: height*.003,),

          (DateTime.now().difference(DateTime.parse(message.date))).inHours>=24  ?
          Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(message.date))).inDays} ${gettranslated(context, "days")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5) ),):

  (DateTime.now().difference(DateTime.parse(message.date))).inMinutes>=60  ?
          Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(message.date))).inHours} ${gettranslated(context, "hours")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5) ),):
  (DateTime.now().difference(DateTime.parse(message.date))).inSeconds>=60  ?
          Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(message.date))).inMinutes} ${gettranslated(context, "minutes")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5)),)
:  (DateTime.now().difference(DateTime.parse(message.date))).inMilliseconds>=60  ?
      Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(message.date))).inSeconds} ${gettranslated(context, "seconds")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5)),)
        :  Text('${gettranslated(context, "less than one second")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5)),)
          ,
  ],
      )
    ],
  ),);
}
