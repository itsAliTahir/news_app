import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/Screens/detail/detail_screen.dart';
import 'package:news_app/utils/theme.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/news_model.dart';
import '../../model/provider/data_provider.dart';
import 'package:intl/intl.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  bool _loading = false;
  String word = "the";
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var _scrollController = ScrollController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        appBar: AppBar(
          backgroundColor: themeColor,
          centerTitle: true,
          title: const Text(
            "News World",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            Consumer(builder: (context, ref, child) {
              final AsyncValue<NewsData> newsListAsync =
                  ref.watch(newsProvider);
              return newsListAsync.when(
                data: (data) => SizedBox(),
                error: (error, stackTrace) => IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyHomeScreen(),
                        ));
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.blue,
                    )),
                loading: () => SizedBox(),
              );
            }),
          ],
        ),
        body: Consumer(builder: (context, ref, _) {
          final AsyncValue<NewsData> newsListAsync = ref.watch(newsProvider);
          final categories = ref.watch(categoriesProvider);
          return Column(
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: newsListAsync.when(
                        loading: () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(10, (i) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Icon(
                                    Icons.home,
                                    color: Colors.transparent,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        error: (error, stackTrace) => SizedBox(),
                        data: (data) => _loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      List.generate(categories.length, (i) {
                                    return GestureDetector(
                                      onTap: () async {
                                        _loading = true;
                                        setState(() {});

                                        await ref
                                            .watch(
                                                newsNotifierProvider.notifier)
                                            .setSearchKeyword(categories[i]
                                                .keyword
                                                .toString());
                                        word = ref
                                            .watch(
                                                newsNotifierProvider.notifier)
                                            .newWord;
                                        _loading = false;
                                        print("object");
                                      },
                                      child: DelayedDisplay(
                                        slidingBeginOffset:
                                            Offset(0.7 + (i * 0.2), 0),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: word != "the" && i == 0
                                              ? Icon(
                                                  categories[i].icon,
                                                  color: Colors.blue,
                                                )
                                              : Icon(
                                                  categories[i].icon,
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                      ),
                    ),
                    newsListAsync.when(
                      error: (error, stackTrace) => SizedBox(),
                      loading: () => Center(child: Divider()),
                      data: (data) => Container(
                        margin: const EdgeInsets.all(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Center(child: Divider()),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                color: themeColor,
                                child: word != "the"
                                    ? Text(
                                        categories[0].name.toString(),
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : const Text(
                                        "Trending",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: newsListAsync.when(
                        loading: () => Container(
                          color: themeColor,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        error: (error, stackTrace) => Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Center(
                              child: Text(
                            'Error: Network Connectivity Error, Please check your connection and press the refresh button at top right corner',
                            style: TextStyle(color: Colors.red),
                          )),
                        ),
                        data: (data) {
                          List<News> myData = [];
                          for (int i = 0; i < data.newsData.length; i++) {
                            if (data.newsData[i].image.toString().isNotEmpty)
                              myData.add(data.newsData[i]);
                          }
                          myData.shuffle();

                          return CarouselSlider(
                              options: CarouselOptions(
                                  // height: 400.0,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  autoPlay: true,
                                  enlargeFactor: 0,
                                  autoPlayInterval: const Duration(seconds: 2)),
                              items: [
                                for (int i = 0; i < 4; i++)
                                  Container(
                                    color: themeColor,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            MyDetailScreen(myNews: myData[i]),
                                      )),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: themeColor,
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    myData[i].image.toString(),
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Container(
                                                            color: Colors.grey),
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                width: double.infinity,
                                                height: screenHeight * 0.13,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(0, 0, 0,
                                                          0), // Transparent at the top
                                                      Color.fromARGB(150, 0, 0,
                                                          0), // Semi-transparent in the middle
                                                      Color.fromARGB(
                                                          255,
                                                          20,
                                                          24,
                                                          49), // Darker at the bottom
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      myData[i]
                                                          .title
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 35,
                                              margin: EdgeInsets.all(7),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      225, 0, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                  myData[i].author.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: newsListAsync.when(
                      loading: () => ListView.separated(
                            itemCount: 3,
                            padding: EdgeInsets.only(top: 10),
                            separatorBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider()),
                            itemBuilder: (context, index) => Container(
                              height: 80,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 72,
                                        height: 72,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      error: (error, stackTrace) => SizedBox(),
                      //
                      //
                      data: (data) {
                        List<News> myData = [];
                        for (int i = 0; i < data.newsData.length; i++) {
                          if (data.newsData[i].image.toString().isNotEmpty)
                            myData.add(data.newsData[i]);
                        }
                        return ListView.separated(
                          itemCount: myData.length,
                          padding: const EdgeInsets.only(top: 10),
                          separatorBuilder: (context, index) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: const Divider()),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MyDetailScreen(myNews: myData[index]),
                            )),
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 72,
                                      height: 72,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Hero(
                                        tag: myData[index].image.toString(),
                                        child: Image.network(
                                            myData[index].image.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                                      color: Colors.grey,
                                                    )),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        children: [
                                          Text(myData[index].title.toString()),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Wrap(
                                              children: [
                                                Chip(
                                                  padding: EdgeInsets.all(2),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 221, 221, 221),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  avatar: Icon(
                                                    Icons.person_outline,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    myData[index]
                                                        .author
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Chip(
                                                  padding: EdgeInsets.all(2),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 221, 221, 221),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  avatar: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    DateFormat('MM-dd-yyyy')
                                                        .format(DateTime.parse(
                                                            myData[index]
                                                                .publishDate
                                                                .toString()))
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
