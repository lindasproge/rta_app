import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => new _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Events Page'),
      ),
    );
  }
}

class URLS {
  static const String BASE_URL = 'http://vis.rta.lv/service/roomschedule/test';
}

class ApiService {
  static Future<List<dynamic>> getEmployees() async {
    // RESPONSE JSON :
    // [{
    //   "id": "1",
    //   "employee_name": "",
    //   "employee_salary": "0",
    //   "employee_age": "0",
    //   "profile_image": ""
    // }]
    final response = await http.get('${URLS.BASE_URL}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> addEmployee(body) async {
    // BODY
    // {
    //   "name": "test",
    //   "age": "23"
    // }
    final response = await http.post('${URLS.BASE_URL}/create', body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}