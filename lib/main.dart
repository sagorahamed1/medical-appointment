import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/services/firebase_services.dart';
import 'package:doctor_appointment/services/socket_services.dart';
import 'package:doctor_appointment/services/zego_could_services.dart';
import 'package:doctor_appointment/themes/light_theme.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'helpers/binding/dependancy_injaction.dart';
import 'helpers/device_utils.dart';
import 'helpers/prefs_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{


  ///=========zego setup====>
  WidgetsFlutterBinding.ensureInitialized();
   await AuthService.setUpFirebase();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );



    DeviceUtils.lockDevicePortrait();
    DependencyInjection di = DependencyInjection();
    di.dependencies();
    runApp(MyApp(
      navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: widget.navigatorKey,
          title: 'doctor appointment',
          theme: light(),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          // builder: (BuildContext context, Widget? child) {
          //   return Stack(
          //     children: [
          //       child!,
          //       //
          //       // /// support minimizing
          //       ZegoUIKitPrebuiltCallMiniOverlayPage(
          //         contextQuery: () {
          //           return widget.navigatorKey.currentState!.context;
          //         },
          //       ),
          //     ],
          //   );
          // },
          home: SplashScreen(),
        ),
        designSize: const Size(393, 852));
  }
}

