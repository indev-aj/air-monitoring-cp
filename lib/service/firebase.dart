import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {
  final databaseReference = FirebaseDatabase.instance.reference();
  var temp, hum, lpg, co, system;

  Map<String, dynamic> getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      temp = snapshot.value['Temp'];
      lpg = snapshot.value['LPG'];
      hum = snapshot.value['Humidity'];
      co = snapshot.value['CO'];
      system = snapshot.value['System'];
    });

    Map<String, dynamic> data = {
      'temp': temp,
      'lpg': lpg,
      'hum': hum,
      'co': co,
      'system': system
    };

    return data;
  }

  void updateData(int val) {
    databaseReference.update({'System': val});
  }
}
