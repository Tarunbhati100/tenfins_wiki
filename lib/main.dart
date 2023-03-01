import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tenfins_wiki/model/databaseModel.dart';
import 'package:tenfins_wiki/presentation/views/splashscreen.dart';
import 'common/color.dart';
import 'model/article_model.g.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();

   await Hive.initFlutter();

  /// Register Hive Adapter
  Hive.registerAdapter<Articlemodel>(ArticleModelAdapter());

  /// Open box
  await Hive.openBox<Articlemodel>("ArticleBox");
  
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
          title: 'Article App',
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
