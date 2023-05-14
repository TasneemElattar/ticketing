import 'package:flutter/material.dart';
import 'package:ticketing_system/services/localization_methods.dart';
import 'package:ticketing_system/view/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';


class OldVersion extends StatelessWidget {
  const OldVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h =MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: h*.16,horizontal: w*.06),
          child: Column(
            children: [
              Icon(Icons.cancel_rounded,color: Colors.red,size: w*.2,),
              SizedBox(height: h*.05,),
              Column(
                children: [
                  Text("Ticketing ${gettranslated(context, "Version")} 1.1",
                    style: TextStyle(
                        fontSize: w*.045,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text("${gettranslated(context, "This version needs to up to date! please contact with the technical team")}",
                    style: TextStyle(
                        fontSize: w*.045,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*.1,),

              InkWell(
                onTap: () => launchUrl(Uri.parse('support@sv4it.com')),
                child: Text(
                  'support@sv4it.com',
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue,fontSize: w*.045,fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}