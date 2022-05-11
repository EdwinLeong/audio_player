// import 'dart:async';

// import 'package:audio_player/animation.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final AudioPlayer audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   // late Timer timer;

//   // void startTimer() {
//   //   timer = Timer(const Duration(seconds: 20), () async {
//   //     // deleayed code here
//   //     print('delayed execution');
//   //     await audioPlayer.pause();
//   //     _showLoadingDialog(context);
//   //   });
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState

//     audioPlayer.onPlayerStateChanged.listen((state) {
//       print('the state ===>$state');
//       setState(() {
//         isPlaying = state == PlayerState.PLAYING;
//       });
//     });

//     audioPlayer.onDurationChanged.listen((Duration newDuration) {
//       print('Max duration: $newDuration');
//       setState(() {
//         duration = newDuration;
//       });
//     });

//     audioPlayer.onAudioPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//       // print('the position $position');
//     });

//     super.initState();
//   }

//   void _showLoadingDialog(BuildContext context) {
//     // timer.cancel();
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return const AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.0),
//             ),
//           ),
//           content: Text(
//             'Subscribe for Continue',
//             style: TextStyle(fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));

//     return [
//       if (duration.inHours > 0) hours,
//       minutes,
//       seconds,
//     ].join(':');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: Image.network(
//                 'https://images.unsplash.com/photo-1604004555489-723a93d6ce74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Z2lybHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
//                 width: 350,
//                 height: 350,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               'Red Moon',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text('by Diego Nava'),
//             Slider(
//               min: 0.0,
//               max: 100.toDouble(),
//               value: position.inSeconds.toDouble(),
//               onChanged: (value) async {
//                 setState(() {
//                   audioPlayer.seek(Duration(seconds: value.toInt()));
//                 });
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(formatTime(position)),
//                   // Text(formatTime(duration)),
//                   const Text('01:43'),
//                 ],
//               ),
//             ),
//             CircleAvatar(
//               radius: 35,
//               child: IconButton(
//                 iconSize: 50,
//                 icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//                 onPressed: () async {
//                   if (isPlaying) {
//                     await audioPlayer.pause();
//                     // var res = await audioPlayer.pause();
//                     // if (res == 1) {
//                     //   setState(() {
//                     //     isPlaying = false;
//                     //   });
//                     // }
//                   } else {
//                     String url =
//                         "https://assets.mixkit.co/music/preview/mixkit-red-moon-499.mp3";
//                     await audioPlayer.play(url);
//                     // startTimer();
//                     // var res = await audioPlayer.play(url, isLocal: true);
//                     // if (res == 1) {
//                     //   setState(() {
//                     //     isPlaying = true;
//                     //   });
//                     // }
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push<Widget>(
//             context,
//             MaterialPageRoute<Widget>(
//               builder: (BuildContext context) {
//                 return const AnimationPage();
//               },
//             ),
//           );
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
