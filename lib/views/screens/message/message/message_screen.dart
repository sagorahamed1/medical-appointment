import 'package:doctor_appointment/controllers/messaging/chat_list_controller.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

import '../../../../helpers/prefs_helper.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ChatListController chatListController = Get.put(ChatListController());
  String currentUserId = '';
  String receiverId = '';

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId()  async{
    var userId =  await PrefsHelper.getString(AppConstants.userId);
    setState(()  {
      currentUserId =userId;
    });
  }


  @override
  Widget build(BuildContext context) {
    chatListController.onInit();
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        leading: const SizedBox(),
        title: CustomText(
          text: AppString.message,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault.w,
        ),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(
                () => chatListController.getChatUserLoading.value
                    ? const CustomLoader()
                    : chatListController.chatUsers.isEmpty
                        ? CustomText(text: "No user")
                        : ListView.builder(
                            itemCount: chatListController.chatUsers.length,
                            itemBuilder: (context, index) {
                              var users = chatListController.chatUsers[index];
                              var participants = chatListController.chatUsers[index].participants;

                              if(participants?[0].id != null || participants?[1].id != null){
                                for(var x in participants!){
                                  if(x.id != currentUserId){
                                    receiverId = '${x.id}';
                                  }else{
                                    receiverId = '${x.id}';
                                  }
                                }

                              }

                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.chatScreen, parameters: {
                                        'id' : '${users.id}',
                                        'receiverId' : receiverId,
                                      });
                                    },
                                    child: _messageCard(
                                        '${users.participants?[0].image?.publicFileUrl}',
                                        "${users.participants?[0].firstName} ${users.participants?[0].lastName} (${users.appointmentId?.patientDetailsId?.fullName})",
                                         users.lastMessage?.content?.message ?? '',
                                        "${users.createdAt}")),
                              );
                            },
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _messageCard(String image, name, lastMessage, time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///===============================Image=========================>?
            Container(
              padding: EdgeInsets.only(right: 20.w),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: CustomNetworkImage( imageUrl:  "${ApiConstants.imageBaseUrl}/$image",
                  height: 40.h, width: 40.h,),
            ),

            ///=======================Name and last message ==========================>
            SizedBox(
              width: 175.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "$name",
                      fontsize: 16.h,
                      fontWeight: FontWeight.w600),
                  CustomText(text: "$lastMessage", color: AppColors.gray767676),
                ],
              ),
            )
          ],
        ),

        ///====================time ago======================>
        SizedBox(
          width: 100.w,
          child: CustomText(
            text: TimeAgo.format(DateTime.parse(time)),
            color: AppColors.gray767676,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}
