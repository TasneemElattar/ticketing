
class MessageModel{
  String id;
  String message;
  String messageOwner;
  String date;
 String  tickedId;
  String? customerId;
  String? userId;
  List<String> media;
  MessageModel({this.id='',required this.message,required this.date,required this.messageOwner,this.tickedId='',this.customerId,this.userId,required this.media});

}