import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateVehicle extends StatefulWidget {
  final Vehicles vehicles;
  CreateVehicle(this.vehicles);
  @override
  _CreateVehicleState createState() => _CreateVehicleState(vehicles);
}

class _CreateVehicleState extends State<CreateVehicle> {
  Vehicles _vehicles;

  _CreateVehicleState(this._vehicles);
  bool isLoading = false;

  final TextEditingController _vehicleNamecontroller = TextEditingController();
  final TextEditingController _basePricecontroller = TextEditingController();
  final TextEditingController _vehicleNocontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: isLoading
            ? Center(
                child: SpinKitRipple(
                  color: Colors.purple[900],
                  size: 90,
                ),
              )
            : Container(
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
                      _expandeContainer(context)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _expandeContainer(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        _vehicleNameField(),
        _basePriceField(),
        _vehicleNoField(),
        _addVehicleBtn(context),
      ],
    ));
  }

  Widget _vehicleNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _vehicles.vehicleName = _vehicleNamecontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter vehicle Name';
          }
          return null;
        },
        controller: _vehicleNamecontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Vehicle Name',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.local_shipping,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _vehicleNoField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _vehicles.vehicleNo = _vehicleNocontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter vehicle No';
          }
          return null;
        },
        controller: _vehicleNocontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Vehicle No',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.confirmation_number,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _basePriceField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _vehicles.basePrice = int.parse(_basePricecontroller.text);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter base price';
          }
          return null;
        },
        controller: _basePricecontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Base Price',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(
              Icons.attach_money,
              color: Colors.white54,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
      ),
    );
  }

  Widget _addVehicleBtn(BuildContext context) {
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
                'CREATE',
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
                  postVehicle();
                }
              }),
        ),
      ),
    );
  }

  void postVehicle() async {
    var res = await APIServices.postVehicle(_vehicles);
    if (res.statusCode == 201) {
      Flushbar(
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.greenAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Success", style: TextStyle(color: Colors.greenAccent)),
        message: "Successfully Created Vehicle",
        duration: Duration(seconds: 4),
      )..show(context).then((value) => Navigator.pop(context, true));
    } else {
      Flushbar(
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.redAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Error", style: TextStyle(color: Colors.redAccent)),
        message: "Something went wrong!!\n Check your internet connection",
        duration: Duration(seconds: 4),
      )..show(context);
    }
  }
}
