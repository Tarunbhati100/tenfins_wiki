// ignore_for_file: camel_case_types, depend_on_referenced_packages, use_build_context_synchronously, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tenfins_wiki/features/wiki/bloc/ArticleBloc/article.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article_desktop.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article_mobile.dart';
import 'package:tenfins_wiki/features/wiki/view/addarticle/add_article_tablet.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';

class AddArticlePage extends StatefulWidget {
  bool? newArticle;
  bool? oldArticle;
  int? index;
  Articlemodel? articlemodel;
  AddArticlePage({
    super.key,
    this.newArticle,
    this.oldArticle,
    this.articlemodel,
    this.index,
  });

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  Article addArticleController = Get.put(Article());

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return AddArticleDesktop(
            NewDesktopArticle:
                widget.newArticle == true && widget.oldArticle == false
                    ? true
                    : false,
            DesktopIndex: widget.index,
            articleModel: widget.articlemodel,
          );
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return AddArticleTablet(
            newTabletArticle:
                widget.newArticle == true && widget.oldArticle == false
                    ? true
                    : false,
            tabletIndex: widget.index,
            articleModel: widget.articlemodel,
          );
        }
        return AddArticleMobile(
          NewMobileArticle:
              widget.newArticle == true && widget.oldArticle == false
                  ? true
                  : false,
          mobileIndex: widget.index,
          articleModel: widget.articlemodel,
        );
      },
    );
  }
}
