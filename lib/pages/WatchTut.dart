import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutube/flutube.dart';


class WatchTut extends StatefulWidget {
  @override
  WatchTutState createState() => WatchTutState();
}

class WatchTutState extends State<WatchTut> {
  final List<String> playlist = <String>[
    'https://www.youtube.com/watch?v=fq4N0hgOWzU',
    'https://youtu.be/IVTjpW3W33s',
  ];
  int currentPos;
  String stateText;

  @override
  void initState() {
    currentPos = 0;
    stateText = "Video not started";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FluTube Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Youtube video URL: ${playlist[currentPos]}', style: TextStyle(fontSize: 16.0),),
            FluTube.playlist(
              playlist,
              autoInitialize: true,
              aspectRatio: 16 / 9,
              allowMuting: false,
              looping: true,
              deviceOrientationAfterFullscreen: [
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              systemOverlaysAfterFullscreen: SystemUiOverlay.values,
              onVideoStart: () {
                setState(() {
                  stateText = 'Video started playing!';
                });
              },
              onVideoEnd: () {
                setState(() {
                  stateText = 'Video ended playing!';
                  if((currentPos + 1) < playlist.length)
                    currentPos++;
                });
              },
            ),
            Text(stateText),
          ],
        ),
      ),
    );
  }
}












