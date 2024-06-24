import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimentions.dart';
import '../../../../widgets/custom_text.dart';


class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key, required this.text, required this.value,
  });

  final String text;
  final double value;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(text: text,
            fontsize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.w400),
        const SizedBox(width: 5,),
        const Icon(Icons.star,
          color: Color(0xffFFB701),
          size: Dimensions.fontSizeSmall),
        const SizedBox(width: 5,),
        Expanded(
            flex: 11,
            child: SizedBox(
              width: 151.w,
              child: LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor: AppColors.fillColorE8EBF0,
                borderRadius: BorderRadius.circular(4.r),
                valueColor: const AlwaysStoppedAnimation(Color(0xffFFB701),),
              ),
            ))
      ],
    );
  }
}