// ignore_for_file: camel_case_types, depend_on_referenced_packages, use_build_context_synchronously, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article_desktop.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article_mobile.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article_tablet.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';

class AddArticlePage extends StatefulWidget {
  final bool? type;
  final int? index;
  final Articlemodel? articleData;
  AddArticlePage({super.key, this.type, this.index, this.articleData});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return AddArticleDesktop(
            type: widget.type,
            index: widget.index,
            articleData: widget.articleData,
          );
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return AddArticleTablet(
            type: widget.type,
            index: widget.index,
            articleData: widget.articleData,
          );
        }
        return AddArticleMobile(
          type: widget.type,
          index: widget.index,
          articleData: widget.articleData,
        );
      },
    );
  }
}
