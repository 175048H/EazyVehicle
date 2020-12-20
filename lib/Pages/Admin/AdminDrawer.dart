import 'package:LogisticMngt/Models/Users.dart';
import 'package:LogisticMngt/Pages/Admin/AdminDashboard.dart';
import 'package:LogisticMngt/Pages/Login.dart';
import 'package:LogisticMngt/Pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  clearPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear().then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage(Users()))));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purple[900], Colors.blue[200]],
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                // Text(
                //   'Welcome..',
                //   style: TextStyle(fontSize: 22.0, color: Colors.white),
                // ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: Icon(Icons.dashboard, color: Colors.blue[300]),
            trailing: Icon(Icons.arrow_right),
            title: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.purple[900],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminDashBoard()));
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blue[300],
            ),
            trailing: Icon(Icons.arrow_right),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.purple[900],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.blue[300],
            ),
            trailing: Icon(Icons.arrow_right),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.purple[900],
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              _displayDialog();
            },
          ),
        )
      ],
    ));
  }

  _displayDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              ('Are your sure want to log out?'),
              style: TextStyle(color: Colors.grey[700], fontSize: 18),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'Yes',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  clearPref();
                },
              ),
              new FlatButton(
                child: new Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
