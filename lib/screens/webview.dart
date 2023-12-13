import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

class WebView extends StatefulWidget {
  final String url;

  const WebView({Key? key, required this.url}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late html.IFrameElement _iframeElement;
  late Widget _iframeWidget;

  @override
  void initState() {
    super.initState();

    _iframeElement = html.IFrameElement();
    _iframeElement.height = '500';
    _iframeElement.width = '500';
    _iframeElement.src = widget.url;
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iframeWidget;
  }
}
