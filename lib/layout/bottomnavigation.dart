import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/layout/cubit/cubit.dart';
import 'package:musicapp/layout/cubit/states.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicAppCubit, MusicAppStates>(
        builder: (context, state) {
          var cubit = MusicAppCubit.get(context);
          return Scaffold(
              body: SafeArea(child: cubit.screens[cubit.index]),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.grey[300],
                  fixedColor: Colors.redAccent,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.white,
                  elevation: 0,
                  currentIndex: cubit.index,
                  onTap: (i) {
                    cubit.onTap(i);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.music_note),
                        label: "Music",
                        tooltip: "music"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.file_copy),
                        label: "File",
                        tooltip: "file"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.network_wifi_outlined),
                        label: "URL",
                        tooltip: "url"),
                  ]));
        },
        listener: (context, state) {});
  }
}
