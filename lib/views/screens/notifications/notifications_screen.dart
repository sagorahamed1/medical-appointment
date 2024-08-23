import 'package:doctor_appointment/controllers/notification_controller.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

import '../../../models/notification_model.dart';
import '../../../utils/app_dimentions.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/custom_text.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {




  final ScrollController _scrollController = ScrollController();
  NotificationController notificationController = Get.put(NotificationController());

  // @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notificationController.loadMore();
        print("load more true");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.notifications,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      ///-----------------------------------body section-------------------------->
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5),
        child: Column(
          children: [

            ///-----------------------notification------------------------>

            Obx((){

              return  Expanded(
                child:
                ListView.builder(
                  itemCount: notificationController.notifications.value.length,
                  itemBuilder : (context, index) {
                    var notification = notificationController.notifications.value[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: _Notification('${notification.message}' , notification.createdAt!),
                    );
                  },
                ),
              );
            }

            ),

          ],
        ),
      ),
    );
  }

  _Notification(String title, DateTime time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration:  const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primaryColor),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 7.w),
                padding: EdgeInsets.all(7.r),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.fillColorE8EBF0),
                child: SvgPicture.asset(
                  AppIcons.notificationbell,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          Expanded(
            // Expanded widget to allow the text to take up available space
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeLarge.h,
                      color: AppColors.textColor5C5C5C,
                      fontFamily: "Aldrich",
                      height: 1.5),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    top: 2.h,

                    text: TimeAgo.format(time),
                    fontsize: Dimensions.fontSizeSmall.h,
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      0xFF8C8C8C,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}