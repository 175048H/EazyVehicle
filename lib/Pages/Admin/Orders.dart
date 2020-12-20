import 'dart:convert';
import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:LogisticMngt/Models/Admin.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminOrders extends StatefulWidget {
  AdminOrders({Key key}) : super(key: key);
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  List<OrdersDto> orders;
  List<OrdersDto> filteredOrders;
  var highlightColor;
  bool cancelled = false;
  getOrders() {
    APIServices.fetchOrders().then((response) {
      Iterable list = json.decode(response.body);
      List<OrdersDto> orderList = List<OrdersDto>();
      orderList = list.map((model) => OrdersDto.fromjson(model)).toList();

      setState(() {
        orders = orderList;
        filteredOrders = orders;
      });
    });
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 25.0),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.purple[900],
                Colors.blue[300],
              ],
            ),
          ),
        ),
      ),
      body: filteredOrders == null
          ? Center(
              child: SpinKitRipple(
                color: Colors.purple[900],
                size: 90,
              ),
            )
          : Column(
              children: [
                _searchField(),
                SizedBox(height: 10),
                _highlightedColor(),
                _highlightedText(),
                SizedBox(height: 15),
                _buildorderlist(),
              ],
            ),
    );
  }

  Widget _searchField() {
    return TextField(
      onChanged: (string) {
        setState(() {
          filteredOrders = orders
              .where((o) =>
                  (o.vehicleName
                      .toLowerCase()
                      .contains(string.toLowerCase())) ||
                  (o.goodsTypeName
                      .toLowerCase()
                      .contains(string.toLowerCase())) ||
                  (o.orderNo.toLowerCase().contains(string.toLowerCase())))
              .toList();
        });
      },
      style: TextStyle(color: Colors.purple[900]),
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.all(15),
        hintText: "Enter vehicle, type of good or Order No",
        hintStyle: TextStyle(color: Colors.purple[700]),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 0), // add padding to adjust icon
          child: Icon(
            Icons.search,
            color: Colors.purple[900],
          ),
        ),
      ),
    );
  }

  Widget _highlightedColor() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.local_offer, color: Colors.green),
          Icon(Icons.local_offer, color: Colors.blue),
          Icon(Icons.local_offer, color: Colors.red),
        ],
      ),
    );
  }

  Widget _highlightedText() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Active', style: TextStyle(color: Colors.green)),
          Text('Completed', style: TextStyle(color: Colors.blue)),
          Text('Cancelled', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildorderlist() {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 2,
          children: List<Widget>.generate(filteredOrders.length, (index) {
            if (filteredOrders[index].status == 'Active') {
              setState(() {
                highlightColor = Colors.green;
              });
            } else if (filteredOrders[index].status == 'Cancelled') {
              setState(() {
                highlightColor = Colors.red;
              });
            } else if (filteredOrders[index].status == 'Completed') {
              setState(() {
                highlightColor = Colors.blue;
              });
            }
            return GridTile(
              child: Card(
                color: highlightColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                          'Order No :  ' +
                              filteredOrders[index].orderNo +
                              '\n\nVehicle   : ' +
                              filteredOrders[index].vehicleName +
                              '\n\nGood : ' +
                              filteredOrders[index].goodsTypeName +
                              '\n\nTotal Price : ' +
                              (filteredOrders[index].totalPrice).toString(),
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
                    ),
                    ButtonBar(
                      buttonPadding: EdgeInsets.only(top: 5),
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          textColor: Colors.black,
                          onPressed: () {
                            cancelOrder(
                                this.filteredOrders[index].id,
                                this.filteredOrders[index].vehicle,
                                this.filteredOrders[index].email,
                                this.filteredOrders[index].vehicleName,
                                this.filteredOrders[index].totalPrice);
                          },
                          child: Text('Cancel', style: TextStyle(fontSize: 13)),
                        ),
                        FlatButton(
                          textColor: Colors.amberAccent,
                          onPressed: () {
                            completeOrder(
                                this.filteredOrders[index].id,
                                this.filteredOrders[index].vehicle,
                                this.filteredOrders[index].email,
                                this.filteredOrders[index].vehicleName,
                                this.filteredOrders[index].totalPrice);
                          },
                          child: const Text('Completed',
                              style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  cancelOrder(
      int id, int vehicleId, String mail, String vehicleName, int totalPrice) {
    String message = "Cancelled";
    APIServices.cancelOrder(id);
    APIServices.deleteVehicleStatus(vehicleId);
    APIServices.cancelOrcompleteMail(vehicleName, mail, totalPrice, message);

    Flushbar(
      icon: Icon(
        Icons.check_circle_rounded,
        color: Colors.greenAccent,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blue[200],
      titleText: Text("Success", style: TextStyle(color: Colors.greenAccent)),
      message: "Successfully Cancelled the Order!",
      duration: Duration(seconds: 4),
    )..show(context).then((value) => getOrders());
  }

  completeOrder(
      int id, int vehicleId, String mail, String vehicleName, int totalPrice) {
    String message = "Completed";
    APIServices.completeOrder(id);
    APIServices.deleteVehicleStatus(vehicleId);
    APIServices.cancelOrcompleteMail(vehicleName, mail, totalPrice, message);

    Flushbar(
      icon: Icon(
        Icons.check_circle_rounded,
        color: Colors.greenAccent,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blue[200],
      titleText: Text("Success", style: TextStyle(color: Colors.greenAccent)),
      message: "Successfully Completed the Order!",
      duration: Duration(seconds: 4),
    )..show(context).then((value) => getOrders());
  }
}
