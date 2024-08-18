import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherbloc/business_logic/blocs/blocs/weatherbloc.dart';
import 'package:weatherbloc/business_logic/blocs/events/weatherEvent.dart';
import 'package:weatherbloc/business_logic/blocs/states/weatherState.dart';

class weatherScreen extends StatefulWidget {
  const weatherScreen({super.key});

  @override
  State<weatherScreen> createState() => _weatherScreenState();
}

class _weatherScreenState extends State<weatherScreen> {
  final TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    final weatherbloc = BlocProvider.of<Weatherbloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: ListView(children: [
                BlocConsumer<Weatherbloc, Weatherstate>(
                  listener: (context, state) {
                    if (state is WeatherError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.errorMessage,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  bloc: weatherbloc,
                  builder: (context, state) {
                    /// if we check the type of the state we must use the "is" keyword not the "=="
                    if (state is WeatherInitial) {
                      return Text(
                        state.initMessage,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue)),
                      );
                    } else if (state is WeatherError) {
                      return Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      );
                    } else if (state is WeatherLoading) {
                      return SizedBox(
                          width: 50, height: 50, child: state.loading);
                    } else {
                      final temp = state as WeatherLoaded;
                      return Text(
                        "${temp.weather.temp}°",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.black),
                    onPressed: () {
                      weatherbloc.add(WeatherFromCurrentLocationEvent());
                    },
                    child: Text(
                      "Get weather temp of current location",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.location_city)),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.black),
                    onPressed: () {
                      weatherbloc
                          .add(WeatherFromCityEvent(cityname: controller.text));
                    },
                    child: Text(
                      "Get weather temp of a specific city",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ))
              ]))),
    );
  }
}
