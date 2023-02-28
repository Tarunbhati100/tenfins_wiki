// import 'package:dna/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../common/widget.dart';
import '../../common/color.dart';
import 'home/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const HomePage()));
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
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(height: height * 0.05),
                    Image.asset(
                      'assets/images/coding.png',
                      height: height * 0.3,
                      width: width * 0.5,
                    ),
                    appText(
                        title: 'HTML Editor App',
                        fontWeight: FontWeight.w700,
                        color: AppColor.whiteColor,
                        fontSize: 20)
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
