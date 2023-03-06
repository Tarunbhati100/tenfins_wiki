// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

class ViewArticleTablet extends StatefulWidget {
  String tabletTitle;
  var tabletDescription;
  ViewArticleTablet(
      {super.key, required this.tabletTitle, required this.tabletDescription});

  @override
  State<ViewArticleTablet> createState() => _ViewArticleTabletState();
}

class _ViewArticleTabletState extends State<ViewArticleTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: appText(title: widget.tabletTitle),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Html(
          data: widget.tabletDescription,
        ),
      )),
    );
  }
}
