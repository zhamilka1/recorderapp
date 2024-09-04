import "package:record/record.dart";
import "dart:io";
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderService {
  final Record audioRecorder = Record();
  String recordedAudioFilePath = "";
  String audioFileExtension = ".wav";

  void start(String audioPath) async {
    const permissionAudio = Permission.audio;
    await permissionAudio.request();
    recordedAudioFilePath = audioPath +
        DateTime.now().millisecondsSinceEpoch.toString() +
        audioFileExtension;
    print(recordedAudioFilePath);
    if (await audioRecorder.hasPermission()) {
      await audioRecorder.start(path: recordedAudioFilePath);
    }
  }

  void resume() async {
    await audioRecorder.resume();
  }

  void pause() async {
    await audioRecorder.pause();
  }

  void stop() async {
    await audioRecorder.stop();
  }

  List<String> getRecAudioList(audioPath) {
    Directory directory = Directory(audioPath);
    List<FileSystemEntity> files = directory.listSync();
    List<String> filenames = [];
    for (var file in files) {
      filenames.add(file.path.replaceAll(audioPath, ""));
    }
    return filenames;
  }
}
