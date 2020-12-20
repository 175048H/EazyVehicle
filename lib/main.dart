import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/Users.dart';
import 'package:LogisticMngt/Pages/Admin/AdminDashboard.dart';
import 'package:LogisticMngt/Pages/Admin/CreateGoods.dart';
import 'package:LogisticMngt/Pages/Admin/CreateVehicle.dart';
import 'package:LogisticMngt/Pages/Admin/Goods.dart';
import 'package:LogisticMngt/Pages/Admin/Orders.dart';
import 'package:LogisticMngt/Pages/Admin/Vehicles.dart';
import 'package:LogisticMngt/Pages/Loading.dart';
import 'package:LogisticMngt/Pages/Login.dart';
import 'package:LogisticMngt/Pages/Profile.dart';
import 'package:LogisticMngt/Pages/RegisterPage.dart';
import 'package:LogisticMngt/Pages/User/PlaceOrder.dart';
import 'package:LogisticMngt/Pages/User/UserDashboard.dart';
import 'package:LogisticMngt/Pages/User/ViewUserOrder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);
    return MaterialApp(
      title: 'Logistic Management',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: 'Login',
      theme: ThemeData(
          primarySwatch: colorCustom, primaryColor: Colors.purple[900]),
      routes: {
        'Login': (context) => LoginPage(Users()),
        'Register': (context) => RegisterPage(Users()),
        'Loading': (context) => Loading(),
        'AdminDashboard': (context) => AdminDashBoard(),
        'AdminOrders': (context) => AdminOrders(),
        'AdminGoods': (context) => AdminGoods(),
        'AdminVehicles': (context) => AdminVehicles(),
        'CreateVehicle': (context) => CreateVehicle(Vehicles()),
        'CreateGoods': (context) => CreateGoods(Goods()),
        'UserDashboard': (context) => UserDashBoard(),
        'PlaceOrder': (context) => PlaceOrder(Orders()),
        'ViewUserOrder': (context) => UserOrders(),
        'Profile': (context) => Profile(),
      },
    );
  }
}
