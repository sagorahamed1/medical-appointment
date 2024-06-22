import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'inner_widgets/wallet_amount_card.dart';


class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  TextEditingController walletController = TextEditingController();
  TextEditingController profileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.earnings,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w, vertical: 20.h,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WalletAmountCard(
                  title: 'Earned this Month',
                  amount: 5000,
                ),
                WalletAmountCard(
                  title: 'Total Earned',
                  amount: 67000.00,
                )
              ],
            ),
            SizedBox(height: 31.h),
            CustomButton(onpress: (){
              Get.toNamed(AppRoutes.walletWithdrawalScreen);
            }, title: AppString.withdrawEarnings),
            SizedBox(height: 30.h),
            CustomText(
              text: AppString.lastWithdrawal,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontsize: 16.h,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                // (_walletController.walletModel.value.data?.attributes?.length ?? 0) <= 3
                //     ? _walletController
                //     .walletModel.value.data?.attributes?.length
                //     : _walletController.walletModel.value.data?.attributes
                //     ?.sublist(0, 3)
                //     .length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffDEECC5)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 17.w),
                            child: SvgPicture.asset(
                              AppIcons.hand,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Withdrawal',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            SizedBox(height: 6.h),
                            CustomText(
                              text: "2024 Jan 16",
                              fontWeight: FontWeight.w400,
                              fontsize: 10.h,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ///==============================withdrawal Amount ======================>
                            CustomText(
                              text: '-\$1000',
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                            SizedBox(height: 6.h),

                            ///============================Status ===============================>
                            CustomText(
                                text: 'pending',
                                fontWeight: FontWeight.w500,
                                fontsize: 12.h,
                                color: AppColors.primaryColor
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}