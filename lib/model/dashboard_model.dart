class DashboardModel{

 int  allTicketsCount;
 int  activeTicketsCount;
 int closedTicketsCount;
 int assignedTicketsCount;
 int myAssignedTicketsCount;
 int myTicketsCount;
 int onHoldTicketsCount;
 int overdueTicketsCount;

  DashboardModel({this.allTicketsCount=0,this.activeTicketsCount=0,this.closedTicketsCount=0,
  this.assignedTicketsCount=0,this.myAssignedTicketsCount=0,this.myTicketsCount=0,this.onHoldTicketsCount=0,
  this.overdueTicketsCount=0});
}