import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/cubit/states.dart';

class MusicAppCubit extends Cubit<MusicAppStates> {
  MusicAppCubit() : super(MusicAppInitialState());
  static MusicAppCubit get(context) => BlocProvider.of(context);
  Duration currentDuration = Duration();
  Duration allDuration = Duration();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();
  bool isPlaying = false;
  void playMusic() async {
    await player.setSource(AssetSource("shakira.mp3"));
    emit(MusicAppPlayState());
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
