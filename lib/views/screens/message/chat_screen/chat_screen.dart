import 'dart:async';
import 'package:doctor_appointment/controllers/messaging/chat_controller.dart';
import 'package:doctor_appointment/controllers/messaging/chat_list_controller.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/cachanetwork_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  int maxLine = 1;
  String? selectedImage;
  String currentUserId = '';


  @override
  void initState() {
    getUserId();
    chatController.onInit();
    chatController.listenMessage('${Get.parameters['id']}');
    chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);

    chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);
    chatController.scrollController.addListener(() {
      if (chatController.scrollController.position.pixels <=
          chatController.scrollController.position.minScrollExtent) {
      } else if (chatController.scrollController.position.pixels ==
          chatController.scrollController.position.maxScrollExtent) {
        print("====> scroll bottom");
      }
    });

    chatController.getChatList(id: '${Get.parameters['id']}');
    super.initState();
  }

  getUserId()  async{
    var userId =  await PrefsHelper.getString(AppConstants.userId);
    setState(()  {
      currentUserId =userId;
    });
  }

  @override
  void dispose() {
    chatController.offSocket('${Get.parameters['id']}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // chatController.getChatList(id: '${Get.parameters['id']}');

    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: 'Sagor ahamed',
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.audioCallScreen);
              },
              child: SvgPicture.asset(AppIcons.call,
                  height: 20.h, width: 20.w, fit: BoxFit.cover)),
          SizedBox(width: 24.w),
          GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.videoCallScreen);
              },
              child: SvgPicture.asset(AppIcons.videoCallIcons,
                  height: 20.h, width: 20.w, fit: BoxFit.cover)),
          SizedBox(width: 20.w),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  child: Obx(
                () => ListView.builder(
                             reverse: true,
                            controller: _scrollController,
                             dragStartBehavior: DragStartBehavior.down,
                            itemCount: chatController.chatMessages.value.length,
                            itemBuilder: (context, index) {
                              // 'fistMessage_klfdpk41324/kd2@367687jkdkjhjhjlajlfjdjdjjdlllncnjdjhfhdhfaiuhajfkajflajkfaahflkhafl'

                              var message = chatController.chatMessages[index];
                              return
                                message.content?.message == 'fistMessage_klfdpk41324/kd2@367687jkdkjhjhjlajlfjdjdjjdlllncnjdjhfhdhfaiuhajfkajflajkfaahflkhafl'
                                    ? firstMessage() :
                                message.senderId?.id == currentUserId
                                  ? senderBubble(
                                      context, '${message.content?.message}' ,'${message.receiverId?.image?.publicFileUrl}')
                                  : receiverBubble(
                                      context, '${message.content?.message}',"${message.senderId?.image?.publicFileUrl}");
                            }),
              )),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.camera,
                          height: 20.h, width: 20.w, fit: BoxFit.cover),
                      SizedBox(width: 20.w),
                      SvgPicture.asset(AppIcons.voice,
                          height: 20.h, width: 20.w, fit: BoxFit.cover),
                      SizedBox(width: 14.w),
                    ],
                  ),

                  ///======================Input filed=========================>
                  SizedBox(
                    width: 200.w,
                    child: TextFormField(
                      maxLines: maxLine,
                      controller: messageController,
                      onChanged: (value) {
                        // for (var x = 0; x < value.length; x++) {
                        //   print("=====");
                        //   if (x % 18 == 0) {
                        //     maxLine++;
                        //   }
                        // }
                        // print("Max Line: $maxLine");
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Messages',
                        suffixIcon: GestureDetector(
                            onTap: (){
                              ///message, receiverId , senderId, chatId
                              chatController.sendMessage(messageController.text, '${Get.parameters['receiverId']}', currentUserId, '${Get.parameters['id']}'
                              );
                              messageController.clear();
                            },
                            child: const Icon(Icons.send)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(16.r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 14.w),
                      SvgPicture.asset(AppIcons.attachFile,
                          height: 20.h, width: 20.w, fit: BoxFit.cover),
                      SizedBox(width: 20.w),
                      SvgPicture.asset(AppIcons.like,
                          height: 20.h, width: 20.w, fit: BoxFit.cover),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ChatWidget(Map message) {
  receiverBubble(BuildContext context, String message, profileImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl:
              "${ApiConstants.imageBaseUrl}/$profileImage",
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: AppColors.gray767676, width: 1),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: Colors.white,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${message}' ?? "",
                    style: const TextStyle(
                      color: AppColors.textColor5C5C5C,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                    // textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '12:00 am',
                          style: TextStyle(
                            color: AppColors.textColor5C5C5C,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  senderBubble(BuildContext context, String message, profileImage) {
    // print("==============> ${message['message'].runtimeType}");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(
              type: BubbleType.sendBubble,
            ),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${message}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '1:00 am',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        CustomNetworkImage(
          imageUrl:
              '${ApiConstants.imageBaseUrl}/$profileImage',
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: AppColors.gray767676, width: 1),
        ),
      ],
    );
  }

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      messageController.text = returnImage.path;
    });
  }

  Widget firstMessage(){
    return Column(
      children: [
        SizedBox(height: 10.h),
        SvgPicture.asset(AppIcons.appointments),
        CustomText(
          text: "Get started",
          top: 10,
          bottom: 10,
        ),
      ],
    );
  }

  // sendCallButton({
  //   required bool isVideoCall,
  //   required String inviteUserId,
  //   required String name,
  //   void Function(String code, String message, List<String>)? onCallFinished,
  // }){
  //   return ZegoSendCallInvitationButton(
  //     isVideoCall: isVideoCall,
  //     invitees: [
  //       ZegoUIKitUser(
  //         id: inviteUserId,
  //         name: name,
  //       )
  //     ],
  //     resourceID: "zego_call",
  //     icon: ButtonIcon(
  //         icon: SvgPicture.asset(
  //           isVideoCall ? AppIcons.videoCamera : AppIcons.phone,
  //           color: AppColors.green_500,
  //         )),
  //     iconSize: const Size(30, 30),
  //     buttonSize: const Size(40, 40),
  //     onPressed: onCallFinished,
  //   );
  // }


}



