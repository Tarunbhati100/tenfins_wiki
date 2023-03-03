// ignore_for_file: camel_case_types, sized_box_for_whitespace, avoid_print
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tenfins_wiki/presentation/views/home/home_page_desktop.dart';
import 'package:tenfins_wiki/presentation/views/home/home_page_mobile.dart';
import 'package:tenfins_wiki/presentation/views/home/home_page_tablet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return const HomePageDesktop();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return const HomePageTablet();
        }

        return const HomePageMobile();
      },
    );
  }
}
