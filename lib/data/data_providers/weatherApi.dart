import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Weatherapi {
  String apikey = "e918beb7e888430a583203c73882094e";

  Future<Map<String, dynamic>> fetchWeatherInfoOfCity(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonmap = jsonDecode(response.body);
      return jsonmap;
    } else {
      throw Exception("Faild to fetch data from api ");
    }
  }

  Future<Map<String, dynamic>> fetchWeatherInfoOflocation(
      Position position) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apikey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonmap = jsonDecode(response.body);
      return jsonmap;
    } else {
      throw Exception("Faild to fetch data from api ");
    }
  }
}
