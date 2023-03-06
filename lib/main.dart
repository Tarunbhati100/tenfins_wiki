import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tenfins_wiki/features/wiki/view/splashscreen.dart';
import 'package:tenfins_wiki/models/article_model.g.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';
import 'package:tenfins_wiki/utils/color.dart';
import 'package:tenfins_wiki/utils/string.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  /// Open box using Hive & Initializ
  await Hive.initFlutter();
  Hive.registerAdapter<Articlemodel>(ArticleModelAdapter());
  await Hive.openBox<Articlemodel>("WikiBox");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginstatus = false;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppSatring.appName,
          theme: ThemeData(
            canvasColor: AppColor.whiteColor,
            primaryColor: AppColor.primary,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
