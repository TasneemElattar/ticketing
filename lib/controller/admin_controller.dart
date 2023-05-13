import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ticketing_system/model/article_model.dart';
import 'package:ticketing_system/model/canned_res_model.dart';
import 'package:ticketing_system/model/message_model.dart';
import 'package:ticketing_system/model/ticket_category.dart';
import '../main.dart';
import '../model/customer_model.dart';
import '../model/employee.dart';
import '../model/group_model.dart';
import '../model/project_model.dart';
import 'login_controller.dart';
import 'package:http_parser/http_parser.dart';

class Admin {
  static getAllTEmployees() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/employees'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Employee> employees = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        employees.add(Employee(
            id: data[i]['id'].toString(),
            date: data[i]['date'] ?? '',
            first_name: data[i]['fristName'] ?? '',
            last_name: data[i]['lastName'] ?? '',
            role: data[i]['role']['name'] ?? '',
            password: data[i]['password'] ?? '',
            emp_id: data[i]['empId'] ?? '',
            gender: data[i]['gender'] ?? '',
            provider_id: data[i]['provider_id'].toString() ?? '',
            mobile_number: data[i]['phone'].toString() ?? '',
            skills: data[i]['skills'] ?? '',
            image: data[i]['image'] ?? '',
            email: data[i]['email'] ?? '',
            status: data[i]['status'] ?? '',
            verified: data[i]['verified'].toString() ?? '',
            country: data[i]['country'] ?? '',
            timezone: data[i]['timezone'] ?? ''));
      }
    }

    return employees;
  }

  static addEmployee(Employee employee) async {
    var res = await http.post(
      Uri.parse("${baseUrl}api/employees"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: jsonEncode({
        "firstName": employee.first_name,
        "lastName": employee.last_name,
        "email": employee.email,
        "phone": employee.mobile_number,
        "country": employee.country,
        "timezone": employee.timezone,
        "empid": employee.emp_id,
        "role": employee.role,
        "skills": employee.skills,
        "password": employee.password
      }),
    );
    return res.statusCode;
  }

  static editEmployee(Employee employee) async {
    var res = await http.put(
      Uri.parse("${baseUrl}api/employees/${employee.id}"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: jsonEncode({
        "firstName": employee.first_name,
        "lastName": employee.last_name,
        "email": employee.email,
        "phone": employee.mobile_number,
        "country": employee.country,
        "timezone": employee.timezone,
        "empid": employee.emp_id,
        "role": employee.role,
        "skills": employee.skills,
        "password": employee.password,
        "status": 1
      }),
    );
    return res.statusCode;
  }

  static getempRoles() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/roles'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<String> roles = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        roles.add(data[i]['name']);
      }
    }

    return roles;
  }

  static getAllTCustomers() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/customers'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Customer> customers = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        customers.add(Customer(userName: data[i]['userName'].toString(),
            id: data[i]['id'].toString(),
            date: data[i]['dateTime'] ?? '',
            userType: data[i]['userType'] ?? '',
            first_name: data[i]['fristName'] ?? '',
            last_name: data[i]['lastName'] ?? '',
            country: data[i]['country'] ?? '',
            timezone: data[i]['timezone'] ?? '',
            password: data[i]['password'] ?? '',
            mobile_number: data[i]['phone'] ?? '',
            email: data[i]['email'] ?? ''));
      }
    }

    return customers;
  }

  static addCustomer(Customer customer) async {
    var res = await http.post(
      Uri.parse("${baseUrl}api/customers"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: jsonEncode({
        "firstName": customer.first_name,
        "lastName": customer.last_name,
        "email": customer.email,
        "phone": customer.mobile_number,
        "password": customer.password,
        "country": customer.country,
        "timezone": customer.timezone,
      }),
    );
    return res.statusCode;
  }

  static editCustomer(Customer customer) async {
    var res = await http.put(
      Uri.parse("${baseUrl}api/customers/${customer.id}"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: jsonEncode({
        "firstName": customer.first_name,
        "lastName": customer.last_name,
        "email": customer.email,
        "phone": customer.mobile_number,
        "password": customer.password,
        "country": customer.country,
        "timezone": customer.timezone,
        "status": 1
      }),
    );
    return res.statusCode;
  }

  static getAllProjects() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/projects'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Project> projects = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        projects.add(Project(
          id: data[i]['id'].toString(),
          name: data[i]['name'] ?? '',
        ));
      }
    }

    return projects;
  }

  static assignProject(
      {required String project_id, required String category_id}) async {
    try {
      var headers = {
        "Accept": "application/json",
        //  "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {
        "project_id[]": project_id,
        "category_id[]": category_id
        // "status": ticket_status,
      };

      http.MultipartRequest res = http.MultipartRequest(
          'POST', Uri.parse("${baseUrl}api/assign_projects"))
        ..headers.addAll(headers)
        ..fields.addAll(body);
      var response = await res.send();
      log(response.statusCode.toString());
      final respStr = await response.stream.bytesToString();
      return response.statusCode;
    } catch (e) {
      log('error ${e.toString()}');
    }
  }

  static getGroups() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/groups'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<GroupModel> groups = [];
    List<EmployeeGroup> employees = [];
    String employeeLength = '0';
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        if (data[i]['members'].length > 0) {
          for (int j = 0; j < data[i]['members'].length; j++) {
            employees.add(EmployeeGroup(
                id: data[i]['members'][j]['id'].toString(),
                fname: data[i]['members'][j]['firstname'] ?? '',
                lname: data[i]['members'][j]['lastname'] ?? ''));
          }
        }

        groups.add(GroupModel(
            id: data[i]['id'].toString(),
            group_name: data[i]['name'],
            no_of_members: employees.length,
            created_at: data[i]['dateTime'],
            employess: employees));
        employees = [];
      }
    }

    return groups;
  }

  static addGroup(String groupname, List<Employee> employees) async {
    try {
      var headers = {
        "Accept": "application/json",
        //  "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {"groupname": groupname};
      if (employees.length > 0) {
        for (int i = 0; i < employees.length; i++) {
          body.addAll({"user_id[$i]": employees[i].id});
        }
      }
      http.MultipartRequest res =
          http.MultipartRequest('POST', Uri.parse("${baseUrl}api/groups"))
            ..headers.addAll(headers)
            ..fields.addAll(body);
      var response = await res.send();
      final respStr = await response.stream.bytesToString();
      return response.statusCode;
    } catch (e) {
      log(e.toString());
    }
  }

  static editGroup(
      String groupname, List<Employee> employees, String group_id) async {
    try {
      var headers = {
        "Accept": "application/json",

        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {"groupname": groupname, "_method": "put"};

      if (employees.length > 0) {
        for (int i = 0; i < employees.length; i++) {
          body.addAll({"user_id[$i]": employees[i].id});
        }
      }

      log('body ${body.toString()}');
      http.MultipartRequest res = http.MultipartRequest(
          'POST', Uri.parse("${baseUrl}api/groups/${group_id}"))
        ..headers.addAll(headers)
        ..fields.addAll(body)
        ..fields.addAll(body);
      var response = await res.send();
      final respStr = await response.stream.bytesToString();
      log('reeee update ${response.statusCode.toString()}   $respStr}');
      return response.statusCode;
    } catch (e) {
      log(e.toString());
    }
  }

  static getAllCanned() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/cannedResponses'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<CannedResponse> cannedResponses = [];

    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        cannedResponses.add(CannedResponse(
            id: data[i]['id'].toString(),
            title: data[i]['title'],
            message: data[i]['message'],
            status: data[i]['status'] == 1 ? true : false));
      }
    }
    return cannedResponses;
  }

  static addCannedRes(CannedResponse cannedResponse) async {
    var res = await http.post(
      Uri.parse("${baseUrl}api/admin/cannedmessages/create"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: jsonEncode({
        "title": cannedResponse.title,
        "message": cannedResponse.message,
        "statuscanned": cannedResponse.status ? 1 : 0
      }),
    );
    return res.statusCode;
  }

  static editCannedRes(CannedResponse cannedResponse) async {
    var res = await http.put(
      Uri.parse("${baseUrl}api/admin/cannedmessages/${cannedResponse.id}"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
      body: jsonEncode({
        "title": cannedResponse.title,
        "message": cannedResponse.message,
        "statuscanned": cannedResponse.status ? 1 : 0
      }),
    );
    return res.statusCode;
  }

  static getAllMessages(String ticket_id) async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/tickets/${ticket_id}/messages'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    log('in get messages');
    List<MessageModel> messages = [];

    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      List<String> media=[];
      for (int i = 0; i < data.length; i++) {
       if(data[i]['media'].length>0){
         for(int j=0;j<data[i]['media'].length;j++){
       media.add(data[i]['media'][j]);
         }
       }
        messages.add(MessageModel(
            message: data[i]['message'],
            date: data[i]['DateTime'],
            messageOwner: data[i]['messageOwner'],
            id: data[i]['id'].toString(),
            tickedId: data[i]['tickedId'].toString(),
            userId:
                data[i]['userId'] == null ? null : data[i]['userId'].toString(),
            customerId: data[i]['customerId'] == null
                ? null
                : data[i]['customerId'].toString(),media: media));
       media=[];
      }
    }
    return messages;
  }

  static sendMessage(
      {required String file_path,
      required String ticket_id,
      required String message,
      required String ticket_status}) async {
    try {
      var headers = {
        "Accept": "application/json",
        //  "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {
        "comment": message,

      };
      ticket_status==''?null:body.addAll( {   "status": ticket_status});
      if (file_path == '') {
        http.MultipartRequest res = http.MultipartRequest(
            'POST', Uri.parse("${baseUrl}api/tickets/${ticket_id}/messages"))
          ..headers.addAll(headers)
          ..fields.addAll(body);
        var response = await res.send();
        final respStr = await response.stream.bytesToString();
        return response.statusCode;
      } else {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'file[]', file_path,
            contentType: new MediaType('application', 'x-tar'));
        http.MultipartRequest res = http.MultipartRequest(
            'POST', Uri.parse("${baseUrl}api/tickets/${ticket_id}/messages"))
          ..headers.addAll(headers)
          ..fields.addAll(body);
        res.files.add(multipartFile);
        var response = await res.send();
        log(response.statusCode.toString());
        final respStr = await response.stream.bytesToString();
        return response.statusCode;
      }
    } catch (e) {
      log('error ${e.toString()}');
    }
  }

  static getprojectCategories() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/admin/projects_categories'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<TicketProjects> categories = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        categories.add(TicketProjects(
            id: data[i]['id'].toString(), name: data[i]['categoryName']));
      }
    }
    return categories;
  }
  static getArticleCategories() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/admin/articles_categories'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<TicketProjects> categories = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      for (int i = 0; i < data.length; i++) {
        categories.add(TicketProjects(
            id: data[i]['id'].toString(), name: data[i]['categoryName']));
      }
    }
    return categories;
  }

  static getAllArticles() async {
    final res = await http.get(
      Uri.parse('${baseUrl}api/admin/articles'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token_main"
      },
    );
    List<Article> articles = [];
    if (res.statusCode == 200) {
      var data = json.decode(res.body)['data'];
      List<String> attached_files = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i]['media'].length > 0) {
          for (int j = 0; j < data[i]['media'].length; j++) {
            attached_files.add(data[i]['media'][j].toString());

          }
        }

        articles.add(Article(
           description: data[i]['description'],
            id: data[i]['id'].toString(),
            title: data[i]['title'],
            tags: data[i]['tags'] = data[i]['tags'],
            category_id: data[i]['category']['id'].toString(),
            media: attached_files,
            privatemode: data[i]['privatemode'] == 1 ? true : false,
            status: data[i]['status'] == 'Published' ? true : false,
            category_name: data[i]['category']['name'],
            featureImage: data[i]['featureImage'] ?? ''));
        attached_files = [];
      }
    }
    return articles;
  }

  static editArticl( String id, Article article,file,image) async {
    try {
      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {
          "_method": "put",
        "title": article.title,
        "category": article.category_id,
        "message": article.description,
         "privatemode":article.privatemode?"1":"0",
        "tags": article.tags,
        "status": article.status?"Published":"UnPublished"
      };

      http.MultipartRequest res = http.MultipartRequest(
          'POST', Uri.parse("${baseUrl}api/admin/articles/${id}"))
        ..headers.addAll(headers)
        ..fields.addAll(body);

      if (image != '') {
        http.MultipartFile multipartFile2 = await http.MultipartFile.fromPath(
            'featureimage', image,
            contentType: new MediaType('application', 'x-tar'));

        res.files.add(multipartFile2);
      }
      if (file != '') {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'article', file,
            contentType: new MediaType('application', 'x-tar'));
        res.files.add(multipartFile);
      }

      var response = await res.send();
      return response.statusCode;

    } catch (e) {
      log('error ${e.toString()}');
    }
  }
  static AddArticl(  Article article,file,image) async {
    try {
      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token_main"
      };
      Map<String, String> body = {
        "title": article.title,
        "category": article.category_id,
        "message": article.description,
        "privatemode":article.privatemode?"1":"0",
        "tags": article.tags,
        "status": article.status?"Published":"UnPublished"
      };

      http.MultipartRequest res = http.MultipartRequest(
          'POST', Uri.parse("${baseUrl}api/admin/articles"))
        ..headers.addAll(headers)
        ..fields.addAll(body);

      if (image != '') {
        http.MultipartFile multipartFile2 = await http.MultipartFile.fromPath(
            'featureimage', image,
            contentType: new MediaType('application', 'x-tar'));

        res.files.add(multipartFile2);
      }
      if (file != '') {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'article', file,
            contentType: new MediaType('application', 'x-tar'));
        res.files.add(multipartFile);
      }

      var response = await res.send();
      var s=await response.stream.bytesToString();
      log('${response.statusCode}  ${s}');
      return response.statusCode;

    } catch (e) {
      log('error ${e.toString()}');
    }
  }
}
