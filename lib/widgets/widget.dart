// ignore_for_file: unnecessary_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SizeConfig {
  static getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}

Widget statusBar(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).padding.top,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color: AppColor.primary),
  );
}

Widget appText({
  String? title,
  FontWeight? fontWeight,
  double? fontSize,
  double? letterSpacing,
  FontStyle? fontStyle,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
  double? height,
  decoration,
}) {
  return Text(
    title!,
    textAlign: textAlign,
    style: TextStyle(
        height: height,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Rubik',
        color: color,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        decoration: decoration ?? TextDecoration.none),
    maxLines: maxLines,
  );
}

Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation(AppColor.secondary),
    ),
  );
}

Widget textField2(
    {hint,
    double? borderRadius,
    hight,
    color,
    image,
    maxLines,
    keyboardType,
    validator,
    title,
    minline,
    controller,
    suffixIcon,
    obscureText,
    prefixIcon,
    readOnly,
    onTap,
    inputFormatters,
    horizontalpadding,
    verticalpading,
    onEditingComplete,
    textInputAction,
    onChanged,
    backgroundcolor}) {
  return Column(
    children: [
      Container(
        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFACAAA0)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 7),
          boxShadow: [BoxShadow(color: Colors.blueGrey[50]!, blurRadius: 1)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            cursorColor: AppColor.primary,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            onTap: onTap,
            validator: validator,
            keyboardType: keyboardType,
            controller: controller,
            inputFormatters: inputFormatters,
            autofocus: false,
            textInputAction: textInputAction ?? TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            style: TextStyle(
                fontSize: 14, letterSpacing: 0.2, color: AppColor.black),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              icon: prefixIcon,
              hintText: hint,
              errorMaxLines: 2,
              errorStyle: const TextStyle(fontSize: 10),
              hintStyle:
                  const TextStyle(color: Color(0xFF757570), fontSize: 14),
              border: InputBorder.none,
            ),
            // textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ),
    ],
  );
}

Widget customButton({
  String? title,
  VoidCallback? onTap,
  Color? color,
  Color? borderColor,
  Color? textColor,
  double? margin,
  double? textSize,
  dynamic width,
  dynamic height,
  verticalmargin,
  double? radius,
  Widget? icon,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 4.h,
      width: width ?? 20.w,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(
          horizontal: margin ?? 0, vertical: verticalmargin ?? 9),
      decoration: BoxDecoration(
          color: color ?? AppColor.primary,
          borderRadius: BorderRadius.circular(radius ?? 20),
          border: Border.all(
            color: const Color(0xFFACAAA0),
            style: BorderStyle.solid,
            width: Get.width * 0.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F414E).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: textSize ?? 15,
              color: textColor,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    ),
  );
}

void showMsg(BuildContext context, {String? msg, Color? color}) {
  Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color ?? Colors.black.withOpacity(0.3),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Widget singleViewAppBar(BuildContext context,
    {VoidCallback? leadingontab,
    VoidCallback? trailingontab,
    String? title,
    String? subtitle,
    IconButton? IconButton,
    Widget? trailingIconButton,
    verticalpadding,
    padding}) {
  return Container(
    color: AppColor.primary,
    child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 0, vertical: verticalpadding ?? 5.0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 20.0),
        leading: IconButton ?? const SizedBox(),
        title: Center(
          child: appText(
            title: title ?? '',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColor.whiteColor,
            fontSize: 14,
          ),
        ),
        trailing: trailingIconButton ?? const SizedBox(),
      ),
    ),
  );
}
