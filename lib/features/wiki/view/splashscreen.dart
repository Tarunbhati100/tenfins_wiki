// import 'package:dna/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/features/wiki/bloc/SplashBloc/splash_State.dart';
import 'package:tenfins_wiki/features/wiki/view/home/homepage.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/utils/imageurl.dart';
import 'package:tenfins_wiki/utils/string.dart';
import 'package:tenfins_wiki/widgets/widget.dart';

import '../bloc/SplashBloc/splash_Bloc.dart';
import '../bloc/SplashBloc/splash_Event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc splashBloc = SplashBloc();
  @override
  void initState() {
    
    splashBloc.add(NavigateToHomeScreenEvent());
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
      body: BlocProvider(
        create: (context) => splashBloc,
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
         if(state is LoadedState){
        Future.delayed(const Duration(seconds: 3), () {
         Get.off(const HomePage());
    });
         }
          },
          builder: (context, state) {
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primary,
                      AppColor.black,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
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
                            height: 3.h,
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
                ));
          },
        ),
      ),
    );
  }

}