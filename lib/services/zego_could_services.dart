
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/config/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../main.dart';


// Project imports:

// var dataController = Get.put(DataController());

var liveDuration = 30;
var callUserId = "";

/// on user login
// void onUserLogin(String userId, String userName, String image) {
//   /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
//   ZegoUIKitPrebuiltCallInvitationService()
//       .init(
//         appID: 1259129381 /*input your AppID*/,
//         appSign: "c3e52188b93fd378a76c4c5a0f2f0e619ac3e58e570d90a9b96ba5f16d93d6b8" /*input your AppSign*/,
//         userID: userId,
//         userName: userName,
//         plugins: [
//           ZegoUIKitSignalingPlugin(),
//         ],
//         events: ZegoUIKitPrebuiltCallEvents(
//           onCallEnd: (event, defaultAction) {
//             defaultAction.call();
//
//             // if (dataController.userType.value == UserType.Patient.name) {
//             //   sendReview();
//             // }
//           },
//
//           // ,
//         ),
//         notificationConfig: ZegoCallInvitationNotificationConfig(
//           androidNotificationConfig: ZegoCallAndroidNotificationConfig(
//             showFullScreen: true,
//             fullScreenBackground: 'assets/images/call.png',
//             channelID: "ZegoUIKit",
//             channelName: "Call Notifications",
//             sound: "call",
//             icon: "call",
//           ),
//           iOSNotificationConfig: ZegoCallIOSNotificationConfig(
//             systemCallingIconName: 'CallKitIcon',
//           ),
//         ),
//         requireConfig: (ZegoCallInvitationData data) {
//           final config = (data.invitees.length > 1)
//               ? ZegoCallType.videoCall == data.type
//                   ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
//                   : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
//               : ZegoCallType.videoCall == data.type
//                   ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//                   : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
//
//           config.avatarBuilder = (BuildContext context, Size size,
//               ZegoUIKitUser? user, Map extraInfo) {
//             callUserId = user!.id;
//             return CachedNetworkImage(
//               imageUrl: image.isNotEmpty
//                   ? image
//                   : 'https://robohash.org/${user?.id}.png',
//               imageBuilder: (context, imageProvider) => Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: imageProvider,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               progressIndicatorBuilder: (context, url, downloadProgress) =>
//                   CircularProgressIndicator(value: downloadProgress.progress),
//               errorWidget: (context, url, error) {
//                 ZegoLoggerService.logInfo(
//                   '$user avatar url is invalid',
//                   tag: 'live audio',
//                   subTag: 'live page',
//                 );
//                 return ZegoAvatar(user: user, avatarSize: size);
//               },
//             );
//           };
//
//           /// support minimizing, show minimizing button
//           config.topMenuBar.isVisible = true;
//
//           config.topMenuBar.buttons
//               .insert(0, ZegoCallMenuBarButtonName.minimizingButton);
//
//           ///  duration  calculate
//           config.duration.isVisible = true;
//
//           config.duration.onDurationUpdate = (Duration duration) {
//             if (duration.inSeconds == liveDuration * 60) {
//               ZegoUIKitPrebuiltCallController()
//                   .hangUp(navigatorKey.currentState!.context);
//             }
//           };
//
//           return config;
//         },
//       )
//       .then((value) => debugPrint("Zego call login complete"));
// }

/// on user logout
void onUserLogout() {
  /// 5/5. de-initialization ZegoUIKitPrebuiltCallInvitationService when account is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}

sendReview() {
  showDialog(
      context: navigatorKey.currentState!.context,
      builder: (_) => AlertDialog(
          title: const Text(
            "How was your session",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Row(
            children: [
              // _ratingIcon(AppIcons.happy, "Happy", () {
              //   _handleRating("Happy");
              // }),
              // _ratingIcon(AppIcons.natural, "Neutral", () {
              //   _handleRating("Neutral");
              // }),
              // _ratingIcon(AppIcons.sad, "Sad", () {
              //   _handleRating("Sad");
              // }),
            ],
          )));
}

// _handleRating(String ratingType) async {
//   var body = {"rating": ratingType};
//   var response = await ApiClient.postData(
//       ApiConstant.rateTherapist(callUserId), json.encode(body));
//   if (response.statusCode == 201) {
//     Get.back();
//   }
//   Get.back();
// }
//
// _ratingIcon(String icon, title, Function() onTap) {
//   return Column(
//     children: [
//       IconButton(onPressed: onTap, icon: Image.asset(icon)),
//       Text(title)
//     ],
//   );
// }
