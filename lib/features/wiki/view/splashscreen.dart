// import 'package:dna/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/features/wiki/view/home/homepage.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/utils/imageurl.dart';
import 'package:tenfins_wiki/utils/string.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
  Get.off(const HomePage());
    });
    super.initState();
  }

  @override
  void dispose() {
    //...
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          Image.asset(
            AppImage.splash,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.wikilogo,
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    appText(
                      title: AppSatring.appName,
                      fontWeight: FontWeight.w700,
                      color: AppColor.whiteColor,
                      fontSize: 3.h,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
