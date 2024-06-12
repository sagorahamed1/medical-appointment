import 'package:doctor_appointment/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class Categorysection extends StatefulWidget {
   const Categorysection({super.key});

  @override
  State<Categorysection> createState() => _CategorysectionState();
}

class _CategorysectionState extends State<Categorysection> {
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 110.h,
      child: Obx(
            () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categoryController.cetegoryList.sublist(0,4).length,
          itemBuilder: (context, index) {
            var category = _categoryController.cetegoryList[index];
            // bool isSelected = selectedIndex == index;
            return CategoryCard(
              onTap: () {
                setState(() {
                  // setSelectedIndex(index);
                });
              },
              categorIcon: category['categoryIcon'],
              categorName: category['categoryName'],
              // isSelected: isSelected,
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
      onTap: onTap ?? (){},
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(13.r),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE8EBF0)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.5.h, horizontal: 20.w),
                child: SvgPicture.asset(
                  categorIcon!,
                  color: AppColors.primaryColor
                ),
              ),
            ),
          ),
          CustomText(
            text: categorName ?? "",
            fontsize: 12.h,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          )
        ],
      ),
    );
  }
}

