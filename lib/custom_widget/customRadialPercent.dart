import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

customRadial(
    double percent, var reading, String unit, String type, Color color) {
  return Column(
    children: [
      CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 5.0,
        percent: percent,
        center: new Text("$reading $unit"),
        progressColor: Colors.green,
      ),
      Text(type),
    ],
  );
}
