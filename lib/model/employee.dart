


class Employee{
  String id;
  String date;
  String first_name;
  String last_name;
  String gender;
  String emp_id;
  String provider_id;
  String role;
  String password;
  String mobile_number;
  String email;
  String skills;
  String status; //'1':'0'
  String image;
  String verified; //'1/0
  String country;
  String timezone;

  Employee({this.id='',required this.date,required this.first_name,required this.last_name, this.gender='',
     this.emp_id='', this.provider_id='',
    required this.role,required this.password, this.mobile_number='',required this.email, this.skills='',
    required this.status, this.image='',required this.verified,required this.country,required this.timezone});


}