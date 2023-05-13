import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:ticketing_system/main.dart';
import 'package:ticketing_system/model/dashboard_model.dart';
import 'package:ticketing_system/model/notification_model.dart';
import 'package:ticketing_system/model/user_model.dart';
import '../view/widgets/drawer.dart';
import 'login_controller.dart';

class User {
  static getProfileData() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/profile'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    UserModel? user;
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];

      user = UserModel(
        id: data['id'].toString(),
        fristName: data['fristName'].toString(),
        lastName: data['lastName'].toString(),
        empId: data['empId'].toString(),
        gender: data['gender'].toString(),
        provider_id: data['provider_id'].toString(),
        email: data['email'].toString(),
        phone: data['phone'].toString(),
        skills: data['skills'].toString(),
        status: data['status'],
        image: data['image'].toString(),
        verified: data['verified'],
        country: data['country'].toString(),
        timezone: data['timezone'].toString(),
        darkmode: data['darkmode'],
      );
    }

    return user;
  }

  static update_profile(
      {required String fname,
      required String lastname,
      required String email,
      required String phone,
      required String country,
      required String timezone}) async {
    var res = await http.put(
      Uri.parse("${baseUrl}api/profile"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: {
        "firstName": fname,
        "lastName": lastname,
        "email": email,
        "phone": phone,
        "country": country,
        "timezone": timezone
      },
    );
    return res.statusCode;
  }

  static String err_password = 'no';

  static change_password({
    required String oldpassword,
    required String newpassword,
    required String confirmpassword,
  }) async {
    err_password = 'no';
    var res = await http.put(
      Uri.parse("${baseUrl}api/change_password"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: {
        "current_password": oldpassword,
        "password": newpassword,
        "password_confirmation": confirmpassword
      },
    );
    if (res.statusCode == 200 && res.body.contains('message')) {
      err_password = 'success';
    }
    return res.statusCode;
  }

  static getusernotification() async {
    //also admin

    final res = await http.get(
      Uri.parse('${baseUrl}api/my_notifications'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<NotificationModel> notifications = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['notifications'];
      for (int i = 0; i < data.length; i++) {
        notifications.add(NotificationModel(
            id: data[i]['id'].toString(),
            type: data[i]['type'],
            notifiable_type: data[i]['notifiable_type'],
            notifiable_id: data[i]['notifiable_id'].toString(),
            ticket_id: data[i]['data']['ticket_id'].toString(),
            title: data[i]['data']['title'],
            category: data[i]['text'],
            status: data[i]['data']['status'],
            created_at: data[i]['created_at'],
            updated_at: data[i]['updated_at'],
        readAt: data[i]['read_at']==null?null:data[i]['read_at']),
        );
      }

      return notifications;
    }
  }

  static deactive_account() async {
    var res = await http.put(
      Uri.parse("${baseUrl}api/account/deactivate"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    return res.statusCode;
  }

  static bool expired_token = false;

  static changeUserImage(
      {required String file_path}) async {
    try {
      var headers = {
        "Accept": "application/json",
        //  "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      };


        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'image', file_path,
            contentType: new MediaType('application', 'x-tar'));
        http.MultipartRequest res = http.MultipartRequest(
            'POST', Uri.parse("${baseUrl}api/update_profile_image"))
          ..headers.addAll(headers);
        res.files.add(multipartFile);
        var response = await res.send();

        final respStr = await response.stream.bytesToString();
        log('${response.statusCode}   $respStr');
        if(response.statusCode==200){
         log('${jsonDecode(respStr)['imagePath']}');
         return jsonDecode(respStr)['imagePath'];
        }else {
          return response.statusCode;
        }
    } catch (e) {

    }
  }
  static getTicketsNumberDahboard() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/tickets_numbers'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );

    DashboardModel dashboardModel = DashboardModel(
        allTicketsCount: 0,
        activeTicketsCount: 0,
        closedTicketsCount: 0,
        assignedTicketsCount: 0,
        myAssignedTicketsCount: 0,
        myTicketsCount: 0,
        onHoldTicketsCount: 0,
        overdueTicketsCount: 0);
    var resbody = json.decode(res.body);
    res.statusCode == 401 ? expired_token = true : expired_token = false;
    if (res.statusCode == 200) {
      dashboardModel = DashboardModel(
          allTicketsCount: resbody['allTicketsCount'] ?? 0,
          activeTicketsCount: resbody['activeTicketsCount'] ?? 0,
          closedTicketsCount: resbody['closedTicketsCount'] ?? 0,
          assignedTicketsCount: resbody['assignedTicketsCount'] ?? 0,
          myAssignedTicketsCount: resbody['myAssignedTicketsCount'] ?? 0,
          myTicketsCount: resbody['myTicketsCount'] ?? 0,
          onHoldTicketsCount: resbody['onHoldTicketsCount'] ?? 0,
          overdueTicketsCount: resbody['overdueTicketsCount'] ?? 0);
    }

    return dashboardModel;
  }
  static getTicketStatusFilter() async {
    //also admin

    final res = await http.get(
      Uri.parse('${baseUrl}api/statuses'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<String> status = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['statuses'];
      for (int i = 0; i < data.length; i++) {
    status.add(data[i]['name']);
      }

      return status;
    }
  }
  static getTicketStatusFilterformessage() async {


    final res = await http.get(
      Uri.parse('${baseUrl}api/messages_statuses'),
      headers: {
        "Accept": "application/json",
         "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<String> status = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['statuses'];
      for (int i = 0; i < data.length; i++) {
        status.add(data[i]['name']);
      }

      return status;
    }
  }
  static getUnreadableNotificationLength() async {

    final res = await http.get(
      Uri.parse('${baseUrl}api/my_notifications_count'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    String length;
    if (res.statusCode == 200) {

     length= json.decode(res.body)['notifications_count'].toString();


      return length;
    }
  }
  static readNotification(String id) async {

    try {
      var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token_main"
      };
  var body={
    "id":id
      };

      http.MultipartRequest res = http.MultipartRequest(
          'POST', Uri.parse("${baseUrl}api/read_notification"))
        ..headers.addAll(headers)..fields.addAll(body);
      var response = await res.send();

      final respStr = await response.stream.bytesToString();
      log('${response.statusCode}   $respStr');
      return response.statusCode;
    } catch (e) {

    }
  }
  static getPermissions() async {


    final res = await http.get(
      Uri.parse('${baseUrl}api/my_permissions'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Map<String,String>> permissions=[];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['myPermissions'];
      for (int i = 0; i < data.length; i++) {
        permissions.add({"name":"${data[i]['name']}","status":"${data[i]['status']}","index":"$i"});
      }
      articleAccess_get.value=(permissions[10]['status']!);
      articleCreate.value=(permissions[11]['status']!);
      articleEdit.value=(permissions[13]['status']!);
      articleView.value=(permissions[14]['status']!);
      cannedResponseAccess.value=(permissions[18]['status']!);
      cannedResponseCreate.value=(permissions[19]['status']!);
      cannedResponseEdit.value=(permissions[21]['status']!);
      customersAccess.value=(permissions[37]['status']!);
      customersCreate.value=(permissions[38]['status']!);
      customersEdit.value=(permissions[40]['status']!);
      employeeAccess.value=(permissions[47]['status']!);
      employeeCreate.value=(permissions[48]['status']!);
      employeeEdit.value=(permissions[50]['status']!);
      groupsAccess.value=(permissions[65]['status']!);
      groupsCreat.value=(permissions[66]['status']!);
      groupsEdit.value=(permissions[67]['status']!);
      profileEdit.value=(permissions[86]['status']!);
      projectAccess.value=(permissions[87]['status']!);
      projectAssign.value=(permissions[88]['status']!);
      ticketcreate.value=(permissions[110]['status']!);
      ticketAccess.value=(permissions[108]['status']!);
      allTicketsv.value=(permissions[2]['status']!);
      assignedTicketsv.value=(permissions[15]['status']!);
      myAssignedTicketsv.value=(permissions[77]['status']!);
      myTicketsv.value=(permissions[78]['status']!);
      onholdTicketsv.value=(permissions[79]['status']!);
      overdueTicketsv.value=(permissions[80]['status']!);
      ticketEdit.value=(permissions[112]['status']!);
      customNotificationsAccess.value=(permissions[31]['status']!);
      closedTickets.value=(permissions[28]['status']!);
      return permissions;
    }
  }
  static getVersion() async {

    final res = await http.get(
      Uri.parse('${baseUrl}api/version'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    String length;
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['version'];

      version_app.value =data;
    }
  }
}

ValueNotifier<String> articleAccess_get= ValueNotifier<String>("");
ValueNotifier<String> articleCreate= ValueNotifier<String>("");
ValueNotifier<String> articleEdit= ValueNotifier<String>("");
ValueNotifier<String> articleView= ValueNotifier<String>("");
ValueNotifier<String> cannedResponseAccess= ValueNotifier<String>("");
ValueNotifier<String> cannedResponseCreate= ValueNotifier<String>("");
ValueNotifier<String> cannedResponseEdit= ValueNotifier<String>("");
ValueNotifier<String> customersAccess= ValueNotifier<String>("");
ValueNotifier<String> customersCreate= ValueNotifier<String>("");
ValueNotifier<String> customersEdit= ValueNotifier<String>("");
ValueNotifier<String> employeeAccess= ValueNotifier<String>("");
ValueNotifier<String> employeeCreate= ValueNotifier<String>("");
ValueNotifier<String> employeeEdit= ValueNotifier<String>("");
ValueNotifier<String> groupsAccess= ValueNotifier<String>("");
ValueNotifier<String> groupsCreat= ValueNotifier<String>("");
ValueNotifier<String> groupsEdit= ValueNotifier<String>("");
ValueNotifier<String> profileEdit= ValueNotifier<String>("");
ValueNotifier<String> projectAccess= ValueNotifier<String>("");
ValueNotifier<String> projectAssign= ValueNotifier<String>("");
ValueNotifier<String> ticketcreate= ValueNotifier<String>("");
ValueNotifier<String> ticketAccess= ValueNotifier<String>("");
ValueNotifier<String> allTicketsv= ValueNotifier<String>("");
ValueNotifier<String> assignedTicketsv= ValueNotifier<String>("");
ValueNotifier<String> myAssignedTicketsv= ValueNotifier<String>("");
ValueNotifier<String> myTicketsv= ValueNotifier<String>("");
ValueNotifier<String> onholdTicketsv= ValueNotifier<String>("");
ValueNotifier<String> overdueTicketsv= ValueNotifier<String>("");
ValueNotifier<String> ticketEdit= ValueNotifier<String>("");
ValueNotifier<String> customNotificationsAccess= ValueNotifier<String>("");
ValueNotifier<String> closedTickets= ValueNotifier<String>("");
