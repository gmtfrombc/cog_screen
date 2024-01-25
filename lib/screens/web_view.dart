import 'package:cog_screen/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

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

    _iframeElement = html.IFrameElement();
    _iframeElement.height = '500px';
    _iframeElement.width = '100%';
    _iframeElement.src = widget.url;
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement-${widget.url.hashCode}', // Unique viewType for each URL
      (int viewId) => _iframeElement,
    );
  }

  @override
  void didUpdateWidget(WebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url) {
      _iframeElement.src = widget.url; // Update the IFrameElement's source
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/pm_icon_full.png',
          fit: BoxFit.cover,
          height: 35,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryBackgroundColor,
        //elevation: elevation,
        //automaticallyImplyLeading: showLeading,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: HtmlElementView(
        key: ValueKey(
            widget.url), // This ensures the widget rebuilds when URL changes
        viewType:
            'iframeElement-${widget.url.hashCode}', // Use the unique viewType here
      ),
    );
  }
}
