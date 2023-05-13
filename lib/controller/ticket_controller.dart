import 'dart:convert';
import 'dart:developer';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:ticketing_system/model/ticket_category.dart';
import '../main.dart';
import '../model/ticket_model.dart';
import 'login_controller.dart';

class TicketController {
  static getAllTickets() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/tickets'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Ticket> tickets = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        tickets.add(
          Ticket(
              subject: data[i]['subject'] ?? '',
              status: data[i]['status'] ?? '',
              created_at_date: data[i]['dateTime'] ?? '',
              id: data[i]['id'].toString() ?? '',
              ticket_id: data[i]['ticketId'].toString()??'',
              overdue: data[i]['overduestatus']??'',
              updated_at_date: data[i]['updatedAtDate'] ?? '',
              userId: data[i]['userId'].toString() ?? '',
              attached_files: []),
        );
      }
    }

    return tickets;
  }

  static List<TicketSubCategory> ticket_sub = [];
  static List<TicketProjects> ticket_projects = [];

  static getTicketCategories() async {
    log('hii');
    final res = await http.get(
      Uri.parse('${baseUrl}api/ticket_categories'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<TicketCategory> categories = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['categories'];
      for (int i = 0; i < data.length; i++) {
        if (data[i]['subCategories'].length > 0) {
          ticket_sub = [];
          for (int j = 0; j < data[i]['subCategories'].length; j++) {
            ticket_sub.add(TicketSubCategory(
                id: data[i]['subCategories'][j]['id'].toString(),
                categoryName: data[i]['subCategories'][j]['categoryName']));
          }
        }
        if (data[i]['projects'].length > 0) {
          ticket_projects = [];
          for (int j = 0; j < data[i]['projects'].length; j++) {
            ticket_projects.add(TicketProjects(
                id: data[i]['projects'][j]['id'].toString(),
                name: data[i]['projects'][j]['name']));
          }
        }

        categories.add(TicketCategory(
            id: data[i]['id'].toString(),
            categoryName: data[i]['categoryName'],
            ticket_subcategories: ticket_sub,
            ticket_projects: ticket_projects));
        ticket_sub = [];
        ticket_projects = [];
      }
    }
    return categories;
  }

  static getTicketDetail(String ticket_id) async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/tickets/$ticket_id'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    Ticket? ticket;
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      List<String> attached_files = [];
      if (data['media'].length > 0) {
        for (int i = 0; i < data['media'].length; i++) {
          attached_files.add(data['media'][i].toString());
        }
      }
      ticket = Ticket(
          subject: data['subject'] ?? '',
          status: data['status'] ?? '',
          created_at_date: data['dateTime'] ?? '',
          id: data['id'].toString() ?? '',
          description: data['description'] ?? '',
          project : data['project']==null?'':data['project']['name']??'',
          category: data['category']['categoryName'] ?? '',
          ticket_id: data['ticketId'].toString()?? '',
          updated_at_date: data['updatedAtDate'] ?? '',
          sub_category: data['subCategories'] == null
              ? ''
              : data['subCategories']['categoryName'] ?? '',
          attached_files: attached_files);
    }

    return ticket;
  }

  static getMyassignTickets(bool myassign) async {
    //true: assigned to me

    final res = await http.get(
      myassign
          ? Uri.parse('${baseUrl}api/tickets?toassignuser_id=${Auth.user_id}')
          : Uri.parse('${baseUrl}api/tickets?myassignuser_id=${Auth.user_id}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Ticket> tickets = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        tickets.add(
          Ticket(
              subject: data[i]['subject'] ?? '',
              status: data[i]['status'] ?? '',
              created_at_date: data[i]['dateTime'] ?? '',
              id: data[i]['id'].toString() ?? '',
              userId: data[i]['userId'].toString() ?? '',
              attached_files: []),
        );
      }
    }

    return tickets;
  }
  static getMyTickets() async {


    final res = await http.get(Uri.parse('api/tickets?my_tickets=true'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Ticket> my_tickets = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        my_tickets.add(
          Ticket(
              subject: data[i]['subject'] ?? '',
              status: data[i]['status'] ?? '',
              created_at_date: data[i]['dateTime'] ?? '',
              id: data[i]['id'].toString() ?? '',
              userId: data[i]['userId'].toString() ?? '',
              attached_files: []),
        );
      }
    }

    return my_tickets;
  }
  static createTicket(
      {required String subject,
      required String category_id,
      required String message,
      required bool isAdmin,
      required String email,
      required String sub_category_id,
      required String project_id,
      required String file_path}) async {
    log('create ');
    try {
      var headers = {
        "Accept": "application/json",
        //  "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {
        "subject": subject,
        "category": category_id,
        "message": message,
        "isAdmin": isAdmin.toString(),
        "email": email,
        "subscategory": sub_category_id,
        "project": project_id
      };

      //size

      if (file_path == '') {
        http.MultipartRequest res =
            http.MultipartRequest('POST', Uri.parse("${baseUrl}api/tickets"))
              ..headers.addAll(headers)
              ..fields.addAll(body);
        var response = await res.send();
        log(response.statusCode.toString());
        final respStr = await response.stream.bytesToString();
        log('file $file_path');
        log('in create without file ${response.statusCode.toString()}  $respStr');
        return response.statusCode;
      } else {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'file[]', file_path,
            contentType: new MediaType('application', 'x-tar'));
        log(file_path);
        log(multipartFile.field);
        http.MultipartRequest res =
            http.MultipartRequest('POST', Uri.parse("${baseUrl}api/tickets"))
              ..headers.addAll(headers)
              ..fields.addAll(body);
        // ..
        // files.add(multipartFile);
        res.files.add(multipartFile);
        var response = await res.send();
        log(response.statusCode.toString());
        final respStr = await response.stream.bytesToString();
        log('in create with file${response.statusCode.toString()}  $respStr');
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
