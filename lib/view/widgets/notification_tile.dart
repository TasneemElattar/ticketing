import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';
import 'package:ticketing_system/model/notification_model.dart';

import '../../services/localization_methods.dart';

notificationTicketTile (context,width,height,NotificationModel model,ThemeProvider provider){

  return Container(
      padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.01),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(model.title,style:  TextStyle(
                fontFamily: 'SourceSansPro',
                color: provider.primaryColorLight,
                fontSize: 16,
                fontWeight: model.readAt!=null?FontWeight.w400:FontWeight.w800,
                fontStyle: FontStyle.normal,

              )),
            ),Text(model.status,style:  TextStyle(
              fontFamily: 'SourceSansPro',
              color: provider.primaryColorLight.withOpacity(0.5),
              fontSize: width*.04,fontWeight: model.readAt!=null?FontWeight.w400:FontWeight.w800,
              fontStyle: FontStyle.normal,

            )),
            //Icon(Icons.more_vert,size: width*.055,color: provider.primaryColorLight,)
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(model.category,style:  TextStyle(
                fontFamily: 'SourceSansPro',
                color: provider.primaryColorLight.withOpacity(0.5),
                fontSize: 16,fontWeight: model.readAt!=null?FontWeight.w400:FontWeight.w800,
                fontStyle: FontStyle.normal,

              )),
            ),
            (DateTime.now().difference(DateTime.parse(model.created_at))).inHours>=24  ?
            Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(model.created_at))).inDays} ${gettranslated(context, "days")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5) ),):

            (DateTime.now().difference(DateTime.parse(model.created_at))).inMinutes>=60  ?
            Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(model.created_at))).inHours} ${gettranslated(context, "hours")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5) ),):
            (DateTime.now().difference(DateTime.parse(model.created_at))).inSeconds>=60  ?
            Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(model.created_at))).inMinutes} ${gettranslated(context, "minutes")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5)),)
                :  (DateTime.now().difference(DateTime.parse(model.created_at))).inMilliseconds>=60  ?
            Text('${gettranslated(context, "ago")} ${(DateTime.now().difference(DateTime.parse(model.created_at))).inSeconds} ${gettranslated(context, "seconds")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5)),)
                :  Text('${gettranslated(context, "less than one second")}',style: TextStyle(color:provider.primaryColorLight.withOpacity(0.5)),)
            //Text('${(DateFormat.yMd().add_jm().format(DateTime.parse(model.updated_at)))}'
            //   //  '-${DateTime.parse(model.created_at).month}-${DateTime.parse(model.created_at).day}-'
            //   //  '${DateTime.parse(model.created_at).hour}:${DateTime.parse(model.created_at).minute}'
            //     ,style:  TextStyle(
            //   fontFamily: 'SourceSansPro',
            //   color: provider.primaryColorLight.withOpacity(0.5),
            //   fontSize: width*.038,
            //   fontStyle: FontStyle.normal,
            //
            // ))
          ],),SizedBox(height: height*.01,), Container(
            width: width*.9,
            height: 1,
            decoration: new BoxDecoration(
                color: Color(0xffe4eef3)
            )
        )
      ],)
  );

}
