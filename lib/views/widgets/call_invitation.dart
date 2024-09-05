import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../config/config.dart';

class CallInvitation extends StatelessWidget {
  final Widget child;
  final String userName;

  CallInvitation({super.key, required this.child, required this.userName});

  @override
  Widget build(BuildContext context) {
    // Check if userName is not null or empty
    if (userName.isNotEmpty) {
      // Initialize ZegoUIKitPrebuiltCallInvitationService if not already initialized
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: 560511516,
        appSign: "2bcde91d07632d0259f19a974e4f779f26137fca753d99634a559f51287f9706",
        userID: userName,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
    } else {
      print('===============================================\n=======================================Error: userName is null or empty');
    }

    return child;
  }
}
