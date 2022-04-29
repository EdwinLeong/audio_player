import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState

    audioPlayer.onPlayerStateChanged.listen((state) {
      print('the state ===>$state');
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((Duration newDuration) {
      print('Max duration: $newDuration');
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      // print('the newPosition $newPosition');
      setState(() {
        position = newPosition;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://images.unsplash.com/photo-1604004555489-723a93d6ce74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Z2lybHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Hello Song',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Edwin'),
            Slider(
              min: 0.0,
              max: 100.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                setState(() {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  // Text(formatTime(duration)),
                  const Text('01:41'),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                iconSize: 50,
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () async {
                  audioPlayer.onDurationChanged.listen((Duration newDuration) {
                    print('Max duration 2: $newDuration');
                  });

                  if (isPlaying) {
                    await audioPlayer.pause();
                    // var res = await audioPlayer.pause();
                    // if (res == 1) {
                    //   setState(() {
                    //     isPlaying = false;
                    //   });
                    // }
                  } else {
                    String url =
                        "https://cdn.pixabay.com/download/audio/2022/03/23/audio_07b2a04be3.mp3?filename=order-99518.mp3";
                    await audioPlayer.play(url);
                    // var res = await audioPlayer.play(url, isLocal: true);
                    // if (res == 1) {
                    //   setState(() {
                    //     isPlaying = true;
                    //   });
                    // }
                  }
                },
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
