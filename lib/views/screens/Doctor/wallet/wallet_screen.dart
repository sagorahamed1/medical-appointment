import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/doctor/wallet_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'inner_widgets/wallet_amount_card.dart';


class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletController walletController = Get.put(WalletController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        walletController.loadMore();
        print("load more true");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    walletController.getEarningMonthly();
    walletController.getWithdrawList();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() =>
                    WalletAmountCard(
                      isAmount: walletController.getEarningMonthlyLoading.value,
                      title: 'Earned this Month',
                      amount: walletController.earnThisMonth.toDouble(),
                    ),
                ),


                Obx(() =>
                    WalletAmountCard(
                      isAmount: walletController.getEarningMonthlyLoading.value,
                      title: 'Total Earned',
                      amount: walletController.totalEarn.toDouble(),
                    ),
                )
              ],
            ),
            SizedBox(height: 31.h),
            CustomButton(onpress: () {
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
              child: Obx(() =>
              walletController.getWithdrawListLoading.value
                  ? const CustomLoader()
                  : walletController.withdrawalList.isEmpty ? Center(
                    child: CustomText(
                    text: "Withdraw not yet"),
                  ) :
              ListView.builder(
                controller: _scrollController,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: walletController.withdrawalList.length+1,
                // (_walletController.walletModel.value.data?.attributes?.length ?? 0) <= 3
                //     ? _walletController
                //     .walletModel.value.data?.attributes?.length
                //     : _walletController.walletModel.value.data?.attributes
                //     ?.sublist(0, 3)
                //     .length,
                itemBuilder: (context, index) {
                  if(index < walletController.withdrawalList.length){
                    var withDraw = walletController.withdrawalList[index];
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 17.w),
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
                                text: TimeFormatHelper.formatDate(
                                    withDraw.createdAt ?? DateTime.now()),
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
                                text: '-\$${withDraw.withdrawAmount}',
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                              SizedBox(height: 6.h),

                              ///============================Status ===============================>
                              ///["Pending", "Completed", "Cancelled"],
                              CustomText(
                                  text: '${withDraw.status}',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 12.h,
                                  color: withDraw.status == 'Completed'
                                      ? AppColors.primaryColor
                                      : withDraw.status == 'Pending'
                                      ? Colors.red
                                      : withDraw.status == 'Pending' ? Colors.red : Colors.black
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }else if(index >= walletController.totalResult){
                    return null;
                  }else {
                   return const CustomLoader();
                  }

                },
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}