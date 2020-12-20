import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:LogisticMngt/Models/Users.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  final Users users;
  RegisterPage(this.users);
  @override
  _RegisterPageState createState() => _RegisterPageState(users);
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNamecontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _contactNocontroller = TextEditingController();
  bool isLoading = false;
  bool password = true;
  final _formKey = GlobalKey<FormState>();
  Users _users;
  _RegisterPageState(this._users);

  List<String> options = <String>['Admin', 'User'];
  String dropdownValue = 'Admin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 25.0, letterSpacing: 1.0),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
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
                      color: Colors.purple[900],
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
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        _fullNameField(),
                        _usernameField(),
                        _passwordField(),
                        _emailField(),
                        _contactNoField(),
                        _text(),
                        _dropdown(),
                        _signupbt(),
                        _loginText()
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _fullNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _users.fullName = _fullNamecontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter full name';
          }
          return null;
        },
        controller: _fullNamecontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Full Name',
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
          } else if (value.length > 25 || value.length < 8) {
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
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _users.password = _passwordcontroller.text;
        },
        obscureText: password,
        autofocus: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter password';
          } else if (value.length > 25 || value.length < 9) {
            return 'Please enter valid password';
          }
          return null;
        },
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

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _users.email = _emailcontroller.text;
        },
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (value.isEmpty) {
            return 'Please enter Email ';
          } else if (!regex.hasMatch(value)) {
            return 'Please enter valid Email ';
          }
          return null;
        },
        controller: _emailcontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.email,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _contactNoField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _users.contactNo = _contactNocontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter contact number';
          } else if (value.length > 11 || value.length < 10) {
            return 'Please enter a valid number';
          }
          return null;
        },
        controller: _contactNocontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          filled: true,
          hintText: 'Contact No',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Icon(
              Icons.call,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _text() {
    return Container(
        width: 330,
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
        child: Stack(
          children: [
            Text(
              'Select a Role',
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ));
  }

  Widget _dropdown() {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(
            Icons.person,
            color: Colors.white54,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 47),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (value) => updateRole(value),
            style: TextStyle(color: Colors.purple[900]),
            selectedItemBuilder: (BuildContext context) {
              return options.map((String value) {
                return Text(
                  dropdownValue,
                  style: TextStyle(
                      color: Colors.white38, fontSize: 17, letterSpacing: 1.0),
                );
              }).toList();
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }

  void updateRole(String value) {
    switch (value) {
      case "Admin":
        _users.role = 1;
        setState(() {
          dropdownValue = 'Admin';
        });
        break;
      case "User":
        _users.role = 2;
        setState(() {
          dropdownValue = 'User';
        });
        break;
      default:
    }
  }

  Widget _signupbt() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Login'),
      child: Padding(
        padding: EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Container(
          width: 257,
          decoration: BoxDecoration(color: Colors.white),
          child: FlatButton(
            child: Text(
              'SIGN UP',
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
                signupUsers();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loginText() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Login'),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Colors.white70,
              ),
              children: [
                TextSpan(
                  text: 'LOG IN',
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

  void signupUsers() async {
    var res = await APIServices.postUsers(_users);

    if (res.statusCode == 201) {
      Flushbar(
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.greenAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Success", style: TextStyle(color: Colors.greenAccent)),
        message: "Successfully Resgistered!!",
        duration: Duration(seconds: 4),
      )..show(context).then((value) => Navigator.pushNamed(context, 'Login'));
    } else if (res.statusCode == 200) {
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
        titleText: Text("Warning", style: TextStyle(color: Colors.amberAccent)),
        message: "Username is already taken!!",
        duration: Duration(seconds: 4),
      )..show(context).then((value) => Navigator.pushNamed(context, 'Login'));
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
