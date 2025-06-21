import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Nawawiya extends StatelessWidget {
  const Nawawiya({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..loadRequest(Uri.parse("https://alnawawiforty.com/"));

    return Scaffold(
      appBar: AppBar(title: const Text("فهرس الأربعين النووية")),
      body: WebViewWidget(controller: controller),
    );
  }
}
