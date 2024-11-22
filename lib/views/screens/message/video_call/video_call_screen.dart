// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../../../utils/app_dimentions.dart';
// import '../../../../utils/app_icons.dart';
// import '../../../widgets/custom_text.dart';
//
// class VideoCallScreen extends StatelessWidget {
//   const VideoCallScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           image: const NetworkImage(
//               "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630"),
//           fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.5), // Adjust the opacity here
//                   BlendMode.darken,
//                 )
//         )),
//         child: Column(
//           children: [
//             SizedBox(height: 50.h,),
//             ///=====================back button====================>
//             Padding(
//               padding:  EdgeInsets.only(left: 20.w),
//               child: GestureDetector(
//                 onTap: (){
//                   Get.back();
//                 },
//                 child: const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Icon(Icons.arrow_back_ios, color: Colors.white,),
//                 ),
//               ),
//             ),
//             SizedBox(height: 150.h),
//             Container(
//               height: 126.h,
//               width: 126.w,
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: Image.network(
//                 'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             CustomText(
//                 text: "Sagor Ahamed",
//                 fontsize: 24.h,
//                 fontWeight: FontWeight.w500,
//                 top: 16.h,
//                 bottom: 10.h,
//                 color: Colors.white),
//             CustomText(
//                 text: "Ringing", fontsize: 18.h, color: Colors.white),
//             const Spacer(),
//             // CustomText(text: "04 : 59", fontsize: 16.h, color: Colors.black),
//             SizedBox(height: 24.h),
//
//
//
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: Dimensions.paddingSizeDefault.w),
//               child: Container(
//                 height: 60.h,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.r),
//                     color: Colors.white),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//
//                     CallControllerFeature(AppIcons.videoMute, Colors.white, Colors.black),
//                     CallControllerFeature(AppIcons.speaker, Colors.white, Colors.black),
//                     CallControllerFeature(AppIcons.voice, Colors.white, Colors.black),
//                     CallControllerFeature(AppIcons.crossIcon, Colors.white, Colors.red),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 62.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget CallControllerFeature(String icon, Color iconColor, bgColor){
//     return  Container(
//       clipBehavior: Clip.antiAlias,
//       decoration:  BoxDecoration(
//           shape: BoxShape.circle, color: bgColor),
//       child: Padding(
//         padding: EdgeInsets.all(9.r),
//         child: SvgPicture.asset(icon,
//             color: iconColor, height: 20.h, width: 20.w),
//       ),
//     );
//   }
// }
