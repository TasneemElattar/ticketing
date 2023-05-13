
import 'package:image_picker/image_picker.dart';


class Article{
  String id;
  String title;
  String description;
  String category_id;
  String category_name;
 String tags;
  String   featureImage ;
  bool status;
  bool privatemode;
  List<String> media;
  Article({this.id='',required this.title,required this.tags,required this.category_id,required this.media,required this.description,
   required this.category_name,required this.featureImage,this.status=false,this.privatemode=false});
}