import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socialx/pages/home_page.dart';
import 'package:socialx/pages/signup_page.dart';
import 'controller/news_controller.dart';
// ignore: implementation_imports
import 'package:nb_utils/src/utils/system_utils.dart' as nb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("data");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    nb.setStatusBarColor(const Color.fromARGB(255, 219, 9, 9),
        systemNavigationBarColor: const Color.fromARGB(255, 219, 9, 9));

    Get.lazyPut<NewsController>(() => NewsController(), fenix: true);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocailX',
      theme: ThemeData(
        splashColor: Colors.blue,
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const SignupPage(),
    );
  }
}
