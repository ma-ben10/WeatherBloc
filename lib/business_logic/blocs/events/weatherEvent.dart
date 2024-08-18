import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherEvent {}

class WeatherFromCityEvent extends WeatherEvent {
  String cityname;

  WeatherFromCityEvent({required this.cityname});
}

class WeatherFromCurrentLocationEvent extends WeatherEvent {
  WeatherFromCurrentLocationEvent();
}
