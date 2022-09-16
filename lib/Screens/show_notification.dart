import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class ShowNotification extends StatefulWidget {
  final String url;

  const ShowNotification({Key? key, required this.url}) : super(key: key);
  @override
  ShowNotificationState createState() => ShowNotificationState();
}

class ShowNotificationState extends State<ShowNotification> {
  Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    log("url:" + widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/logo.png",
                          width: 35,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Latest News",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 30,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    controller.complete(webViewController);
                  },
                  javascriptChannels: <JavascriptChannel>{},
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                ),
              ),
            ],
          ),
        ));
  }
}
