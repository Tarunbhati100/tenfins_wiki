// ignore_for_file: camel_case_types, depend_on_referenced_packages, use_build_context_synchronously, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tenfins_wiki/buisness_logic/controller/articleController.dart';
import 'package:tenfins_wiki/presentation/views/addArticle/add_article_desktop.dart';
import 'package:tenfins_wiki/presentation/views/addArticle/add_article_mobile.dart';
import 'package:tenfins_wiki/presentation/views/addArticle/add_article_tablet.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({
    super.key,
  });

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return AddArticleDesktop();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return AddArticleTablet();
        }
        return AddArticleMobile();
      },
    );
  }
}
