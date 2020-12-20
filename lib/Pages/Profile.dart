import 'dart:convert';
import 'dart:ui';

import 'package:LogisticMngt/Models/ApiServices.dart';
import 'package:LogisticMngt/Models/Users.dart';
import 'package:LogisticMngt/Pages/Admin/AdminDrawer.dart';
import 'package:LogisticMngt/Pages/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Users userDetails;
  bool isLoading = true;
  getUserDetails() async {
    var res = await APIServices.getUser();
    var decodedRes = jsonDecode(res.body);
    Users userData = Users.fromJson(decodedRes);
    setState(() {
      userDetails = userData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Widget _textFild({@required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 5, left: 15, right: 15),
      child: Material(
        elevation: 4,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: text,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              )),
        ),
      ),
    );
  }

  Widget _text({@required labelName}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        labelName,
        style: TextStyle(color: Colors.purple[900], letterSpacing: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: userDetails.role == 1 ? AdminDrawer() : MainDrawer(),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitRipple(
                    color: Colors.purple[900],
                    size: 90,
                  ),
                ],
              ),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 450,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            _text(labelName: 'Full Name'),
                            _textFild(text: userDetails.fullName),
                            _text(labelName: 'Username'),
                            _textFild(text: userDetails.userName),
                            _text(labelName: 'Email'),
                            _textFild(text: userDetails.email),
                            _text(labelName: 'Contact No'),
                            _textFild(text: userDetails.contactNo),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomPaint(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/index.jpg'),
                          )),
                    )
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(bottom: 400, left: 120),
                //   child: CircleAvatar(
                //     backgroundColor: Colors.black54,
                //     child: IconButton(
                //       icon: Icon(
                //         Icons.edit,
                //         color: Colors.white,
                //       ),
                //       onPressed: () {},
                //     ),
                //   ),
                // )
              ],
            ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.purple[900];
    Path path = Path()
      ..relativeLineTo(0, 50)
      ..quadraticBezierTo(size.width / 2, 120, size.width, 50)
      ..relativeLineTo(0, -50)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
