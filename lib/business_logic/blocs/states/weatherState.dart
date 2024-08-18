import 'package:flutter/material.dart';

import '../../../data/models/weather.dart';

abstract class Weatherstate {}

class WeatherInitial extends Weatherstate {
  final String initMessage;

  WeatherInitial({required this.initMessage});
}

class WeatherLoading extends Weatherstate {
  SizedBox loading;

  WeatherLoading({required this.loading});
}

class WeatherLoaded extends Weatherstate {
  final Weather weather;

  WeatherLoaded({required this.weather});
}

class WeatherError extends Weatherstate {
  final String errorMessage;

  /// initialisation of the constructor arguments
  WeatherError({required this.errorMessage});
}
