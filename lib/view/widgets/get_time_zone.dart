import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../controller/provider/theme_provider.dart';
import '../../services/localization_methods.dart';


class GetTimeZones extends StatefulWidget {
 double  width;
 double height;
 String title;ThemeProvider themeProvider ;TextEditingController timezone_controller;List<String> timezones;
  GetTimeZones(  this.width, this.height,  this.title,  this.themeProvider ,  this.timezone_controller,  this.timezones);

  @override
  State<GetTimeZones> createState() => _GetTimeZonesState();
}

class _GetTimeZonesState extends State<GetTimeZones> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width*.5,
      height: widget.height*.055,
      child: TypeAheadFormField(
        hideSuggestionsOnKeyboardHide:true,
        direction: AxisDirection.up,
        textFieldConfiguration: TextFieldConfiguration(onChanged: (value){
        },style: TextStyle(color:widget. themeProvider.primaryColorLight),
          textDirection: TextDirection.ltr,
          controller: widget.timezone_controller,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(filled: true,fillColor:widget. themeProvider.textfieldColor,
            hintText: '${gettranslated(context, "select time zone")}',
            hintStyle: TextStyle(color:widget.themeProvider.primaryColorLight.withOpacity(0.5)),
            contentPadding:
            EdgeInsets.only(
                left: 8.0,right: 2,
                bottom: 8.0,
                top: 8.0),
            isDense: true,

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.themeProvider.primaryColor,
                width: 1.5,
              ),
            ),
            // labelStyle:  TextStyle(overflow: TextOverflow.visible,color: themeProvider.primaryColorLight,
            //     fontSize: width*.03
            // ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color:widget. themeProvider.primaryColor)
            ),

            suffixIcon: Icon(Icons.keyboard_arrow_down,size: widget.width*.06,color: widget.themeProvider.textfieldColor,),
          ),
        ),
        suggestionsCallback: (pattern) {

          return
            widget.    timezones.where((String  element) =>
                element.toLowerCase().contains(pattern.toLowerCase()));

        },
        itemBuilder: (_,String ittem) =>widget. timezones.length==0?Center(child: CircularProgressIndicator()):ListTile(
          title: InkWell(
            child: Row(
              children: [
                Expanded(child: Text(ittem.toString(),style: TextStyle(overflow: TextOverflow.visible,
                  fontSize: widget.width*.037,
                ))),
                SizedBox(width: 0.05,)
              ],
            ),
          ),
        ),
        onSuggestionSelected: ( String val) async{

          widget. timezone_controller.text=val;

          setState(() {
          });
        },
        getImmediateSuggestions: true,
        validator: (value) {
          if (value!.isEmpty) {
            return '${gettranslated(context, "Please select")}';
          }
        },
      ),
    );
  }
}
