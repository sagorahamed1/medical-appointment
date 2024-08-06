import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controllers/messaging/chat_controller.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../../services/api_constants.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/cachanetwork_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  int maxLine = 1;
  String? selectedImage;
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    getUserId();
    chatController.onInit();
    chatController.listenMessage('${Get.parameters['id']}');
    chatController.scrollController = _scrollController;
    chatController.getChatList(id: '${Get.parameters['id']}');

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          // Reached top
        } else {
          print("====> scroll bottom");
        }
      }
    });
  }

  Future<void> getUserId() async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    setState(() {
      currentUserId = userId;
    });
  }

  @override
  void dispose() {
    chatController.offSocket('${Get.parameters['id']}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Expanded(child: buildMessageList()),
              SizedBox(height: 10.h),
              buildMessageInput()
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: CustomText(
        text: 'Sagor ahamed',
        fontsize: 18.h,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        buildCallButton(isVideoCall: false),
        SizedBox(width: 24.w),
        buildCallButton(isVideoCall: true),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget buildCallButton({required bool isVideoCall}) {
    return currentUserId != null
        ? sendCallButton(
      inviteUserId: '${Get.parameters['id']}',
      name: '${Get.parameters['id']}',
      isVideoCall: isVideoCall,
      onCallFinished: onSendCallInvitationFinished,
    )
        : GestureDetector(
      onTap: () {
        // Navigate to call screen
      },
      child: SvgPicture.asset(
        isVideoCall ? AppIcons.videoCallIcons : AppIcons.call,
        height: 20.h,
        width: 20.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildMessageList() {
    return Obx(
          () => ListView.builder(
        reverse: true,
        controller: _scrollController,
        dragStartBehavior: DragStartBehavior.down,
        itemCount: chatController.chatMessages.value.length,
        itemBuilder: (context, index) {
          var message = chatController.chatMessages[index];
          return message.content?.message == 'fistMessage_klfdpk41324/kd2@367687jkdkjhjhjlajlfjdjdjjdlllncnjdjhfhdhfaiuhajfkajflajkfaahflkhafl'
              ? firstMessage()
              : message.senderId?.id == currentUserId
              ? senderBubble(context, "${message.content?.message}", message.receiverId?.image?.publicFileUrl)
              : receiverBubble(context, "${message.content?.message}", message.senderId?.image?.publicFileUrl);
        },
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildMediaButtons(),
        SizedBox(
          width: 200.w,
          child: TextFormField(
            maxLines: maxLine,
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'Send Messages',
              suffixIcon: GestureDetector(
                onTap: sendMessage,
                child: const Icon(Icons.send),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(16.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
        buildActionButtons(),
      ],
    );
  }

  Row buildMediaButtons() {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.camera, height: 20.h, width: 20.w, fit: BoxFit.cover),
        SizedBox(width: 20.w),
        SvgPicture.asset(AppIcons.voice, height: 20.h, width: 20.w, fit: BoxFit.cover),
        SizedBox(width: 14.w),
      ],
    );
  }

  Row buildActionButtons() {
    return Row(
      children: [
        SizedBox(width: 14.w),
        SvgPicture.asset(AppIcons.attachFile, height: 20.h, width: 20.w, fit: BoxFit.cover),
        SizedBox(width: 20.w),
        SvgPicture.asset(AppIcons.like, height: 20.h, width: 20.w, fit: BoxFit.cover),
      ],
    );
  }

  void sendMessage() {
    chatController.sendMessage(
      messageController.text,
      '${Get.parameters['receiverId']}',
      currentUserId,
      '${Get.parameters['id']}',
    );
    messageController.clear();
  }

  Widget receiverBubble(BuildContext context, String message, String? profileImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl: "${ApiConstants.imageBaseUrl}/$profileImage",
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: AppColors.gray767676, width: 1),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: Colors.white,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message ?? "",
                    style: const TextStyle(color: AppColors.textColor5C5C5C, fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '12:00 am',
                          style: TextStyle(color: AppColors.textColor5C5C5C, fontSize: 12.sp),
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

  Widget senderBubble(BuildContext context, String message, String? profileImage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
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
        SizedBox(width: 4.w),
        CustomNetworkImage(
          imageUrl: '${ApiConstants.imageBaseUrl}/$profileImage',
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: AppColors.gray767676, width: 1),
        ),
      ],
    );
  }

  void onSendCallInvitationFinished(String code, String message, List<String> errorInvitees) {
    if (errorInvitees.isNotEmpty) {
      String userIDs = "";
      for (int index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }
        var userID = errorInvitees.elementAt(index);
        userIDs += '$userID ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }
      var message = 'User doesn\'t exist or is offline: $userIDs';
      if (code.isNotEmpty) {
        message += ', code: $code, message:$message';
      }
      ToastMessageHelper.showToastMessage(message);
    } else if (code.isNotEmpty) {
      ToastMessageHelper.showToastMessage(message);
    }
  }

  Widget firstMessage() {
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

  sendCallButton({
    required bool isVideoCall,
    required String inviteUserId,
    required String name,
    void Function(String code, String message, List<String>)? onCallFinished,
  }) {
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideoCall,
      invitees: [
        ZegoUIKitUser(id: inviteUserId, name: name),
      ],
      resourceID: "zego_call",
      icon: ButtonIcon(
        icon: SvgPicture.asset(
          isVideoCall ? AppIcons.videoCallIcons : AppIcons.call,
          color: AppColors.gray767676,
        ),
      ),
      iconSize: const Size(30, 30),
      buttonSize: const Size(40, 40),
      onPressed: onCallFinished,
    );
  }
}
