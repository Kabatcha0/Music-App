import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/layout/cubit/cubit.dart';
import 'package:musicapp/layout/cubit/states.dart';

class FilePhone extends StatelessWidget {
  const FilePhone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicAppCubit, MusicAppStates>(
        builder: (context, state) {
          var cubit = MusicAppCubit.get(context);
          return Stack(
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
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                        onPressed: () async {
                          var result = await cubit.openFile();
                          if (result != null) {
                            cubit.playMusicFormFile(url: result);
                          } else {
                            // ignore: avoid_returning_null_for_void
                            return null;
                          }
                        },
                        icon: const Icon(
                          Icons.folder,
                          color: Colors.white,
                          size: 40,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Choose",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    IconButton(
                        onPressed: () {
                          if (cubit.isPlaying == true) {
                            cubit.stopMusicFormFile();
                          } else {
                            return null;
                          }
                        },
                        icon: cubit.isPlaying
                            ? const Icon(
                                Icons.pause,
                                size: 50,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_circle_outline_sharp,
                                size: 50,
                                color: Colors.white,
                              )),
                  ],
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
