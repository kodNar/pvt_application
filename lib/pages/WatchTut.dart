import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class WatchTut extends StatefulWidget{
  WatchTut({Key key}): super(key:key);
  @override
  _WatchTutState createState() => _WatchTutState();
}
class _WatchTutState extends State<WatchTut> {
  String videoURL ="https://www.youtube.com/watch?v=zaV6gx4Eut4";
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoURL)
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: ('YoutubePlayer'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              YoutubePlayer(
                controller: _controller,
              )
            ],
          ),
        ),
      ),
    );
  }
}








