
// ignore_for_file: file_names, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/color.dart';
import 'common/widget.dart';


class Articel_Screen extends StatelessWidget {
  String? articletitle;
  String?articletitleSubTitle;
   Articel_Screen({super.key, this.articletitle, this.articletitleSubTitle,});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: appText(title: articletitle),
        centerTitle:true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Center(child:appText(title:articletitleSubTitle)),
    );
  }
}