import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/utils/theme.dart';
import '../../model/provider/data_provider.dart';
import '../home/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    // No need to set a timer here; we'll handle navigation based on the provider's state.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<NewsData> newsListAsync = ref.watch(newsProvider);

            return newsListAsync.when(
              data: (newsList) {
                // Navigate to the home screen once the data is loaded
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MyHomeScreen(),
                    ),
                  );
                });

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/news_loading.png"),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to News World',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
              loading: () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/news_loading.png"),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: themeColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              error: (error, stack) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/news_loading.png",
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Network Error, Please Restart The App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
