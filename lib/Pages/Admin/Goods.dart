import 'dart:convert';

import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminGoods extends StatefulWidget {
  AdminGoods({Key key}) : super(key: key);
  @override
  _AdminGoodsState createState() => _AdminGoodsState();
}

class _AdminGoodsState extends State<AdminGoods> {
  List<Goods> goods;
  List<Goods> filteredGoods;
  getGoods() {
    APIServices.fetchGoods().then((response) {
      Iterable list = json.decode(response.body);
      List<Goods> goodsList = List<Goods>();
      goodsList = list.map((model) => Goods.fromjson(model)).toList();

      setState(() {
        goods = goodsList;
        filteredGoods = goods;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getGoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Goods',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      floatingActionButton: _floatingButton(),
      backgroundColor: Colors.white,
      body: filteredGoods == null
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
              child: Column(
                children: [
                  TextField(
                    onChanged: (string) {
                      setState(() {
                        filteredGoods = goods
                            .where((g) => (g.goodName
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: "Enter type of goods",
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            top: 0), // add padding to adjust icon
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  _buildGoodslist(),
                ],
              ),
            ),
    );
  }

  Widget _buildGoodslist() {
    return Expanded(
      child: ListView.builder(
          itemCount: filteredGoods.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              child: ListTile(
                title: ListTile(
                  // trailing: Icon(Icons.arrow_right),
                  title:
                      Text('Type of Good :  ' + filteredGoods[index].goodName),

                  onTap: () {
                    //navigateToCourses(this.courses[index]);
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton.extended(
      label: Text('Add Goods'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.purple[900],
      onPressed: () {
        Navigator.pushNamed(context, 'CreateGoods');
      },
    );
  }
}
