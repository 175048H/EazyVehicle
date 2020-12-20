import 'dart:convert';
import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class PlaceOrder extends StatefulWidget {
  final Orders orders;
  PlaceOrder(this.orders);
  @override
  _PlaceOrderState createState() => _PlaceOrderState(orders);
}

class _PlaceOrderState extends State<PlaceOrder> {
  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _dropAddressController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Orders _orders;
  _PlaceOrderState(this._orders);

  int basePrice;
  int weight;
  String vehicleName;
  static DateTime selectedDate = DateTime.now();

  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _orders.dateTime = formattedDate;
      });
  }

  List<Vehicles> data = [];
  getVehicleList() async {
    var res = await APIServices.fetchVehicles();
    var resBody = json.decode(res.body);

    setState(() {
      data = (resBody as List).map((e) => Vehicles.fromjson(e)).toList();
    });
  }

  Vehicles itm;

  @override
  void initState() {
    super.initState();
    this.getVehicleList();
    this.getGoodList();
  }

  List<Goods> goods = [];
  Goods good;
  getGoodList() async {
    var res = await APIServices.fetchGoods();
    var resBody = json.decode(res.body);

    setState(() {
      goods = (resBody as List).map((e) => Goods.fromjson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Place Order',
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
                child: SpinKitRipple(
                  color: Colors.purple[900],
                  size: 90,
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 60.0),
                        _vehicleDropdown(),
                        _goodsDropdown(),
                        _pickupAddress(),
                        _dropAddress(),
                        _estimatedWeight(),
                        _dateTime(),
                        _signupbt()
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _estimatedWeight() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _orders.estimatedWeight = weight = int.parse(_weightController.text);
          _orders.totalPrice = (weight * basePrice);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter estimated weight';
          }
          return null;
        },
        controller: _weightController,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Estimated weight (Kg)',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.line_weight,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _pickupAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _orders.pickupAddress = _pickupAddressController.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter pickup address';
          }
          return null;
        },
        controller: _pickupAddressController,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Pickup Address',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.location_on,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _dropAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _orders.dropAddress = _dropAddressController.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter drop address';
          }
          return null;
        },
        controller: _dropAddressController,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Drop Address',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.location_on,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _dateTime() {
    return Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.white54),
                onPressed: () {}),
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(color: Colors.white54),
            ),
            SizedBox(width: 20.0),
            Container(
              child: RaisedButton(
                color: Colors.white54,
                onPressed: () => _selectDate(context),
                child: Text(
                  'Select Date',
                  style: TextStyle(
                    color: Colors.purple[900],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _vehicleDropdown() {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: DropdownButton(
            isExpanded: true,
            value: itm,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white54,
              size: 35,
            ),
            dropdownColor: Colors.blue[200],
            items: data.map((item) {
              return new DropdownMenuItem(
                child: Text(
                  item.vehicleName,
                  style: TextStyle(color: Colors.white),
                ),
                value: item,
              );
            }).toList(),
            hint: Text(
              'Select a vehicle',
              style: TextStyle(color: Colors.white38),
            ),
            style: TextStyle(color: Colors.purple[900]),
            onChanged: (Vehicles newVal) {
              setState(() {
                _orders.vehicle = newVal.id;
                basePrice = newVal.basePrice;
                vehicleName = newVal.vehicleName;
                itm = newVal;
              });
            },
          ),
        ),
      ]),
    );
  }

  Widget _goodsDropdown() {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: DropdownButton(
            isExpanded: true,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white54,
              size: 35,
            ),
            dropdownColor: Colors.blue[200],
            value: good,
            items: goods.map((item) {
              return new DropdownMenuItem(
                child: Text(
                  item.goodName,
                  style: TextStyle(color: Colors.white),
                ),
                value: item,
              );
            }).toList(),
            hint: Text(
              'Select a Good',
              style: TextStyle(color: Colors.white38),
            ),
            style: TextStyle(color: Colors.purple[900]),
            onChanged: (Goods val) {
              setState(() {
                _orders.goodsType = val.id;
                good = val;
              });
            },
          ),
        ),
      ]),
    );
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
              'SAVE',
              style: TextStyle(
                color: Colors.purple[800],
                letterSpacing: 1.0,
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _displayDialog();
              }
            },
          ),
        ),
      ),
    );
  }

  _displayDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Total Price '),
            content: Text(
              ('Rs. ' + (weight * basePrice).toString()),
              style: TextStyle(color: Colors.purple[900], fontSize: 25),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'Ok',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  saveOrders();
                  activeVehicle();
                },
              )
            ],
          );
        });
  }

  void saveOrders() async {
    var res = await APIServices.postOrder(_orders);
    await APIServices.sendEmailToAdmin(vehicleName, _orders);

    if (res.statusCode == 201) {
      setState(() {
        isLoading = true;
      });
      Flushbar(
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.greenAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Success", style: TextStyle(color: Colors.greenAccent)),
        message: "Successfully Ordered!!",
        duration: Duration(seconds: 4),
      )..show(context)
          .then((value) => Navigator.pushNamed(context, 'UserDashboard'));
    } else {
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

  void activeVehicle() async {
    await APIServices.updateVehicleStatus(_orders.vehicle);
  }
}
