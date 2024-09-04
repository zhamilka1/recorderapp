import 'package:flutter/material.dart';
import 'package:recorderapp/Services/audio_player_service.dart';
import 'package:recorderapp/Services/audio_recorder_service.dart';
import 'package:recorderapp/env.dart';
import 'package:recorderapp/Components/navigator.dart';

import 'package:recorderapp/Components/my_button.dart';
import 'package:recorderapp/Components/my_button_icon.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final _audioPlayerService = AudioPlayerService();
  final _audioRecorderService = AudioRecorderService();
  final env = Constants();
  String _pathToAudio = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: BottomAppBar(child: PageNavigator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(context: context, builder: recordInterface)
              .then((_) => _audioRecorderService.stop()),
          _audioRecorderService.stop()
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _audioRecorderService
              .getRecAudioList(env.localAudioStoragePath)
              .length,
          itemBuilder: ((context, index) => audioWidgetListElement(
              index,
              _audioRecorderService
                  .getRecAudioList(env.localAudioStoragePath)[index]))),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget audioWidgetListElement(index, pathToAudio) {
    return Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(1),
          margin: const EdgeInsets.all(1),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: MyButtonIcon(
                  onTap: () => {
                    _pathToAudio = env.localAudioStoragePath + pathToAudio,
                    showDialog(context: context, builder: playerInterface)
                        .then((_) => {_audioPlayerService.stop()}),
                    _audioPlayerService.stop()
                  },
                  icon: const Icon(Icons.play_arrow, color: Colors.blueAccent),
                )),
            Expanded(
                flex: 6,
                child: MyButton(
                  text: pathToAudio,
                  onTap: () {},
                ))
          ]),
        ));
  }

  Widget recordInterface(BuildContext context) {
    int recorderState = 0;
    return AlertDialog(
      title: const Row(children: [
        Text("Запись"),
        SizedBox(
          width: 20,
        ),
      ]),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            ElevatedButton(
                onPressed: recorderState == 1
                    ? null
                    : () => {
                          if (recorderState == 0)
                            {
                              setState(() => recorderState = 1),
                              _audioRecorderService
                                  .start(env.localAudioStoragePath)
                            }
                          else
                            {
                              setState(() => recorderState = 1),
                              _audioRecorderService.resume()
                            }
                        },
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.greenAccent,
                )),
            ElevatedButton(
                onPressed: recorderState == 1
                    ? () => {
                          setState(() => recorderState = 2),
                          _audioRecorderService.pause()
                        }
                    : null,
                child: const Icon(
                  Icons.restart_alt,
                  color: Colors.redAccent,
                )),
            ElevatedButton(
                onPressed: recorderState != 0
                    ? () => {
                          setState(() => recorderState = 0),
                          _audioRecorderService.stop()
                        }
                    : null,
                child: const Icon(
                  Icons.save,
                  color: Colors.blueAccent,
                ))
          ],
        );
      }),
    );
  }

  Widget playerInterface(BuildContext context) {
    int playerState = 0;
    return AlertDialog(
      title: const Row(children: [
        Text("Прослушивание"),
        SizedBox(
          width: 20,
        ),
        CloseButton(
          color: Colors.black,
        )
      ]),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            ElevatedButton(
                onPressed: playerState == 1
                    ? null
                    : () => {
                          if (playerState == 0)
                            {
                              setState(() => playerState = 1),
                              _audioPlayerService.play(_pathToAudio)
                            }
                          else
                            {
                              setState(() => playerState = 1),
                              _audioRecorderService.resume()
                            }
                        },
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.greenAccent,
                )),
            ElevatedButton(
                onPressed: playerState == 1
                    ? () => {
                          setState(() => playerState = 2),
                          _audioRecorderService.pause()
                        }
                    : null,
                child: const Icon(
                  Icons.restart_alt,
                  color: Colors.redAccent,
                )),
          ],
        );
      }),
    );
  }
}
