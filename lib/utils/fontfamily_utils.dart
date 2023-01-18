// FONT FAMILY
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colors_utils.dart';


const String poppinsFamily = "Poppins";


//FONT WEIGHT

class FontWeightClass {
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiB = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraB = FontWeight.w800;
  static const black = FontWeight.w900;
}

class FontTextStyle {
  // Title
  static TextStyle poppinsS32W7WhiteColor = TextStyle(
      fontFamily: poppinsFamily,
      fontSize: 32.sp,
      color: ColorUtils.whiteColor,
      fontWeight: FontWeightClass.bold);

  static TextStyle poppinsS24W7PrimaryColor = TextStyle(
      fontFamily: poppinsFamily,
      fontSize: 24.sp,
      color: ColorUtils.primaryColor,
      fontWeight: FontWeightClass.bold);

  static TextStyle poppinsS14W4PrimaryColor = TextStyle(
      fontFamily: poppinsFamily,
      fontSize: 14.sp,
      color: ColorUtils.primaryColor,
      fontWeight: FontWeightClass.regular);

  static TextStyle poppinsS14W4GreyColor = TextStyle(
      fontFamily: poppinsFamily,
      fontSize: 14.sp,
      color: ColorUtils.grey,
      fontWeight: FontWeightClass.regular);

  static TextStyle poppinsS14HintColor = TextStyle(
      fontFamily: poppinsFamily,
      fontSize: 14.sp,
      color: ColorUtils.labelColor,
      fontWeight: FontWeightClass.regular);

  static TextStyle poppinsS16W7BlackColor = TextStyle(
      fontFamily: poppinsFamily,
      fontSize: 16.sp,
      color: ColorUtils.blackColor,
      fontWeight: FontWeightClass.bold);





  static TextStyle poppinsS12W4PrimaryColor =
  poppinsS24W7PrimaryColor.copyWith(fontSize: 12.sp,fontWeight: FontWeightClass.regular);

  static TextStyle poppinsS14W4WhiteColor =
  poppinsS14HintColor.copyWith(color:ColorUtils.whiteColor);

  static TextStyle poppinsS24W7BlackColor =
  poppinsS24W7PrimaryColor.copyWith(color: ColorUtils.blackColor);

  static TextStyle poppinsS24W7RedColor =
  poppinsS24W7PrimaryColor.copyWith(color: ColorUtils.darkBlueColor);



}