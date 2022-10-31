import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
