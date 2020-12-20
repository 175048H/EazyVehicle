import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/Users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  static String baseUrl = 'https://0603939e2e69.ngrok.io/api/';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

//post User details
  static Future postUsers(Users users) async {
    Map<String, dynamic> tbody = {
      'FullName': users.fullName,
      'UserName': users.userName,
      'Password': users.password,
      'Email': users.email,
      'ContactNo': users.contactNo,
      'Role': users.role
    };
    var body = json.encode(tbody);
    log(body);
    var res = await http.post(baseUrl + 'Users', headers: header, body: body);
    return res;
  }

//login user
  static Future loginUser(Users users) async {
    var res = await http.get(baseUrl +
        'Users/login?password=' +
        users.password +
        '&username=' +
        users.userName);

    return res;
  }

//fetch order
  static Future fetchOrders() async {
    return await http.get(baseUrl + 'Orders');
  }

  //fetch vehicles
  static Future fetchVehicles() async {
    return await http.get(baseUrl + 'Vehicles/GetFilteredVehicle');
  }

  //post vehicle
  static Future postVehicle(Vehicles vehicles) async {
    Map<String, dynamic> tbody = {
      'vehicleName': vehicles.vehicleName,
      'basePrice': vehicles.basePrice,
      'vehicleNo': vehicles.vehicleNo
    };
    var body = json.encode(tbody);
    log(body);
    var res =
        await http.post(baseUrl + 'Vehicles', headers: header, body: body);

    return res;
  }

  //fetch goods
  static Future fetchGoods() async {
    return await http.get(baseUrl + 'Goods');
  }

  //post goods
  static Future postGoods(Goods goods) async {
    Map<String, dynamic> tbody = {
      'goodName': goods.goodName,
    };
    var body = json.encode(tbody);
    log(body);
    var res = await http.post(baseUrl + 'Goods', headers: header, body: body);

    return res;
  }

//Cancle Orders
  static Future cancelOrder(int id) async {
    var res = await http.put(
        baseUrl + 'Orders/Cancel?id=' + id.toString() + '&status=Cancelled');
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return Exception('Somthing went wrong');
    }
  }

//complete Orders
  static Future completeOrder(int id) async {
    var res = await http.put(
        baseUrl + 'Orders/Complete?id=' + id.toString() + '&status=Completed');
    if (res.statusCode == 200) {
      return (res.body);
    } else {
      return Exception('Somthing went wrong');
    }
  }

  //update vehicle Status
  static Future updateVehicleStatus(int id) async {
    var res =
        await http.put(baseUrl + 'Vehicles/UpdateStatus?id=' + id.toString());
    if (res.statusCode == 200) {
      return 'Ok';
    } else {
      return Exception('Somthing went wrong');
    }
  }

// delete vehicle status
  static Future deleteVehicleStatus(int id) async {
    var res =
        await http.put(baseUrl + 'Vehicles/DeleteStatus?id=' + id.toString());
    log(id.toString());
    if (res.statusCode == 200) {
      return 'Ok';
    } else {
      return Exception('Somthing went wrong');
    }
  }

//post Order details
  static Future postOrder(Orders orders) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    Map<String, dynamic> tbody = {
      'OrderNo': "123dhsg",
      'Vehicle': orders.vehicle,
      'GoodsType': orders.goodsType,
      'PickupAddress': orders.pickupAddress,
      'DropAddress': orders.dropAddress,
      'EstimatedWeight': orders.estimatedWeight,
      'Status': 'Active',
      'userId': userId,
      'DateTime': orders.dateTime.toString(),
      'TotalPrice': orders.totalPrice
    };
    var body = json.encode(tbody);
    log(body);
    var res = await http.post(baseUrl + 'Orders', headers: header, body: body);
    return res;
  }

  //fetch user order
  static Future fetchUserOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    log(userId.toString());
    return await http
        .get(baseUrl + 'Orders/GetUserOrder?userId=' + userId.toString());
  }

  //fetch single user
  static Future getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    return await http.get(baseUrl + 'Users/' + userId.toString());
  }

  //login user
  static Future sendEmailToAdmin(String vehicleName, Orders orders) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    var res = await http.post(baseUrl +
        "Orders/SendMail?userId=" +
        userId.toString() +
        "&vehicleName=" +
        vehicleName +
        " &price=" +
        (orders.totalPrice).toString());

    return res;
  }

  static Future cancelOrcompleteMail(
      String vehicleName, String email, int totalPrice, String message) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    var res = await http.post(baseUrl +
        "Orders/SendMail?userId=" +
        userId.toString() +
        "&vehicleName=" +
        vehicleName +
        " &price=" +
        totalPrice.toString() +
        "&message=" +
        message +
        "&email=" +
        email);

    return res;
  }
}
