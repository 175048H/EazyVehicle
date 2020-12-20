import 'dart:convert';

import 'package:LogisticMngt/Models/Admin.dart';
import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminVehicles extends StatefulWidget {
  AdminVehicles({Key key}) : super(key: key);
  @override
  _AdminVehiclesState createState() => _AdminVehiclesState();
}

class _AdminVehiclesState extends State<AdminVehicles> {
  List<Vehicles> vehicles;
  List<Vehicles> filteredVehicle;

  @override
  void initState() {
    super.initState();
    getVehicles();
  }

  getVehicles() {
    APIServices.fetchVehicles().then((response) {
      Iterable list = json.decode(response.body);
      List<Vehicles> vehicleList = List<Vehicles>();
      vehicleList = list.map((model) => Vehicles.fromjson(model)).toList();

      setState(() {
        vehicles = vehicleList;
        filteredVehicle = vehicles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Available Vehicles',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      floatingActionButton: _floatingButton(),
      backgroundColor: Colors.white,
      body: filteredVehicle == null
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
                        filteredVehicle = vehicles
                            .where((v) => (v.vehicleName
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(15),
                      hintText: "Enter vehicle name",
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
                  _buildVehiclelist(),
                ],
              ),
            ),
    );
  }

  Widget _buildVehiclelist() {
    return Expanded(
      child: ListView.builder(
          itemCount: filteredVehicle.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              child: ListTile(
                title: ListTile(
                  //trailing: Icon(Icons.delete, color: Colors.red),
                  title: Text(
                      'Vehicle Name :  ' + filteredVehicle[index].vehicleName),
                  subtitle: Text('Base Price :  ' +
                      filteredVehicle[index].basePrice.toString() +
                      '\nVehicle No : ' +
                      filteredVehicle[index].vehicleNo),
                  onTap: () {
                    //deleteVehicle(filteredVehicle[index].id);
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton.extended(
      label: Text('Add Vehicle'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.purple[900],
      onPressed: () {
        //navigateToCourses(Courses('', ''));
        Navigator.pushNamed(context, 'CreateVehicle');
      },
    );
  }
}
