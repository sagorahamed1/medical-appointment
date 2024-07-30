import 'dart:async';
import 'package:doctor_appointment/controllers/messaging/chat_controller.dart';
import 'package:doctor_appointment/controllers/messaging/chat_list_controller.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
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
    super.initState();
  }

  getUserId() async {
    setState(() async {
      currentUserId = await PrefsHelper.getString(AppConstants.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    chatController.getChatList(id: '${Get.parameters['id']}');
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
                () => chatController.getChatLoading.value
                    ? const CustomLoader()
                    : chatController.chatMessages.isEmpty
                        ? CustomText(
                            text: 'no chatyet',
                          )
                        : ListView.builder(
                            reverse: true,
                            controller: _scrollController,
                            dragStartBehavior: DragStartBehavior.down,
                            itemCount: chatController.chatMessages.length,
                            itemBuilder: (context, index) {
                              var message = chatController.chatMessages[index];

                              return message.senderId?.id == currentUserId
                                  ? senderBubble(
                                      context, '${message.content?.message}')
                                  : receiverBubble(
                                      context, '${message.content?.message}');
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
                        suffixIcon: const Icon(Icons.send),
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
  receiverBubble(BuildContext context, String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl:
              "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
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

  senderBubble(BuildContext context, String message) {
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
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTem_2VAfW3H2BtegHsTMUPffW8hvDRPpywu_EM-0U8Nh8j3hagOJzyfNmQKlvBb7gMpc4&usqp=CAU',
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
}
