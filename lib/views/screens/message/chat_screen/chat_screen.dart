import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/models/chat_model.dart';
import 'package:doctor_appointment/services/firebase_services.dart';
// import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../controllers/messaging/chat_controller.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../../models/firebase_user_model.dart';
import '../../../../services/api_constants.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/cachanetwork_image.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/custom_text.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:http/http.dart' as http;



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
  RxString? values;
  String? selectedImage;
  String currentUserId = '';
  Uint8List? _image;
  File? selectedIMage;

  AuthService authService = AuthService();



  int progress = 0;
  dynamic downloadId;
  String? status;
  late StreamSubscription progressStream;

  @override
  void initState() {
    super.initState();
    getUserId();
    fetchFirebaseData();

    chatController.onInit();
    chatController.listenMessage('${Get.parameters['id']}');
    chatController.scrollController = _scrollController;
    chatController.getChatList(id: '${Get.parameters['id']}');

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          chatController.loadMore();
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

  FirebaseUserModel? firebaseData;

  fetchFirebaseData() async {
    var userId =
        '${Get.parameters['receiverId']}'; // Replace with your actual userId fetching logic
    var data = await authService.getUserDataById(userId);
    if (data != null) {
      setState(() {
        firebaseData = data;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    chatController.offSocket('${Get.parameters['id']}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('firebase data ========> ${firebaseData?.email}');
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Expanded(child: buildMessageList()),
              SizedBox(height: 10.h),
              Obx(
                () => Column(
                  children: [
                    pickedImages.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child: pickedImages.isEmpty
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          height: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  pickedImages.length + 1,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                if (index ==
                                                    pickedImages.length) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (pickedImages.length <=
                                                          5) {
                                                        showImagePickerOption(
                                                            context);
                                                      } else {
                                                        ToastMessageHelper
                                                            .showToastMessage(
                                                                'You cannot select more than four pictures');
                                                      }
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20.w),
                                                      width: 80.w,
                                                      height: 151.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 40.w,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.w),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 120.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image:
                                                                DecorationImage(
                                                              image: FileImage(
                                                                  pickedImages[
                                                                      index]),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 8.h,
                                                          right: 8.w,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              pickedImages
                                                                  .removeAt(
                                                                      index);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: AppColors
                                                                    .primaryColor,
                                                                size: 18.w,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8.w),
                                        child: GestureDetector(
                                          onTap: () {
                                            chatController.sendMessageWithImage(
                                                pickedImages.isNotEmpty
                                                    ? pickedImages.first
                                                    : null,
                                                '${Get.parameters['receiverId']}',
                                                '${Get.parameters['id']}');
                                            pickedImages.clear();
                                          },
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 24.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          )
                        : buildMessageInput()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: CustomText(
        text: '${Get.parameters["userName"]}',
        fontsize: 18.h,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        actionButton(context, false,
            email: "${firebaseData?.email}",
            name: "${Get.parameters['userName']}"),
        SizedBox(width: 24.w),
        actionButton(context, true,
            email: "${firebaseData?.email}",
            name: "${firebaseData?.firstName}"),
        SizedBox(width: 20.w),
      ],
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
          if (index < chatController.chatMessages.length) {
            var message = chatController.chatMessages[index];
            var isFirstMessage = message.content?.message ==
                'fistMessage_klfdpk41324/kd2@367687jkdkjhjhjlajlfjdjdjjdlllncnjdjhfhdhfaiuhajfkajflajkfaahflkhafl';
            var isCurrentUser = message.senderId?.id == currentUserId;

            print("=====> ${message.senderId?.id}  $currentUserId");

            // Display the special first message if applicable
            if (isFirstMessage) {
              return firstMessage(
                '${message.senderId?.image?.publicFileUrl}',
                isCurrentUser
                    ? "${message.receiverId?.firstName} ${message.receiverId?.lastName}"
                    : "${message.senderId?.firstName} ${message.senderId?.lastName}",
              );
            }

            // Display chat bubbles for regular messages
            return isCurrentUser
                ? senderBubble(
                    context,
                    "${message.content?.message}",
                    message.senderId?.image?.publicFileUrl,
                    message,
                  )
                : receiverBubble(
                    context,
                    "${message.content?.message}",
                    message.senderId?.image?.publicFileUrl,
                    message,
                  );
          } else if (index >= chatController.totalResult) {
            return null;
          } else {
            return const CustomLoader();
          }
        },
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///camara icon====>
        buildMediaButtons(),

        ///input field===>
        SizedBox(
            width: 220.w,
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
            )),

        ///like button====>
        buildActionButtons(),
      ],
    );
  }

  ///===========camara button====>
  Row buildMediaButtons() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showImagePickerOption(context);
          },
          child: SvgPicture.asset(AppIcons.camera,
              height: 20.h, width: 20.w, fit: BoxFit.cover),
        ),
        SizedBox(width: 14.w),
      ],
    );
  }

  ///===========attach file  like button====>
  Row buildActionButtons() {
    return Row(
      children: [
        // SizedBox(width: 14.w),
        // SvgPicture.asset(AppIcons.attachFile,
        //     height: 20.h, width: 20.w, fit: BoxFit.cover),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            messageController.text = '\u{1F44D}';
            sendMessage();
          },
          child: SvgPicture.asset(AppIcons.like,
              height: 20.h, width: 20.w, fit: BoxFit.cover),
        ),
      ],
    );
  }

  void sendMessage() {
    if (messageController.text.isEmpty) {
      ToastMessageHelper.showToastMessage("type some think");
    } else {
      chatController.sendMessage(
        messageController.text,
        '${Get.parameters['receiverId']}',
        currentUserId,
        '${Get.parameters['id']}',
      );
    }
    messageController.clear();
  }

  Widget receiverBubble(BuildContext context, String message,
      String? profileImage, ChatModel chatModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomNetworkImage(
            imageUrl: "${ApiConstants.imageBaseUrl}/$profileImage",
            height: 25,
            width: 25,
            boxShape: BoxShape.circle,
            border: Border.all(color: AppColors.gray767676, width: 1),
          ),
        ),
        SizedBox(width: 5.w),
        chatModel.content?.messageType == 'image'
            ? GestureDetector(
                onTap: () {
                  print("===================================================================== dialog");
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 26.h),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                CustomNetworkImage(
                                    borderRadius: BorderRadius.circular(12.r),
                                    imageUrl:
                                    '${ApiConstants.imageBaseUrl}/${chatModel.file?.publicFileUrl}',
                                    height: 500.h,
                                    width: 300.w)

                              ],
                            ),
                            elevation: 12.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(
                                    width: 1.w, color: AppColors.primaryColor)));
                      });




                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomNetworkImage(
                      borderRadius: BorderRadius.circular(12.r),
                      imageUrl:
                          '${ApiConstants.imageBaseUrl}/${chatModel.file?.publicFileUrl}',
                      height: 200.h,
                      width: 200.w),
                ),
              )
            : message == "\u{1F44D}"
                ? CustomText(
                    text: "$message", textAlign: TextAlign.start, fontsize: 25)
                : Expanded(
                    child: ChatBubble(
                      clipper:
                          ChatBubbleClipper5(type: BubbleType.receiverBubble),
                      backGroundColor: Colors.white,
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.57),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              message ?? "",
                              style: const TextStyle(
                                  color: AppColors.textColor5C5C5C,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    TimeFormatHelper.timeFormat(
                                        chatModel.createdAt!),
                                    style: TextStyle(
                                        color: AppColors.textColor5C5C5C,
                                        fontSize: 12.sp),
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

  Widget senderBubble(BuildContext context, String message,
      String? profileImage, ChatModel chatModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        chatModel.content?.messageType == 'image'
            ? GestureDetector(
          onTap: (){

            print("===================================================================== dialog");

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 12.h),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10.h),


                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (){Get.back();},
                                  child: const Icon(Icons.close, color: AppColors.primaryColor)),

                               GestureDetector(
                                   onTap: (){
                                     downloadImage(imageUrl: "${ApiConstants.imageBaseUrl}/${chatModel.file?.publicFileUrl}");
                                   },
                                   child: const Icon(Icons.arrow_circle_down_sharp, color: AppColors.primaryColor)),

                            ],
                          ),

                          SizedBox(height: 30.h),

                          CustomNetworkImage(
                              borderRadius: BorderRadius.circular(8.r),
                              imageUrl:
                              '${ApiConstants.imageBaseUrl}/${chatModel.file?.publicFileUrl}',
                              height: 400.h,
                              width: double.infinity)
                        ],
                      ),
                      elevation: 12.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                              width: 1.w, color: AppColors.primaryColor)));
                });


          },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomNetworkImage(
                      borderRadius: BorderRadius.circular(12.r),
                      imageUrl:
                          '${ApiConstants.imageBaseUrl}/${chatModel.file?.publicFileUrl}',
                      height: 200.h,
                      width: 200.w),
                ),
            )
            : message == "\u{1F44D}"
                ? Text(
                    "$message",
                    style: const TextStyle(fontSize: 25),
                  )
                : Expanded(
                    child: ChatBubble(
                      clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      backGroundColor: AppColors.primaryColor,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.57),
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
                                TimeFormatHelper.timeFormat(
                                    chatModel.createdAt ?? DateTime.now()),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
        SizedBox(width: 4.w),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomNetworkImage(
            imageUrl: '${ApiConstants.imageBaseUrl}/$profileImage',
            height: 25,
            width: 25,
            boxShape: BoxShape.circle,
            border: Border.all(color: AppColors.gray767676, width: 1),
          ),
        ),
      ],
    );
  }

  Widget firstMessage(String image, name) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        CustomNetworkImage(
            boxShape: BoxShape.circle,
            imageUrl: '${ApiConstants.imageBaseUrl}/$image',
            height: 80.h,
            width: 80.w),
        CustomText(
          text: "$name",
          top: 10,
          bottom: 10,
        ),
        CustomText(
          text: "Started conversation with you",
          top: 10,
          bottom: 10,
        ),
        CustomText(text: '👋', fontsize: 40.h)
      ],
    );
  }

  //==================================> ShowImagePickerOption Function <===============================
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // _pickImageFromGallery();
                        pickImages();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                            ),
                            CustomText(text: 'Gallery')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.w,
                            ),
                            CustomText(text: 'Camera')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker picker = ImagePicker();
  RxList<File> pickedImages = <File>[].obs;

  Future<void> pickImages() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.length <= 10) {
      pickedImages.value = images.map((image) => File(image.path)).toList();
    } else {
      ToastMessageHelper.showToastMessage(
          "Error, You can select up to 10 images.");
    }
  }

