import "package:audioplayers/audioplayers.dart";

class AudioPlayerService {
  final AudioPlayer audioPlayer = AudioPlayer();

  void play(audioFilePath) {
    Source audioFileSource = DeviceFileSource(audioFilePath);
    audioPlayer.play(audioFileSource);
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    audioPlayer.stop();
  }
}
