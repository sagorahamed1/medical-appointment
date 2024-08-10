import 'package:doctor_appointment/controllers/category_controller.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../models/user/cetegory_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class Categorysection extends StatefulWidget {
  List<CetegoryModel> cetegoryList;

  Categorysection({super.key, required this.cetegoryList});

  @override
  State<Categorysection> createState() => _CategorysectionState();
}

class _CategorysectionState extends State<Categorysection> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.cetegoryList.length,
          itemBuilder: (context, index) {
            var category = widget.cetegoryList[index];
            bool isSelected = selectedIndex == index;
            return CategoryCard(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              categorIcon: category.image?.publicFileUrl,
              categorName: category.name,
              isSelected: isSelected,
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String? categorIcon;
  final String? categorName;
  final bool isSelected;
  final Function()? onTap;

  const CategoryCard(
      {super.key,
      this.categorIcon,
      this.categorName,
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.grey : const Color(0xffE8EBF0)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 18.5.h, horizontal: 12.w),
                child: categorIcon?.split('.').last.toLowerCase() == 'svg'
                    ? SvgPicture.network(
                        '${ApiConstants.imageBaseUrl}/$categorIcon',
                        height: 30.h,
                        width: 30.w)
                    : CustomNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}/$categorIcon',
                        height: 30.h,
                        width: 30.w,
                      ),
              ),
            ),
          ),
          SizedBox(
            width: 80.w,
            child: CustomText(
              text: categorName ?? "",
              fontsize: 12.h,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
