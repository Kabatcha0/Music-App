import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

//https://luan.xyz/files/audio/ambient_c_motion.mp3
class Url extends StatelessWidget {
  Url({super.key});
  TextEditingController search = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
                child: Form(
                  key: formkey,
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
                        height: 15,
                      ),
                      Container(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " please enter the URL";
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (s) {
                              if (formkey.currentState!.validate()) {
                                cubit.urlMusic(url: s);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  "done",
                                  textAlign: TextAlign.center,
                                )));
                              }
                            },
                            controller: search,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Search the Music",
                                hintStyle:
                                    const TextStyle(color: Colors.white)),
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      IconButton(
                          onPressed: () {
                            if (cubit.isPlaying == true) {
                              cubit.urlMusicPause();
                            } else if (cubit.isPlaying == false) {
                              cubit.urlMusic(url: search.text);
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
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
