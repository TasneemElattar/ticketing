class UserModel{
 String id;
 String? fristName;
 String? lastName;
 String? empId;
 String? gender ;
 String? provider_id ;
 String? email ;
 String?  phone ;
 String?  skills ;
 String? status ; //active 1 /deactive 0
 String?  image ;
 int? verified ;
 String? country ;
 String? timezone ;
 int? darkmode ;
 UserModel({
   required this. id,
   required this. fristName,
   required this. lastName,
   required this. empId,
   required this. gender ,
   required this. provider_id ,
   required this. email ,
   required this.  phone ,
   required this.  skills ,
   required this. status ,
   required this.  image ,
   required this. verified ,
   required this.country ,
   required this. timezone ,
   required this. darkmode
});

}