//==================================> Camera <===============================
  Future<void> _pickImageFromCamera() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    File selectedImage = File(returnImage.path);
    pickedImages.add(selectedImage);
    _image = selectedImage.readAsBytesSync();
  }

  ZegoSendCallInvitationButton actionButton(BuildContext context, bool isVideo,
      {required String name, required String email}) {
    print('================final paramiter ${email} \n $name');
    return ZegoSendCallInvitationButton(
      invitees: [
        ZegoUIKitUser(
          id: email,
          name: name,
        )
      ],
      buttonSize: const Size(30, 30),
      iconSize: const Size(30, 30),
      unclickableBackgroundColor: AppColors.primaryColor,
      clickableBackgroundColor: AppColors.primaryColor,
      resourceID: 'zegouikit_call',
      isVideoCall: isVideo,
    );
  }



  Future<void> downloadImage({required String imageUrl}) async {
    try{
      String  devicePathToSaveImage= "";
      var time = DateTime.now().microsecondsSinceEpoch;
      if(Platform.isAndroid){
        devicePathToSaveImage = "/storage/emulated/0/Pictures/PmojiGallery$time.svg";
      }else{
        var downloadDirectoryPath = await getApplicationCacheDirectory();
        devicePathToSaveImage = "${downloadDirectoryPath}/PmojiGallery$time.svg";
      }

      File file  = File(devicePathToSaveImage);
      print(file);
      print("***************${imageUrl}");

      var res = await http.get(Uri.parse("$imageUrl"));
      print(res.body);
      if(res.statusCode == 200){
        await file.writeAsBytes(res.bodyBytes);
        await ImageGallerySaverPlus.saveFile(devicePathToSaveImage);
        ToastMessageHelper.showToastMessage("Download Done");
      }
    }catch(e, s){
      print("${e}");
      print("${s}");
    }
  }
}
