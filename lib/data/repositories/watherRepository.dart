import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherbloc/data/data_providers/internetApi.dart';
import 'package:weatherbloc/data/data_providers/locationApi.dart';
import 'package:weatherbloc/data/data_providers/weatherApi.dart';

import '../models/weather.dart';

class Watherrepository {
  Weatherapi weatherapi = Weatherapi();
  Weather weather = Weather(temp: 0);
  Locationapi locationapi = Locationapi();
  InternetApi internetapi = InternetApi();

  Future<Weather> getWeatherFromLocation() async {
    Position position = await locationapi.determinePosition();
    try {
      Map<String, dynamic> weatherMap =
          await weatherapi.fetchWeatherInfoOflocation(position);
      weather.getTempFromJson(weatherMap);

      return weather;
    } catch (e) {
      throw Exception("Failed to get weather info using current location : $e");
    }
  }

  Future<Weather> getWeatherFromCity(String city) async {
    try {
      Map<String, dynamic> weatherMap =
          await weatherapi.fetchWeatherInfoOfCity(city);

      /// here we affect the fetched weather info which is a map
      /// of <String,dynamic> values inside a function in the Weather class
      /// which it will catch only the weather temp from the fetched map
      weather.getTempFromJson(weatherMap);
      return weather;
    } catch (e) {
      throw Exception("Failed to get weather info using cityName : $e");
    }
  }
}
