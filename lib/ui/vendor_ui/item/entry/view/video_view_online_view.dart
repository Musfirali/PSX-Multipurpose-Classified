import 'dart:io';

import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';

class PlayerVideoOnlineView extends StatefulWidget {
  const PlayerVideoOnlineView(this.videoPath);
  final String videoPath;
  @override
  PlayerVideoAndPopPageState<PlayerVideoOnlineView> createState() =>
      PlayerVideoAndPopPageState<PlayerVideoOnlineView>();
}

class PlayerVideoAndPopPageState<T extends PlayerVideoOnlineView>
    extends State<PlayerVideoOnlineView> {
  VideoPlayerController? _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(PsConfig.ps_app_image_url + widget.videoPath));
    _videoPlayerController?.addListener(() {
      // if (startedPlaying && !_videoPlayerController.value.isPlaying) {
      // Navigator.pop(context);
      // _videoPlayerController.play();
      // }
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    if (!_videoPlayerController!.value.isInitialized) {
      await _videoPlayerController?.initialize();
      await _videoPlayerController?.play();
    }

    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /**
     * UI SECTION
     */
    return Stack(
      children: <Widget>[
        Material(
          elevation: 0,
          color: PsColors.achromatic900,
          child: Center(
            child: FutureBuilder<bool>(
              future: started(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == true) {
                  return AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!));
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.black26),
                          backgroundColor: PsColors.achromatic50),
                      const SizedBox(height: PsDimens.space16),
                      Text(
                        'waiting for video to load',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: PsColors.achromatic50),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        Positioned(
            left: PsDimens.space16,
            top: Platform.isIOS ? PsDimens.space60 : PsDimens.space40,
            child: GestureDetector(
              child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.clear, color: PsColors.achromatic50)),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        Positioned(
          bottom: PsDimens.space16,
          right: PsDimens.space16,
          child: FloatingActionButton(
            backgroundColor: PsColors.primary500,
            onPressed: () {
              setState(() {
                _videoPlayerController!.value.isPlaying
                    ? _videoPlayerController?.pause()
                    : _videoPlayerController?.play();
              });
            },
            child: Icon(
              _videoPlayerController!.value.isPlaying
                  ? Icons.pause
                  // ignore: unnecessary_null_comparison
                  : _videoPlayerController!.value.size == null
                      ? Icons.pause
                      : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }
}
