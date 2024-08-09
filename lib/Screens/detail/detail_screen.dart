import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/utils/theme.dart';

import '../../model/news_model.dart';

class MyDetailScreen extends StatefulWidget {
  News myNews;
  MyDetailScreen({super.key, required this.myNews});

  @override
  State<MyDetailScreen> createState() => _MyDetailScreenState();
}

class _MyDetailScreenState extends State<MyDetailScreen> {
  late double pageHeight;
  late double pageWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageHeight = MediaQuery.of(context).size.height;
    pageWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                color: Colors.grey,
                width: pageWidth,
                height: pageHeight * 0.45,
                child: Hero(
                  tag: widget.myNews.image.toString(),
                  child: Image.network(widget.myNews.image.toString(),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey,
                          )),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: DelayedDisplay(
                child: Container(
                  width: pageWidth,
                  height: pageHeight * 0.57,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Wrap(
                          children: [
                            Chip(
                              padding: EdgeInsets.all(2),
                              backgroundColor:
                                  const Color.fromARGB(255, 221, 221, 221),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              avatar: Icon(
                                Icons.person_outline,
                                color: Colors.black,
                                size: 18,
                              ),
                              label: Text(
                                widget.myNews.author.toString(),
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
                                  const Color.fromARGB(255, 221, 221, 221),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              avatar: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                              label: Text(
                                DateFormat(
                                  'MM-dd-yyyy',
                                )
                                    .format(DateTime.parse(
                                        widget.myNews.publishDate.toString()))
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.myNews.title.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.myNews.description.toString(),
                              style: TextStyle(fontWeight: FontWeight.normal),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: Container(
                  width: pageWidth,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0), // Darker at the bottom
                        Color.fromARGB(
                            150, 0, 0, 0), // Semi-transparent in the middle
                        Color.fromARGB(0, 0, 0, 0), // Transparent at the top
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                )),
            Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: themeColor,
                  ),
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.keyboard_arrow_left)),
                )),
          ],
        ),
      ),
    );
  }
}
