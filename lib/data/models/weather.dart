import 'package:flutter/material.dart';

class Weather {
  late double temp;

  ///constructor init
  Weather({required this.temp});

  void getTempFromJson(Map<String, dynamic> jsonmap) {
    double resault = (jsonmap["main"]["temp"] - 273.15);
    temp = double.parse(resault.toStringAsFixed(1));
  }
}
