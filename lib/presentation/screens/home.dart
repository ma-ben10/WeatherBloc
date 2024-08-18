import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherbloc/business_logic/blocs/blocs/weatherbloc.dart';
import 'package:weatherbloc/data/repositories/watherRepository.dart';
import 'package:weatherbloc/presentation/screens/weatherscreen.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Weatherbloc(watherrepository: Watherrepository()),
      child: weatherScreen(),
    );
  }
}
