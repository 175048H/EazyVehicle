import 'package:LogisticMngt/Pages/Admin/AdminDrawer.dart';
import 'package:flutter/material.dart';

class AdminDashBoard extends StatefulWidget {
  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(),
      drawer: AdminDrawer(),
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
              SizedBox(height: 60.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _imageContainer(),
                    _devider(),
                    _addVehiclebtn(context),
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

  Widget _addVehiclebtn(BuildContext context) {
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
                'VEHICLES',
                style: TextStyle(
                  color: Colors.purple[800],
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'AdminVehicles');
              }),
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
                'GOODS',
                style: TextStyle(
                  color: Colors.purple[800],
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'AdminGoods');
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
              Navigator.pushNamed(context, 'AdminOrders');
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
