// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flashnewsapp/controllers/newsController.dart';
import 'package:flashnewsapp/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewNews extends StatefulWidget {
  final String newsUrl;
  WebViewNews({Key? key, required this.newsUrl}) : super(key: key);

  @override
  State<WebViewNews> createState() => _WebViewNewsState();
}

class _WebViewNewsState extends State<WebViewNews> {
  NewsController newsController = NewsController();

  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar("Flash News", context),
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: WebView(
            initialUrl: widget.newsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              setState(() {
                controller.complete(webViewController);
              });
            },
          ),
        ));
  }
}
