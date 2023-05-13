


class Customer{
  String id;
  String date;
  String userType;
  String first_name;
  String last_name;
  String password;
  String mobile_number;
  String email;
  String userName;
  String country;
  String timezone;



  Customer({this.id='',required this.date,required this.userType,required this.first_name,required this.last_name,
    required this.password,required this.mobile_number,required this.email,this.userName='',this.country='',this.timezone=''});
}