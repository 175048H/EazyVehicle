import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateGoods extends StatefulWidget {
  final Goods goods;
  CreateGoods(this.goods);
  @override
  _CreateGoodsState createState() => _CreateGoodsState(goods);
}

class _CreateGoodsState extends State<CreateGoods> {
  Goods _goods;

  _CreateGoodsState(this._goods);

  final TextEditingController _typeofGoodcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type of Goods'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: SpinKitRipple(
                color: Colors.purple[900],
                size: 90,
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
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
        _addVehicleBtn(context),
      ],
    ));
  }

  Widget _vehicleNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: TextFormField(
        onChanged: (value) {
          _goods.goodName = _typeofGoodcontroller.text;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter type of a good';
          }
          return null;
        },
        controller: _typeofGoodcontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Type of Good',
          hintStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0),
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
                  postGoods();
                }
              }),
        ),
      ),
    );
  }

  void postGoods() async {
    var res = await APIServices.postGoods(_goods);
    if (res.statusCode == 201) {
      Flushbar(
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.greenAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Success", style: TextStyle(color: Colors.greenAccent)),
        message: "Successfully Created !!",
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
        message: "Something went wrong!! \n Check your internet connection",
        duration: Duration(seconds: 4),
      )..show(context);
    }
  }
}
