import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeWorkBottomSheet extends StatelessWidget {
  final String detail;

  HomeWorkBottomSheet({this.detail});

  @override
  Widget build(BuildContext context) {
    print(detail);
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(CupertinoIcons.clear),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: 'about:blank',
              onWebViewCreated: (WebViewController webViewController) {
                webViewController.loadUrl(
                  Uri.dataFromString(
                    detail,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'),
                  ).toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
