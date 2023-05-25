import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:polyrhythm_web/buffer_screen.dart';
import 'package:polyrhythm_web/constants.dart';
import 'package:polyrhythm_web/custom_shapes/arc.dart';
import 'package:polyrhythm_web/custom_shapes/base_line.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BufferScreen(),
    );
  }
}

class MainCanvas extends StatefulWidget {
  const MainCanvas({
    super.key,
  });

  @override
  State<MainCanvas> createState() => _MainCanvasState();
}

class _MainCanvasState extends State<MainCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  List<AudioPlayer> audioPlayerList = [];
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    animation = Tween(begin: 0.0, end: 60.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
    for (String i in kAudioFiles) {
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.setSourceUrl(i);
      audioPlayerList.add(audioPlayer);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: LinePainter(),
              ),
            ),
            for (int i = 5; i > 0; i--)
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: ArcPainter(
                      index: i,
                      time: animation.value,
                      audioPlayer: audioPlayerList[i - 1]),
                ),
              ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
