import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../User_home/Inner_widgets/categorySection.dart';


class UserCategoryScreen extends StatefulWidget {
   UserCategoryScreen({super.key});

  @override
  State<UserCategoryScreen> createState() => _UserCategoryScreenState();
}

class _UserCategoryScreenState extends State<UserCategoryScreen> {
  final CategoryController _categoryController = Get.put(CategoryController());


  int selectedIndex = (-1);

  void setSelectedIndex(int index) {
    selectedIndex = index;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.emergencyDoctors,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w, vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [



            Expanded(
              child: ListView.builder(
                itemCount: (_categoryController.cetegoryList.length / 4).ceil(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (i) {
                        final itemsIndex = index * 4 + i;

                        if (itemsIndex < _categoryController.cetegoryList.length) {
                          final category = _categoryController.cetegoryList[itemsIndex];
                          bool isSelected = selectedIndex == itemsIndex;

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
                        }
                        return const SizedBox();
                      }),
                    ),
                  );
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
