import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:responsivedashboard/ui/Screens/Stream/constant.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: MyConst.appId,
      appSign: MyConst.appSign,
      userID: MyConst.UserId,
      userName: MyConst.name,
      callID: MyConst.callID,

      // Modify your custom configurations here.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..turnOnCameraWhenJoining = false
        ..turnOnMicrophoneWhenJoining = true
        ..useSpeakerWhenJoining = true,
    );
  }
}
