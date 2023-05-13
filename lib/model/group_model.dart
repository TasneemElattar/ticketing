class GroupModel{
  String id;
  String group_name;
  int no_of_members;
  List<EmployeeGroup> employess;
  String created_at;
  GroupModel({ this.id='',required this.group_name,required this.no_of_members, this.created_at='',required this.employess});
}

class EmployeeGroup{
  String id;
  String fname;
  String lname;
  EmployeeGroup({required this.id,required this.fname,required this.lname});
}