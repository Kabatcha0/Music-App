import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/layout/cubit/states.dart';
import 'package:musicapp/modules/file.dart';
import 'package:musicapp/modules/homescreen.dart';
import 'package:musicapp/modules/url.dart';

class MusicAppCubit extends Cubit<MusicAppStates> {
  MusicAppCubit() : super(MusicAppInitialState());
  static MusicAppCubit get(context) => BlocProvider.of(context);
  Duration currentDuration = Duration();
  Duration allDuration = Duration();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();
  bool isPlaying = false;
  int index = 0;
  int indexChangeSong = 0;
  List<Widget> screens = [MusicApp(), FilePhone(), Url()];
  List<String> music = [
    "shakira.mp3",
    "lelly.mp3",
    "bteb3diny.mp3",
    "shamandoura.mp3"
  ];
  FilePickerResult? result;
  // String file = '';
  void changeSongPlus() async {
    isPlaying = true;
    indexChangeSong++;
    await player.play(AssetSource(music[indexChangeSong]));

    emit(MusicAppChangeSongPlus());
  }

  bool disposeSong = false;
  void dispose() {
    player.dispose();
    isPlaying = false;
    disposeSong = true;
    emit(DisposeState());
  }

  File? file;
  String stringFile = "";
  openFile() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null) {
      stringFile = result!.files.single.path.toString();
      file = File(result!.files.single.path.toString());
      print(stringFile);
    }
    // emit(MusicAppPlayopenFileState());
    return stringFile;
  }

  void urlMusic({required url}) async {
    await player.play(UrlSource(url)).then((value) {
      isPlaying = true;
      emit(UrlMusicState());
    }).catchError((onError) {
      print(onError.toString());
      emit(MusicAppUrkErrorState());
    });
  }

  void urlMusicPause() async {
    await player.stop();
    isPlaying = false;

    emit(UrlMusicPauseState());
  }

  void agian() async {
    disposeSong = false;
    await player.play(AssetSource(music[indexChangeSong]));
    emit(AgainState());
  }

  void changeSongNegative() async {
    isPlaying = true;
    indexChangeSong--;

    await player.play(AssetSource(music[indexChangeSong]));
    emit(MusicAppChangeSongNegative());
  }

  void onTap(int i) {
    index = i;
    emit(BottomNavigation());
  }

  void playMusic() async {
    await player.setSource(AssetSource("shakira.mp3"));
    emit(MusicAppPlayState());
  }

  void playMusicFormFile({required String url}) async {
    isPlaying = true;
    await player.play(DeviceFileSource(url));
    emit(MusicAppPlayFileState());
  }

  void stopMusicFormFile() async {
    isPlaying = false;

    await player.stop();
    emit(MusicAppStopFileState());
  }

  void tapMusic() async {
    await player.resume();
    isPlaying = true;
    emit(MusicAppResumeState());
  }

  void pauseMusic() async {
    await player.pause();
    isPlaying = false;
    emit(MusicAppPauseState());
  }

  void stopMusic() async {
    await player.stop();
    isPlaying = false;
    emit(MusicAppPauseState());
  }

  void songChange() {
    player.onPositionChanged.listen((event) {
      currentDuration = event;
      emit(MusicAppChangelState());
    });
  }

  void tallOfsong() {
    player.onDurationChanged.listen((event) {
      allDuration = event;
      emit(MusicAppTallState());
    });
  }

  void seek(int s) {
    player.seek(Duration(seconds: s));
    emit(MusicAppSeekState());
  }
}
