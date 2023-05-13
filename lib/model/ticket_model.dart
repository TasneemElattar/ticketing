import 'package:flutter/material.dart';


class Ticket{
  String id;
  String userId;
  String subject;
  String status;
  String created_at_date;
  String description;
  String? category;
  String ticket_id;
  String? sub_category;
  String? project;
  String updated_at_date;
  String? overdue;
  List<String> attached_files;
  Ticket({this.id='',this.userId='',required this.subject,required this.status,
    this.description='',this.ticket_id='',
    required this.created_at_date,this.category=null,this.sub_category='',this.project=null,this.updated_at_date='',this.overdue=null,required this.attached_files});
}