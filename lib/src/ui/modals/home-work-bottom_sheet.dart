import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class HomeWorkBottomSheet extends StatelessWidget {
  final String detail;

  HomeWorkBottomSheet({this.detail});

  @override
  Widget build(BuildContext context) {
    var document = parse(detail);
    return Container(
      height: 300,
      child: SingleChildScrollView(
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
            Text(document.body.text),
            // WebView(
            //   initialUrl: 'about:blank',
            //   onWebViewCreated: (WebViewController webViewController) {
            //     webViewController.loadUrl(
            //       Uri.dataFromString(
            //         detail,
            //         mimeType: 'text/html',
            //         encoding: Encoding.getByName('utf-8'),
            //       ).toString(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
