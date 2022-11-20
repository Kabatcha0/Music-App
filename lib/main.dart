import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/cubit/cubit.dart';
import 'package:musicapp/cubit/states.dart';
import 'package:musicapp/modules/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicAppCubit()
        ..playMusic()
        ..tallOfsong()
        ..songChange(),
      child: BlocConsumer<MusicAppCubit, MusicAppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MusicApp(),
        ),
      ),
    );
  }
}
