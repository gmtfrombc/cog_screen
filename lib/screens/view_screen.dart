import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

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
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _loadingProgress = 0; // Hide progress indicator once page loads
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://powermeacademy.com/lessons/focus-on-fitness/',
        ),
      );
  }

  @override
  @override
  Widget build(BuildContext context) {
    // Instantiate CustomAppBar inside the build method
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
      child: WebViewWidget(controller: _controller),
    );
  }
}
