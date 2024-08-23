import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
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
import 'helpers/network_connection.dart';
import 'helpers/prefs_helper.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
  // var role = await PrefsHelper.getString(AppConstants.role);
  var userId = await PrefsHelper.getString(AppConstants.userId);
  var userName = await PrefsHelper.getString(AppConstants.userName);
  SocketServices.init();

  // / 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    DeviceUtils.lockDevicePortrait();
    DependencyInjection di = DependencyInjection();
    di.dependencies();
    runApp(MyApp(
      navigatorKey: navigatorKey,
      isLogged: isLogged,
      // role: role,
      userId: userId,
      userName: userName,
    ));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final bool isLogged;
  // final String role;
  final String userId;
  final String userName;
  const MyApp({super.key, required this.navigatorKey, required this.isLogged, required this.userId, required this.userName});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    if(widget.userId.isNotEmpty&&widget.isLogged){
      onUserLogin(widget.userId, widget.userName,  ApiConstants.imageBaseUrl+'');
      debugPrint("User Main login");
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'doctor appointment',
          theme: light(),
          // initialBinding: BindingsBuilder(() {
          //   Get.put(NetworkController());
          // }),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          navigatorKey: widget.navigatorKey,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                child!,
                //
                // /// support minimizing
                ZegoUIKitPrebuiltCallMiniOverlayPage(
                  contextQuery: () {
                    return widget.navigatorKey.currentState!.context;
                  },
                ),
              ],
            );
          },
          home: SplashScreen(),
        ),
        designSize: const Size(393, 852));
  }
}

