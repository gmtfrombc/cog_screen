import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/webview.dart'; // Assuming this is your custom WebView for web
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewScreen extends StatefulWidget {
  final String url;
  const ViewScreen({super.key, required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late WebViewController _controller;
  double _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) =>
              setState(() => _loadingProgress = progress / 100),
          onPageFinished: (String url) => setState(() => _loadingProgress = 0),
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) =>
              request.url.startsWith('https://www.youtube.com/')
                  ? NavigationDecision.prevent
                  : NavigationDecision.navigate,
        ))
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar(
      title: const Text('Web View Example'),
      backgroundColor: AppTheme.primaryBackgroundColor,
      bottom: _loadingProgress < 1
          ? PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: LinearProgressIndicator(value: _loadingProgress),
            )
          : null,
    );

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: customAppBar,
      showAppBar: true,
      showDrawer: true,
      child: kIsWeb
          ? WebView(url: widget.url)
          : WebViewWidget(controller: _controller),
    );
  }
}
