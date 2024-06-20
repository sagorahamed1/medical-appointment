import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class AllPrivacyPolicyScreen extends StatelessWidget {
  const AllPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.changePassword,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
