

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../model/language_model.dart';
import 'localization.dart';

String? gettranslated(BuildContext context,String key){
  return SetLocalization.of(context).translate(key);
}
const String languagecode='langcode';
const String English='en';
const String Arabic='ar';

Future<Locale>setlocale(String language_code)async{
  SharedPreferences preferences =await  SharedPreferences.getInstance();
  preferences.setString(languagecode, language_code);
  return switchlocal(language_code);

}


Locale switchlocal(lang){
  Locale temp;
  switch (lang) {
    case English:
      temp = Locale(English, 'US');
      break;
    case Arabic:
      temp = Locale(Arabic, 'EG');
      break;
    default:
      temp = Locale(English, 'US');
      break;
  }
  return temp;
}

Future getlocale()async{
  SharedPreferences preferences =await SharedPreferences.getInstance();
  String langcode=preferences.getString(languagecode)??English;
  return switchlocal(langcode);
}

changelanguage(BuildContext context,Language lang) async {
  Locale temp=await setlocale(lang.languagecode);
  MysPLASH.setTheLocale(context, temp);

}