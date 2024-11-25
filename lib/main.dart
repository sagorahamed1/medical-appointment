import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/services/firebase_services.dart';
import 'package:doctor_appointment/services/socket_services.dart';
import 'package:doctor_appointment/services/zego_could_services.dart';
import 'package:doctor_appointment/themes/light_theme.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/constants.dart';
import 'package:doctor_appointment/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'helpers/binding/dependancy_injaction.dart';
import 'helpers/device_utils.dart';
import 'helpers/prefs_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.publishAbleKey;
  try {
    await AuthService.setUpFirebase();
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
    await ZegoUIKit().initLog();
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([ZegoUIKitSignalingPlugin()]);

    DeviceUtils.lockDevicePortrait();

    DependencyInjection di = DependencyInjection();
    di.dependencies();

    runApp(MyApp(navigatorKey: navigatorKey));
  } catch (e) {
    // Handle initialization errors
    print(' =-----------------------Initialization error: -----------$e');
  }
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
      designSize: const Size(393, 852),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: widget.navigatorKey,
        title: 'Doctor Appointment',
        theme: light(),
        initialRoute: AppRoutes.splashScreen,
        getPages: AppRoutes.routes,
        home: SplashScreen(),
        // Uncomment and adjust if using overlay
        // builder: (BuildContext context, Widget? child) {
        //   return Stack(
        //     children: [
        //       child!,
        //       ZegoUIKitPrebuiltCallMiniOverlayPage(
        //         contextQuery: () {
        //           return widget.navigatorKey.currentState!.context;
        //         },
        //       ),
        //     ],
        //   );
        // },
      ),
    );
  }
}



class ConnectivityService extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  ConnectivityService() {
    // Initialize connectivity status and set up a listener for connectivity changes.
    _initializeConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print("================change connection ${result}");
      _updateConnectionStatus(result);
    });
  }

  Future<void> _initializeConnectivity() async {
    // Check the initial connectivity status
    final status = await _connectivity.checkConnectivity();
    isConnected.value = status != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    // Update the connectivity status based on the result
    isConnected.value = result != ConnectivityResult.none;
  }
}
