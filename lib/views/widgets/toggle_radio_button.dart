import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleRadioButton extends StatelessWidget {
  final bool toggleValue;
  final VoidCallback onToggle;

  const ToggleRadioButton({
    Key? key,
    required this.toggleValue,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: 40.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(color: Colors.grey),
        color: Colors.green.withOpacity(.25),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            top: 5.0,
            left: toggleValue ? 60.0 : 0.0,
            right: toggleValue ? 0.0 : 60.0,
            child: InkWell(
              onTap: onToggle,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: toggleValue
                    ? Icon(Icons.check_circle, color: Colors.green, key: UniqueKey())
                    : Icon(Icons.highlight_remove_rounded, color: Colors.red, key: UniqueKey()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
