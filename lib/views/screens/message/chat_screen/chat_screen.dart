import 'dart:async';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
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
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/cachanetwork_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final StreamController _streamController = StreamController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  List messageList = [
    {"name": "Alice", "status": "sender", "message": "Hey there!"},
    {"name": "Bob", "status": "receiver", "message": "Hi, what's up?"},
    {"name": "Charlie", "status": "sender", "message": "Just checking in."},
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!"
    },
    {"name": "Eve", "status": "sender", "message": "Cool."},
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?"
    },
    {"name": "Alice", "status": "sender", "message": "Hey there!"},
    {"name": "Bob", "status": "receiver", "message": "Hi, what's up?"},
    {"name": "Charlie", "status": "sender", "message": "Just checking in."},
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!"
    },
    {"name": "Eve", "status": "sender", "message": "Cool."},
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?"
    },
  ];

  String? selectedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      // If you want a smooth scroll animation instead of jumping directly, use animateTo:
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: (){
                Get.toNamed(AppRoutes.audioCallScreen);
              },
              child: SvgPicture.asset(AppIcons.call, height: 20.h,width: 20.w,fit: BoxFit.cover)),
          SizedBox(width: 24.w),
          GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.videoCallScreen);
              },
              child: SvgPicture.asset(AppIcons.videoCallIcons, height: 20.h,width: 20.w,fit: BoxFit.cover)),
          SizedBox(width: 20.w),
        ],
      ),


      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (true) {
                      return ListView.builder(
                          controller: _scrollController,
                          dragStartBehavior: DragStartBehavior.down,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            var message = messageList[index];

                            return message['status'] == "sender"
                                ? senderBubble(context, message)
                                : receiverBubble(context, message);
                          });
                    }
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.camera, height: 20.h,width: 20.w,fit: BoxFit.cover),
                      SizedBox(width: 20.w),
                      SvgPicture.asset(AppIcons.voice, height: 20.h,width: 20.w,fit: BoxFit.cover),
                      SizedBox(width: 14.w),
                    ],
                  ),


                  ///======================Input filed=========================>
                  SizedBox(
                    width: 200.w,
                    child: CustomTextField(
                      hintText: "Send Messages",
                      controller: messageController,
                      contenpaddingHorizontal: 1,
                      contenpaddingVertical: 0,

                      sufixicons: const Icon(Icons.send, color: AppColors.primaryColor),
                    ),
                  ),
                  //
                  // GestureDetector(
                  //   onTap: () {
                  //     Map<String, dynamic> newMessage = {
                  //       "name": "John",
                  //       "status": "sender",
                  //       "message": messageController.text,
                  //     };
                  //
                  //     if (messageController.text.isNotEmpty) {
                  //       messageList.add(newMessage);
                  //       _streamController.sink.add(messageList);
                  //
                  //       messageController.clear();
                  //     }
                  //   },
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: AppColors.primaryColor),
                  //           borderRadius: BorderRadius.circular(8.r)),
                  //       child: Padding(
                  //         padding: EdgeInsets.all(11.r),
                  //         child: SvgPicture.asset(AppIcons.appointments),
                  //       )),
                  // ),


                  Row(
                    children: [
                      SizedBox(width: 14.w),
                      SvgPicture.asset(AppIcons.attachFile, height: 20.h,width: 20.w,fit: BoxFit.cover),
                      SizedBox(width: 20.w),
                      SvgPicture.asset(AppIcons.like, height: 20.h,width: 20.w,fit: BoxFit.cover),

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
  receiverBubble(BuildContext context, Map message) {
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
                    '${message['message']}' ?? "",
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

  senderBubble(BuildContext context, Map message) {
    print("==============> ${message['message'].runtimeType}");
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
                    '${message['message']}' ?? "",
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
