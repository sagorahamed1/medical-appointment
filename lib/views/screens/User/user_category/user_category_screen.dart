import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../controllers/user/home_controller.dart';
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
  int selectedIndex = (-1);
  var categoryName;

  void setSelectedIndex(int index) {
    selectedIndex = index;
  }

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    _homeController.getCetegory();
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.categories,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return _homeController.cetegoryLoading.value
                    ? const CustomLoader()
                    : _homeController.cetegoryLists.isEmpty
                        ? CustomText(
                            text: "No data found",
                          )
                        : ListView.builder(
                            itemCount: (_homeController.cetegoryLists.length / 4).ceil(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(4, (i) {
                                    final itemsIndex = index * 4 + i;
                                    if (itemsIndex < _homeController.cetegoryLists.length) {
                                      final category = _homeController.cetegoryLists[itemsIndex];
                                      bool isSelected = selectedIndex == itemsIndex;
                                      return CategoryCard(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                            categoryName = _homeController.cetegoryLists[index].name;
                                            print("===================================== Cetegory Name : ${category.name}");

                                            Get.toNamed(AppRoutes.useravailablleDoctorsScreen, parameters: {
                                              'category' : "${category.name}"
                                            });

                                        },
                                        categorIcon: category.image?.publicFileUrl,
                                        categorName: category.name,
                                        // isSelected: isSelected,
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                                ),
                              );
                            },
                          );
              }),
            )
          ],
        ),
      ),
    );
  }
}
