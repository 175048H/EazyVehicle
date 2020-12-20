import 'dart:convert';

import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:LogisticMngt/Models/Users.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Users users;
  LoginPage(this.users);
  @override
  _LoginPageState createState() => _LoginPageState(users);
}

class _LoginPageState extends State<LoginPage> {
  Users _users;
  Users userdata;

  _LoginPageState(this._users);

  bool isLoading = false;
  bool password = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[900], Colors.blue[200]],
          ),
        ),
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitRipple(
                      color: Colors.white,
                      size: 90,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Please wait a moment...',
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  child: ListView(
                    children: [
                      SizedBox(height: 60.0),
                      _expandeContainer(context)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _imageContainer() {
    return Container(
      height: 130.0,
      width: 130.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logo.png'),
        ),
      ),
    );
  }

  Widget _expandeContainer(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _imageContainer(),
        SizedBox(height: 60.0),
        _usernameField(),
        _passwordField(),
        _loginBtn(context),
        _signUpText(context),
      ],
    ));
  }

  Widget _usernameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _users.userName = _userNamecontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter username';
          } else if (value.length < 7 || value.length > 25) {
            return 'Please enter valid username';
          }
          return null;
        },
        controller: _userNamecontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.person,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50),
      child: TextFormField(
        onChanged: (value) {
          _users.password = _passwordcontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter password';
          } else if (value.length < 9 || value.length > 25) {
            return 'Please enter valid password';
          }
          return null;
        },
        obscureText: password,
        controller: _passwordcontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.lock,
              color: Colors.white54,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                password = !password;
              });
            },
            child: Icon(
              Icons.remove_red_eye,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _loginBtn(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Register'),
      child: Padding(
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Container(
          width: 257,
          decoration: BoxDecoration(color: Colors.white),
          child: FlatButton(
              child: Text(
                'LOG IN',
                style: TextStyle(
                  color: Colors.purple[800],
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  loginUser();
                }
              }),
        ),
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Register'),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                color: Colors.white70,
              ),
              children: [
                TextSpan(
                  text: 'SIGN UP',
                  style: TextStyle(
                      letterSpacing: 1.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    var res = await APIServices.loginUser(_users);

    var decodeRes = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (decodeRes == ('Invalid Username or password')) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          icon: Icon(
            Icons.warning_outlined,
            color: Colors.amberAccent,
          ),
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.blue[200],
          titleText:
              Text("Warning", style: TextStyle(color: Colors.amberAccent)),
          message: "Invalid Username or Password",
          duration: Duration(seconds: 4),
        )..show(context);
      } else {
        Users userData = Users.fromJson(decodeRes);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('userId', userData.id);
        setState(() {
          userdata = userData;
        });

        if (userdata.role == 1) {
          Flushbar(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Colors.greenAccent,
            ),
            showProgressIndicator: true,
            progressIndicatorBackgroundColor: Colors.blue[200],
            titleText:
                Text("Success", style: TextStyle(color: Colors.greenAccent)),
            message: "Log in Success!!",
            duration: Duration(seconds: 4),
          )..show(context)
              .then((value) => Navigator.pushNamed(context, 'AdminDashboard'));
        } else {
          Flushbar(
            icon: Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
            showProgressIndicator: true,
            progressIndicatorBackgroundColor: Colors.blue[200],
            titleText:
                Text("Success", style: TextStyle(color: Colors.greenAccent)),
            message: "Log in Success!!",
            duration: Duration(seconds: 4),
          )..show(context)
              .then((value) => Navigator.pushNamed(context, 'UserDashboard'));
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.redAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Error", style: TextStyle(color: Colors.redAccent)),
        message: "Something went wrong!!",
        duration: Duration(seconds: 4),
      )..show(context);
    }
  }
}
