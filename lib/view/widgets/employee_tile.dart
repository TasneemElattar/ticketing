import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketing_system/controller/provider/theme_provider.dart';

import '../../model/employee.dart';

EmployeeTile (width,height,Employee employee,ThemeProvider provider){

  return Container(
      padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.01),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('${employee.first_name} ${employee.last_name}',style:  TextStyle(
                fontFamily: 'SourceSansPro',
                color: provider.primaryColorLight,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,

              )),
            ),Icon(Icons.more_vert,size: width*.055,color: provider.primaryColorLight,)
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(employee.role??'',style:  TextStyle(
                fontFamily: 'SourceSansPro',
                color: provider.primaryColorLight.withOpacity(0.5),
                fontSize: 16,
                fontStyle: FontStyle.normal,

              )),
            ),Text(employee.date==null||employee.date=='null'||employee.date==''?'':'${(DateFormat.yMd().add_jm().format(DateTime.parse(employee.date)))}',style:  TextStyle(
              fontFamily: 'SourceSansPro',
              color: provider.primaryColorLight.withOpacity(0.5),
              fontSize: 16,
              fontStyle: FontStyle.normal,
            ))
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
