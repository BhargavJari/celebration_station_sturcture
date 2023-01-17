import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/colors_utils.dart';
import '../../Utils/fontFamily_utils.dart';

class CustomButton extends StatefulWidget {
  final String? buttonText;
  final Function()? onTap;
  final Color? btnColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  const CustomButton(
      {Key? key,
        this.buttonText,
        this.onTap,
        this.btnColor,
        this.height,
        this.width,
        this.borderColor,
        this.textStyle})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.borderColor ?? ColorUtils.primaryColor,width: 0.5.w),
            color: widget.btnColor ?? ColorUtils.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        height: widget.height ?? 7.h,
        width: widget.width,
        child: Center(
            child: Text(
              widget.buttonText ?? "",
              style: widget.textStyle ?? FontTextStyle.poppinsS14W4WhiteColor,
            )),
      ),
    );
  }
}