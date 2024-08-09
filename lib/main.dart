import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/Screens/home/home_screen.dart';
import 'package:news_app/Screens/splash/splash_screen.dart';
import 'package:news_app/model/news_model.dart';
import 'Screens/detail/detail_screen.dart';
import 'routes.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyDetailScreen(myNews: News()),
      home: MySplashScreen(),
    );
  }
}
