import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherbloc/business_logic/blocs/events/weatherEvent.dart';
import 'package:weatherbloc/business_logic/blocs/states/weatherState.dart';
import 'package:weatherbloc/data/models/weather.dart';
import 'package:weatherbloc/data/repositories/watherRepository.dart';

class Weatherbloc extends Bloc<WeatherEvent, Weatherstate> {
  /// i will create an instance of the WeatherRepository class
  /// because i will only work with it like a port to the data layer
  final Watherrepository watherrepository;

  Weatherbloc({required this.watherrepository})
      : super(WeatherInitial(initMessage: "Welcom to WeatherBloc")) {
    on<WeatherFromCurrentLocationEvent>((event, emit) async {
      emit(WeatherLoading(
          loading: const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )));
      try {
        final Weather weathero =
            await watherrepository.getWeatherFromLocation();
        emit(WeatherLoaded(weather: weathero));
      } catch (e) {
        emit(WeatherError(errorMessage: "$e"));
      }
    });

    /// getting the weather temp from a specific city :
    on<WeatherFromCityEvent>((event, emit) async {
      emit(WeatherLoading(
          loading: const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )));
      await Future.delayed(const Duration(seconds: 4));
      try {
        final Weather weathero =
            await watherrepository.getWeatherFromCity(event.cityname);
        emit(WeatherLoaded(weather: weathero));
      } catch (e) {
        emit(WeatherError(errorMessage: "$e"));

        /// Failed in fetching weather info Maybe ${event.cityname} doesn't exist
      }
    });
  }
}
