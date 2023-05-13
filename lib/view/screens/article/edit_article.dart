import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/user_controller.dart';
import 'package:ticketing_system/model/article_model.dart';
import 'package:ticketing_system/view/screens/article/all_articles.dart';
import 'package:ticketing_system/view/screens/profile_settings/profile_settings.dart';
import 'package:ticketing_system/view/widgets/button.dart';

import 'dart:io';
import '../../../controller/admin_controller.dart';
import '../../../controller/page_route.dart';
import '../../../controller/provider/admin_provider.dart';
import '../../../controller/provider/theme_provider.dart';
import '../../../model/ticket_category.dart';
import '../../../services/localization_methods.dart';
import '../../widgets/alert_message.dart';
import '../../widgets/drawer.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/snackbar.dart';
import '../dashboard.dart';
import '../notification.dart';
import '../tickets/show_ticket_image.dart';

class EditArticle extends StatefulWidget {
  Article article;

  EditArticle({required this.article});

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  TextEditingController title_controller = TextEditingController();
  TextEditingController category_controller = TextEditingController();
  TextEditingController tag_controller = TextEditingController();
  TextEditingController text_controller = TextEditingController();
  bool status = false;
  bool isChecked = false;
  File? article_file;
  PickedFile? imageFile = null;
  String selected_image='';
  String selected_file='';
  String new_selected_image='';
  String new_selected_file='';
  String selected_tag = '';
   TicketProjects? dropdownvalue2;
  List<String> selected_tages = [];
  List<TicketProjects> articleCategories=[];
  getArticleCategories()async{
    List<TicketProjects> itemss= await Admin.getArticleCategories();
    articleCategories=itemss;

    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticleCategories();
    this.isChecked = widget.article.privatemode;
    this.status = widget.article.status;
    title_controller.text = widget.article.title;
    category_controller.text = widget.article.category_name!;
    text_controller.text = widget.article.description;
    selected_tages = widget.article.tags.split(',');
      imageFile=widget.article.featureImage==''?imageFile=null:imageFile=PickedFile(widget.article.featureImage);
     article_file= widget.article.media.length==0?article_file=null:article_file=File(widget.article.media.first);
   //  log('aricle file ${article_file!.path}');log('iii ${imageFile!.path}');
      widget.article.featureImage==''?selected_image='':selected_image=imageFile!.path.toString();
      widget.article.media.length==0?selected_file='':selected_file=article_file!.path.toString();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
    return GestureDetector(
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
              padding: EdgeInsets.symmetric(
                  vertical: height * .01, horizontal: width * .04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * .01, horizontal: width * .04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: _themeProvider.primaryColorLight,
                            )),
                        SizedBox(
                          width: width * .15,
                        ),
                        Text('${gettranslated(context, "Edit Article")}',
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
                            bottom: BorderSide(
                                width: 3,
                                color: _themeProvider.light_border_color),
                            left: BorderSide(
                                width: 3,
                                color: _themeProvider.light_border_color),
                            right: BorderSide(
                                width: 3,
                                color: _themeProvider.light_border_color))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .02, vertical: height * .01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              imageFile == null
                                  ? InkWell(
                                      onTap: () async {
                                        final pickedFile =
                                            await ImagePicker().getImage(
                                          source: ImageSource.gallery,
                                        );
                                        setState(() {
                                          imageFile = pickedFile! as PickedFile?;

                                          selected_image=imageFile!.path;
                                          new_selected_image=imageFile!.path;
                                          log('image $selected_image');
                                        });
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: width * .36,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _themeProvider
                                                    .primaryColorLight),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .01),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${gettranslated(context, "Feature Image")}',
                                                  style: TextStyle(
                                                      color: _themeProvider
                                                          .primaryColorLight),
                                                ),
                                                Icon(
                                                  Icons.attachment_outlined,
                                                  color: _themeProvider
                                                      .primaryColorLight,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        width: width * .35,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _themeProvider
                                                    .primaryColorLight),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .01),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      imageFile!.path
                                                          .split('/')
                                                          .last,
                                                      style: TextStyle(color: _themeProvider.primaryColorLight,
                                                          fontSize:
                                                              width * .032),
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              InkWell(
                                                  onTap: ()async {
                                                    // imageFile = null;
                                                    // selected_image='';
                                                    // new_selected_image='';
                                                    // setState(() {});
                                                    final pickedFile =
                                                        await ImagePicker().getImage(
                                                      source: ImageSource.gallery,
                                                    );
                                                    setState(() {
                                                      imageFile = pickedFile! as PickedFile?;

                                                      selected_image=imageFile!.path;
                                                      new_selected_image=imageFile!.path;
                                                      log('image $selected_image');
                                                    });
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: _themeProvider
                                                        .primaryColorLight,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              article_file == null
                                  ? InkWell(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                // type: FileType.custom,
                                                // allowedExtensions: ['jpg', 'pdf', 'doc'],
                                                );

                                        if (result != null) {
                                          article_file =
                                              File(result.files.single.path!.toString());

                                          selected_file=(article_file!.path);
                                          new_selected_file=selected_file;
                                          log('selected file $selected_file');
                                        } else {
                                          // User canceled the picker
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: width * .34,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _themeProvider
                                                    .primaryColorLight),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .02),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${gettranslated(context, "Attach File")}',
                                                  style: TextStyle(
                                                      color: _themeProvider
                                                          .primaryColorLight),
                                                ),
                                                Icon(
                                                  Icons.attachment_outlined,
                                                  color: _themeProvider
                                                      .primaryColorLight,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        width: width * .35,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _themeProvider
                                                    .primaryColorLight),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .01),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      article_file!.path
                                                          .split('/')
                                                          .last,
                                                      style: TextStyle(color: _themeProvider.primaryColorLight,
                                                          fontSize:
                                                              width * .034),
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              InkWell(
                                                  onTap: () async{
                                                    // article_file = null;
                                                    // selected_file='';
                                                    // new_selected_file='';
                                                    // setState(() {});
                                                    FilePickerResult? result =
                                                        await FilePicker.platform.pickFiles(
                                                      // type: FileType.custom,
                                                      // allowedExtensions: ['jpg', 'pdf', 'doc'],
                                                    );

                                                    if (result != null) {
                                                      article_file =
                                                          File(result.files.single.path!.toString());

                                                      selected_file=(article_file!.path);
                                                      new_selected_file=selected_file;
                                                      log('selected file $selected_file');
                                                    } else {
                                                      // User canceled the picker
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: _themeProvider
                                                        .primaryColorLight,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          custom_text('${gettranslated(context, "Article Title")}', height, _themeProvider),

                          MyTextField(
                            hinttext: '${gettranslated(context, "Article Title")}',
                            controllerValue: title_controller,
                          ),
                          custom_text(
                              '${gettranslated(context, "Enter Article Category")}', height, _themeProvider),
                          Container(
                              height: height * .05,
                              width: width * .9,
                              decoration: BoxDecoration(color: _themeProvider.backgroundColor,
                                  border: Border.all(color: _themeProvider.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                  child: DropdownButtonFormField<TicketProjects>(
                                      icon:    Icon(
                                          Icons.arrow_drop_down,
                                          color:_themeProvider.primaryColorLight.withOpacity(0.5)),
                                      dropdownColor: _themeProvider.backgroundColor,
                                      items: articleCategories.map((TicketProjects  item) {
                                        return  DropdownMenuItem(
                                            value: item, child: Text(item.name,style: TextStyle(color: _themeProvider.primaryColorLight),));
                                      }).toList(),
                                      onChanged: (TicketProjects? item) {

                                        dropdownvalue2 = item!;


                                        setState(() {});
                                      },
                                      value: dropdownvalue2,
                                      decoration: InputDecoration.collapsed(


                                        fillColor: Colors.grey[200], hintText: '${widget.article.category_name}',
                                        hintStyle: TextStyle(color: _themeProvider.primaryColorLight)

                                      )))),

                          custom_text('${gettranslated(context, "Tags")}', height, _themeProvider),


                          Container(
                            width: width*82,
                            height: height*.047,
                            child: Padding(
                              padding:  EdgeInsets.all(1),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: TextStyle(color: _themeProvider.primaryColorLight),
                                controller: tag_controller,

                                decoration: InputDecoration(fillColor:_themeProvider.textfieldColor,filled: true,
                                    contentPadding: EdgeInsets.all(5),
                                    suffixIcon: InkWell(
                                        onTap: (){
                                        if(tag_controller.text!=''){
                                          selected_tages.add('${tag_controller.text}');
                                          tag_controller.clear();
                                        }else{
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(showsnack(width,_themeProvider,"${gettranslated(context, "enter tag to add !")}",Icons.error));
                                        }
                                          setState(() {

                                          });
                                        },
                                        child: Icon(Icons.add,color: _themeProvider.primaryColorLight,size: width*.057,)),
                                    // hintText: widget.hinttext,
                                    hintStyle: TextStyle(color:_themeProvider.primaryColorLight.withOpacity(0.5)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color:_themeProvider.primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color:_themeProvider.primaryColor,
                                        ))
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .01,
                          ),

                          GridView.count(
                              shrinkWrap: true,
                              childAspectRatio: 2.1,
                              crossAxisCount: 5,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              children:
                                  List.generate(selected_tages.length, (index) {
                                return Container(
                                  width: width * .36,
                                  height: height * .05,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              _themeProvider.primaryColorLight),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .01,
                                        vertical: height * 0.001),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          selected_tages[index],
                                          style:
                                              TextStyle(fontSize: width * .030,color: _themeProvider.primaryColorLight),
                                        )),
                                        InkWell(
                                            onTap: () {
                                              selected_tages.remove(
                                                  selected_tages[index]);
                                              //if added tag added before alert
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              color: _themeProvider
                                                  .primaryColorLight,
                                              size: 17,
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              })),

                          ///////////////////////////////////////////////////////////////////////////
                          Row(
                            children: [
                              //      Expanded(child: child)
                            ],
                          ),
                          custom_text(
                              '${gettranslated(context, "Article Description")}', height, _themeProvider),

                          Center(
                            child: Container(
                              width: width * .8,
                              height: height * .22,
                              decoration: BoxDecoration(
                                  color: _themeProvider.box_description,
                                  border: Border.all(
                                      color: _themeProvider.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                style: TextStyle(
                                    color: _themeProvider.primaryColorLight),
                                keyboardType: TextInputType.multiline,
                                maxLines: 1000,
                                controller: text_controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(height * .02),
                                  labelText: '${gettranslated(context, "Enter Article Description")}',
                                  labelStyle: TextStyle(
                                      color: _themeProvider.primaryColorLight
                                          .withOpacity(0.5)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              custom_text('${gettranslated(context, "Status")}', height, _themeProvider),
                              SizedBox(
                                width: width * .04,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * .01),
                                child: Container(
                                  child: FlutterSwitch(
                                    activeText: '',
                                    inactiveText: '',
                                    width: width * .14,
                                    inactiveColor:
                                        _themeProvider.textfieldColor,
                                    activeColor: _themeProvider.primaryColor,
                                    height: height * .03,
                                    toggleColor: status == false
                                        ? _themeProvider.primaryColorLight
                                            .withOpacity(0.5)
                                        : _themeProvider.primaryColorLight,
                                    inactiveSwitchBorder: Border.all(
                                        color: _themeProvider.backgroundColor),
                                    valueFontSize: 15.0,
                                    activeSwitchBorder: Border.all(
                                        color: _themeProvider.backgroundColor),
                                    toggleSize: 17,
                                    value: status,
                                    borderRadius: 30.0,
                                    padding: 5.0,
                                    showOnOff: true,
                                    onToggle: (val) {
                                      setState(() {
                                        status = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * .03,
                              ),
                              status
                                  ? custom_text(
                                      '${gettranslated(context, "Publish")}', height, _themeProvider)
                                  : SizedBox()
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                side: BorderSide(
                                    color: _themeProvider.primaryColorLight),
                                checkColor: _themeProvider.primaryColorLight,
                                activeColor: Color(0xff8e8c8c).withOpacity(0.3),
                                value: this.isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    this.isChecked = value!;
                                  });
                                },
                              ),
                              Text("${gettranslated(context, "Privacy mode")}",
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    color: _themeProvider.primaryColorLight,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          InkWell(
                              onTap: ()async{
                             if(articleEdit.value=="false"){
                               Alertmessage(context,'${gettranslated(context,"Not have a permission")}',_themeProvider,width,height);
                             }else{
                               if(new_selected_file==''&&selected_file==''){
                                 Loader.hide();
                                 ScaffoldMessenger.of(context)
                                     .showSnackBar(showsnack(
                                     width,
                                     _themeProvider,
                                     '${gettranslated(context, "Please attach article file !")}',
                                     Icons.error));
                               }
                               else {
                                 dropdownvalue2==null?dropdownvalue2=TicketProjects(id: widget.article.category_id,name: widget.article.category_name):null;
                                 Loader.show(context,
                                     progressIndicator: CircularProgressIndicator(
                                       color: _themeProvider
                                           .primaryColorLight,));

                                 if (title_controller.text != '' &&
                                     dropdownvalue2 != null &&
                                     selected_tages.length != 0 &&
                                     text_controller.text != '') {
                                   Article article = Article(
                                       title: title_controller.text,
                                       tags: selected_tages.join(','),
                                       category_id: dropdownvalue2 == null
                                           ? widget.article.category_id
                                           : dropdownvalue2!.id,
                                       media: [],
                                       category_name: dropdownvalue2 == null
                                           ? category_controller.text
                                           : dropdownvalue2!.name,
                                       description: text_controller.text
                                       ,
                                       featureImage: "",
                                       privatemode: isChecked,
                                       status: status);
                                   var statuscode = await Admin.editArticl(
                                       widget.article.id, article,
                                       new_selected_file, new_selected_image);
                                   statuscode == 200 ? [
                                     Loader.hide(),
                                     Navigator.of(context).push(
                                         createRoute(AllArticles())),
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(showsnack(
                                         width,
                                         _themeProvider,
                                         '${gettranslated(context, "article updated successfully")}',
                                         Icons.check)),
                                   ] : [
                                     Loader.hide(),
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(showsnack(
                                         width,
                                         _themeProvider,
                                         '${gettranslated(context, "Invalid data or article name already used !")}',
                                         Icons.error))
                                   ];
                                 } else {
                                   Loader.hide();
                                   ScaffoldMessenger.of(context)
                                       .showSnackBar(showsnack(
                                       width,
                                       _themeProvider,
                                       '${gettranslated(context, "Please enter title, category, description and tags !")}',
                                       Icons.error));
                                 }
                               }
                             }
                              },

                              child: Button(title: '${gettranslated(context, "Save")}'))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

custom_text(String title, height, ThemeProvider provider) {
  return Padding(
    padding: EdgeInsets.only(bottom: height * .02, top: height * .01),
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
