import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacter;
  final Color? fillColor;
  // final Widget? prefixIcon;
  final String? labelText;
  final int? maxLines;
  final String? prefixIcon;
  final Widget? sufixicons;
  final String? hintText;
  final dynamic? focusNode;
  final bool? readOnly;
  final double contenpaddingHorizontal;
  final double contenpaddingVertical;
  // final Widget? sufixicons;
  final FormFieldValidator? validator;
  final VoidCallback? onTap;
  final String? helperText;
  final AutovalidateMode? autovalidateMode;
  final Function(String value)? onChanged;

  const CustomTextField({
    super.key,
    required this.contenpaddingHorizontal,
    required this.contenpaddingVertical,
    this.hintText,
    this.prefixIcon,
    this.readOnly = false,
    this.focusNode,
    this.sufixicons,
    this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.obscureCharacter = '*',
    this.fillColor,
    this.labelText,
    this.onTap,
    this.helperText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged, this.maxLines,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onTap: widget.onTap,
      readOnly: widget.readOnly!,
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {});
      },
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isObscureText!,
      autovalidateMode:  widget.autovalidateMode,
      obscuringCharacter: widget.obscureCharacter!,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
      cursorColor: AppColors.primaryColor,
      style:  TextStyle(color: _hasFocusOrText() ? AppColors.primaryColor : Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.contenpaddingHorizontal,
          vertical: widget.contenpaddingVertical,
        ),
        filled: true,
        fillColor: widget.fillColor ?? AppColors.fillColorE8EBF0,
        prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 12.w),
            child: SvgPicture.asset(
             "${widget.prefixIcon}",
              color: _hasFocusOrText()
                  ? AppColors.primaryColor
                  : AppColors.gray767676,
            )),
         suffixIcon: widget.sufixicons,
        helperText: widget.helperText,
        prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
        errorStyle: const TextStyle(color: Colors.red),
        suffixIconColor: _hasFocusOrText() ? AppColors.primaryColor :  AppColors.gray767676,
        prefixIconColor: _hasFocusOrText() ? AppColors.primaryColor : AppColors.gray767676,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle:  const TextStyle(
          color: Color(0xFF5C5C5C),
          fontFamily: 'OpenSans-Regular',
          fontWeight: FontWeight.w400,
        ),
        border: _buildOutlineInputBorder(),
        errorBorder: _buildOutlineInputBorder(),
        focusedBorder: _hasFocusOrText() ? _enabledBorder() : _buildOutlineInputBorder(),
        enabledBorder: _hasFocusOrText() ? _enabledBorder() : _buildOutlineInputBorder(),
        disabledBorder: _hasFocusOrText() ? _enabledBorder() : _buildOutlineInputBorder(),
      ),
    );
  }

  bool _hasFocusOrText() {
    return focusNode.hasFocus || widget.controller.text.isNotEmpty;
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    );
  }
}
