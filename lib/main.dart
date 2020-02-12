import 'package:flutter/material.dart';

import 'about.dart';
import 'auth.dart';
import 'calendar.dart';
import 'contacts.dart';
import 'events.dart';
import 'settings.dart';

//Pages

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('')),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('vārds'),
              accountEmail: new Text('email'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            new ListTile(
              title: new Text('Kalendārs'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new CalendarPage()));
              },
            ),
            new ListTile(
              title: new Text('Notikumi'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new EventsPage()));
              },
            ),
            new ListTile(
              title: new Text('Kontakti'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ContactsPage()));
              },
            ),
            new ListTile(
              title: new Text('Autorizeties'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AuthPage()));
              },
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
            new ListTile(
              title: new Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new SettingsPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

//rest api

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: EmployeePage(),
    );
  }


class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter REST API'),
      ),
      body: FutureBuilder(
        future: ApiService.getEmployees(),
        builder: (context, snapshot) {
          final employees = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 2,
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(employees[index]['employee_kurss']),
                  subtitle: Text('kursa_kods: ${employees[index]['employee_kursa_kods']}'),
                );
              },
              itemCount: employees.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewEmployeePage(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNewEmployeePage extends StatefulWidget {
  AddNewEmployeePage({Key key}) : super(key: key);

  _AddNewEmployeePageState createState() => _AddNewEmployeePageState();
}

class _AddNewEmployeePageState extends State<AddNewEmployeePage> {
  final _employeeNameController = TextEditingController();
  final _employeeAge = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Employee'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _employeeNameController,
                decoration: InputDecoration(hintText: 'Employee kurss'),
              ),
              TextField(
                controller: _employeeAge,
                decoration: InputDecoration(hintText: 'Employee kursa_kods'),
                keyboardType: TextInputType.number,
              ),
              RaisedButton(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () {
                  final body = {
                    "kurss": _employeeNameController.text,
                    "kursa_kods": _employeeAge.text,
                  };
                  ApiService.addEmployee(body).then((success) {
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Employee has been added!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _employeeNameController.text = '';
                                _employeeAge.text = '';
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }else{
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Error Adding Employee!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}