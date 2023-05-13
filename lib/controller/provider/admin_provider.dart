
import 'package:flutter/material.dart';

import '../../model/ticket_model.dart';
class AdminProvider extends ChangeNotifier{
  bool admin=false;
  List <Ticket> tickets=[];
  List <Ticket> myAssigntickets=[];
  List <Ticket> assigntickets=[];
  List <Ticket> my_tickets=[];
  bool loadedAllTickets=false;
  String user_image='';
  String notificationlength='0';
  String permission="";
  String allTicketspermission="";
  String assignedTicketspermission="";
  String myAssignedTicketspermission="";
  String myTicketspermission="";
  String onholdTicketspermission="";
  String overdueTicketspermission="";
  setTicketPermissions({ allTicketsp,
   assignedTicketsp,
   myAssignedTicketsp,
   myTicketsp,
   onholdTicketsp,
   overdueTicketsp,
   closedTicketsp}){
   allTicketspermission=allTicketsp;
   assignedTicketspermission=assignedTicketsp;
   myAssignedTicketspermission=myAssignedTicketsp;
   myTicketspermission=myTicketsp;
   onholdTicketspermission=onholdTicketsp;
   overdueTicketspermission=overdueTicketsp;
   notifyListeners();
  }
  setPermission(String p){
    permission=p;
    notifyListeners();
  }
  setNotificationLength(String unreadlength){
    notificationlength=unreadlength;
    notifyListeners();
  }
  setuserImage(String image){
    user_image=image;
    notifyListeners();
  }
  setLOadedTickets(bool loaded){
    this.loadedAllTickets=loaded;
    notifyListeners();
  }
  setAdmin(bool status){
  this.admin=status;
    notifyListeners();
  }
  setTickets(List<Ticket> ticketss){
    this.tickets=ticketss;
    notifyListeners();
  }
  setCustomTickets({required List<Ticket> myassign,required List<Ticket>  assign,required List<Ticket> myTickets}){
    this.myAssigntickets=myassign;
    this.assigntickets=assign;
    this.my_tickets=myTickets;
    notifyListeners();
  }

}