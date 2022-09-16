import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/categories_post_controller.dart';
import 'dart:math' as math;

class instapost extends StatefulWidget {
  const instapost({Key? key}) : super(key: key);

  @override
  _instapostState createState() => _instapostState();
}

class _instapostState extends State<instapost>
    with SingleTickerProviderStateMixin {
  catgorypostcontroller catgory = catgorypostcontroller();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat();

  var articles;
  bool isloading = true;
  int i = 1;

  @override
  void initState() {
    loadmore();
//
  }

  loadmore() async {
    setState(() {
      isloading = true;
    });
    var ar = await catgory.getalliintapost();

    setState(() {
      articles = ar;
    });
    if (ar.length > 0) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 44,
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              // mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/logo.png",
                      width: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Instagram",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                // Icon(Icons.search_sharp,color:Colors.black,size: 30,)
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Html(
                data: articles['content']['rendered'],
                onLinkTap: (url) async {
                  await launch(url);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
