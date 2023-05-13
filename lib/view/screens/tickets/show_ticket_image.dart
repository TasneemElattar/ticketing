import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/theme_provider.dart';
import '../../../services/localization_methods.dart';

class ShowTicketImage extends StatelessWidget {
  String image='';
  ShowTicketImage({required this.image});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    ThemeProvider _themeProvider =Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeProvider.primaryColor,
        foregroundColor: _themeProvider.primaryColorLight,
        title: Text('${gettranslated(context, "File")}',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: _themeProvider.primaryColorLight,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.15,
            )),

      ),
      body: Container(
        width: width,height: height,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [

                image==''?
                Image.asset('assets/images/icon.png',color: _themeProvider.primaryColorLight,height: height*.8,):
                InteractiveViewer(
                    panEnabled: false, // Set it to false to prevent panning.
                    boundaryMargin: EdgeInsets.all(0),
                    minScale: 1,
                    maxScale: 4,
                    child: FadeInImage(image: NetworkImage(image),height: height*.8,width: width, placeholder: AssetImage('assets/images/loadingGif.gif',)))


          ],
        ),
      ),
    );
  }
}
