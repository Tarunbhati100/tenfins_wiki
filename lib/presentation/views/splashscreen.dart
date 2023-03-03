// import 'package:dna/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/SplashBloc/splash_Bloc.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/SplashBloc/splash_Event.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/SplashBloc/splash_State.dart';
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
    splashBloc.add(NavigateToHomeScreenEvent());
    super.initState();
  }

  SplashBloc splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => splashBloc,
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Future.delayed(const Duration(seconds: 2), () {
              Get.to(const HomePage());
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
              body: SafeArea(
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
                          Image.asset(
                            'assets/images/coding.png',
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 2.h,
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
          ));
        },
      ),
    );
  }
}
