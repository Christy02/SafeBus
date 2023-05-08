import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'dart:math';
import 'dart:ui';

class StreamPage extends StatelessWidget {
  final String user = 'Conductor';
  final bool isHost = true;
  const StreamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1657613585,
        appSign:
            "d596cb5739d1d74a95960525e7b70c2567cec7a6e96ed7a177e61989996c281b",
        userID: user,
        userName: user,
        liveID: "liveID",
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
