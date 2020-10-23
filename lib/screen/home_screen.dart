import 'dart:async';

import 'package:air_monitoring_cp/custom_widget/customRadialPercent.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../service/firebase.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var temp, hum, lpg, co, system;
var type;

class _HomeScreenState extends State<HomeScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final firebaseHelper = FirebaseHelper();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        var data = firebaseHelper.getData();
        temp = data['temp'];
        hum = data['hum'];
        lpg = data['lpg'];
        co = data['co'];
        system = data['system'];
      });

      if (hum != null) t.cancel();
    });

    listenData();
  }

  @override
  Widget build(BuildContext context) {
    if (system != null ||
        temp != null ||
        hum != null ||
        lpg != null ||
        co != null) {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                customRadial(
                    temp / 100, temp, "°C", "Temperature", Colors.orange),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                customRadial(hum / 100, hum, "%", "Humidity", Colors.blue),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                customRadial(lpg / 1000, lpg, "PPM", "LPG", Colors.green[300]),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                customRadial(
                    co / 1000, co, "PPM", "Carbon Dioxide", Colors.pink[200]),
              ],
            ),
            SizedBox(height: 35),
            ButtonTheme(
              minWidth: 290,
              height: 80,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: system == 0
                    ? Text('OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                    : Text('ON',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                color: system == 0 ? Colors.red : Colors.green,
                onPressed: () {
                  if (system == 1)
                    system = 0;
                  else
                    system = 1;

                  firebaseHelper.updateData(system);
                },
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void listenData() {
    databaseReference.onChildChanged.listen((event) {
      var data = event.snapshot;
      var type = data.key;
      var value = data.value;

      setState(() {
        switch (type) {
          case 'CO':
            print(value);
            co = value;
            break;
          case 'LPG':
            lpg = value;
            break;
          case 'Humidity':
            hum = value;
            break;
          case 'Temp':
            temp = value;
            break;
        }
      });
    });
  }
}
