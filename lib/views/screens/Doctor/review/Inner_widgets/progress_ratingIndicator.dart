import 'package:doctor_appointment/views/screens/Doctor/review/Inner_widgets/rating_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../utils/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class progressRatingIndicator extends StatelessWidget {
  final String? totalReviews;
  final String? avargeReviews;
  const progressRatingIndicator({
    super.key, this.totalReviews, this.avargeReviews,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.fillColorE8EBF0
      ),

      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
        child: Row(
          children: [
            const Expanded(
                flex: 6,
                child: Column(
                  children: [
                    RatingProgressIndicator(text: '5', value: 0.8,),
                    RatingProgressIndicator(text: '4', value: 0.6,),
                    RatingProgressIndicator(text: '3', value: 0.4,),
                    RatingProgressIndicator(text: '2', value: 0.3,),
                    RatingProgressIndicator(text: '1', value: 0.1,),
                  ],
                )),


            Expanded(
              flex: 2,
              child: Container(
                width: 90.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    CustomText(text: "${avargeReviews?.toString() ?? 0}",fontWeight: FontWeight.w500,fontsize: 30.h,bottom: 8.h),


                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      unratedColor: const Color(0xffC0C0C0),
                      itemCount: 5,
                      // updateOnDrag: true,
                      wrapAlignment: WrapAlignment.start,
                      itemSize: 15.h,
                      itemBuilder: (context, index) {
                        return const Icon(Icons.star,
                            color: Color(0xffFFB701));},
                      onRatingUpdate: (value) {},
                    ),


                    CustomText(text: "$totalReviews Reviews",fontWeight: FontWeight.w500,top: 8.h),
                  ],
                ),
              ),
            )
          ],),
      ),
    );
  }
}