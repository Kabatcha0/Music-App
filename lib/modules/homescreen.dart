import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/cubit/cubit.dart';
import 'package:musicapp/cubit/states.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicAppCubit, MusicAppStates>(
        builder: (context, state) {
          var cubit = MusicAppCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  "https://images.macrumors.com/t/vMbr05RQ60tz7V_zS5UEO9SbGR0=/1600x900/smart/article-new/2018/05/apple-music-note.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://images.macrumors.com/t/vMbr05RQ60tz7V_zS5UEO9SbGR0=/1600x900/smart/article-new/2018/05/apple-music-note.jpg",
                          width: 200,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Summer Vibes".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${cubit.currentDuration.inMinutes}:${cubit.currentDuration.inSeconds % 60}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 300,
                            child: Slider.adaptive(
                                max: cubit.allDuration.inSeconds.toDouble(),
                                min: 0,
                                value:
                                    cubit.currentDuration.inSeconds.toDouble(),
                                onChanged: (v) {
                                  cubit.seek(v.round());
                                }),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${cubit.allDuration.inMinutes}:${cubit.allDuration.inSeconds % 60}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (cubit.currentDuration.inSeconds > 10) {
                                    cubit.seek(
                                        cubit.currentDuration.inSeconds - 10);
                                  } else {
                                    cubit.seek(0);
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 25,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (cubit.isPlaying == false) {
                                    cubit.tapMusic();
                                  } else {
                                    cubit.pauseMusic();
                                  }
                                },
                                icon: cubit.isPlaying
                                    ? const Icon(
                                        Icons.pause,
                                        size: 25,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.play_circle_outline_sharp,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                            IconButton(
                                onPressed: () {
                                  if (cubit.allDuration.inSeconds >
                                      cubit.currentDuration.inSeconds - 10) {
                                    cubit.seek(
                                        cubit.currentDuration.inSeconds + 10);
                                  } else {
                                    cubit.seek(cubit.allDuration.inSeconds);
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 25,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          );
        },
        listener: (context, state) {});
  }
}
