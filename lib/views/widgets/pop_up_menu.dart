import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';

class PopUpMenu extends StatelessWidget {
  PopUpMenu(
      {super.key,
      required this.items,
      required this.selectedItem,
      required this.onTap,
      this.height = 30,
      this.selectedColor = AppColors.primaryColor,
      this.unselectedColor = Colors.transparent,
      this.style,
      this.isContainer = false,
      this.iconColor = AppColors.gray767676,
      this.iconData = Icons.keyboard_arrow_down_outlined});

  final List items;
  final String selectedItem;
  final Color selectedColor;
  final Color iconColor;
  final Color unselectedColor;
  final double height;
  final Function(int index) onTap;
  TextStyle? style;
  final bool isContainer;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: selectedColor)),
          offset: const Offset(1, 1),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'option1',
                  child: Column(
                    children: List.generate(
                      items.length,
                      (index) => GestureDetector(
                        onTap: () => onTap(index),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              // Container(
                              //   padding: const EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     border: Border.all(color: selectedColor),
                              //     color: selectedItem == items[index].toString()
                              //         ? selectedColor
                              //         : unselectedColor,
                              //     shape: BoxShape.circle,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 8.w,
                              // ),

                              Expanded(
                                  child: CustomText(
                                      text: items[index].toString(),
                                      fontsize: 12.h,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.start,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          icon: Padding(
            padding: EdgeInsets.only(left: isContainer ? 40.w : 0),
            child: Icon(
              iconData,
              color: iconColor,
              size: height,
            ),
          )),
    );
  }
}

class Controller extends GetxController {}
