import 'package:flutter/material.dart';


class NotificationModel{
  String id;
  String type;
  String notifiable_type;
  String notifiable_id;
 String ticket_id;
  String title;
  String category;
  String status;
  String? overduestatus;
  String? read_at;
  String created_at;
  String updated_at;
  String? readAt;

  NotificationModel({required this.id,
  required this.type,
  required this.notifiable_type,
  required this. notifiable_id,
  required this. ticket_id,
  required this. title,
  required this. category,
  required this. status,
   this. overduestatus='',
   this. read_at='',
  required this. created_at,
  required this. updated_at,required this.readAt});
}