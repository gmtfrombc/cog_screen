import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class WebView extends StatefulWidget {
  final String url;

  const WebView({super.key, required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late html.IFrameElement _iframeElement;

  @override
  void initState() {
    super.initState();

    // Create an IFrameElement
    _iframeElement = html.IFrameElement()
      ..src = widget.url
      ..style.border = 'none';

    // Attach the iframe element to the DOM
    html.document.body!.append(_iframeElement);
  }

  @override
  void dispose() {
    // Remove the iframe element from the DOM when the widget is disposed
    _iframeElement.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: HtmlElementView(
        viewType: 'iframeElement',
        key: UniqueKey(),
      ),
    );
  }
}
