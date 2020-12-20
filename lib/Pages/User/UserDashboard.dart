import 'package:flutter/material.dart';

import '../Drawer.dart';

class UserDashBoard extends StatefulWidget {
  UserDashBoard({Key key}) : super(key: key);
  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[900], Colors.blue[200]],
          ),
        ),
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: 60),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _imageContainer(),
                    _devider(),
                    _addGoodsbtn(context),
                    _viewOrdersbtn(context),
                  ],
                ),
              ),
            ],
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

  Widget _addGoodsbtn(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Container(
          width: 257,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.purple[900],
                offset: Offset(1.0, 5.0),
                blurRadius: 7.0,
              ),
            ],
          ),
          child: FlatButton(
              child: Text(
                'PLACE ORDER',
                style: TextStyle(
                  color: Colors.purple[800],
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'PlaceOrder');
              }),
        ),
      ),
    );
  }

  Widget _viewOrdersbtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, right: 20, left: 20),
      child: Container(
        width: 257,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.purple[900],
              offset: Offset(1.0, 5.0),
              blurRadius: 7.0,
            ),
          ],
        ),
        child: FlatButton(
            child: Text(
              'VIEW ORDERS',
              style: TextStyle(
                color: Colors.purple[800],
                letterSpacing: 1.0,
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'ViewUserOrder');
            }),
      ),
    );
  }

  Widget _devider() {
    return Padding(
      padding: EdgeInsets.only(top: 30, right: 20, left: 20),
      child: Container(
        width: 265,
        child: Divider(
          height: 30.0,
          color: Colors.purple[900],
          thickness: 2.0,
        ),
      ),
    );
  }
}
