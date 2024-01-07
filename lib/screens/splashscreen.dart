import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/screens/logins/login.dart';
import 'package:cog_screen/services/firebase_storage_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController
      _pulseController; // New controller for pulsating effect
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _pulseAnimation;
  FirebaseStorageService storageService = FirebaseStorageService();

  bool _isLoadingImages = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0)),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _pulseController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _pulseController.forward();
        }
      });

    _controller.forward();
    _pulseController.forward();

    // Load images and navigate
    _loadImageUrls().then((_) {
      _isLoadingImages = false;
      _pulseController.stop(); // Stop pulsating animation
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          navigateToLoginScreen();
        }
      });
    });
  }

  void navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([_controller, _pulseController]),
              builder: (_, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: Transform.scale(
                    scale: _isLoadingImages
                        ? _pulseAnimation.value
                        : _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                'lib/assets/images/pm_icon_full.png', // Replace with your logo asset path
                width: 300,
                height: 200,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 93,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: const Text(
                  "LABS",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w400, // Thinner font weight
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            if (_isLoadingImages && _controller.isCompleted)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> _loadImageUrls() async {
    try {
      Map<String, String> homeImageUrls =
          await storageService.getModuleImageUrls('Home');
      //debugPrint('Fetched home image URLs: $homeImageUrls');

      List<Future> preloadTasks = [];
      for (HealthElement element in elements) {
        // debugPrint(
        //     'Checking image for ${element.title} with current imagePath: ${element.imagePath}');
        if (homeImageUrls.containsKey(element.imagePath)) {
          String imageUrl = homeImageUrls[element.imagePath]!;
          element.imagePath = imageUrl;
          // debugPrint(
          //     'Updated imagePath for ${element.title}: ${element.imagePath}');
          if (mounted) {
            var preloadTask = precacheImage(NetworkImage(imageUrl), context);
            preloadTasks.add(preloadTask);
            // debugPrint('Preloading image for ${element.title}: $imageUrl');
          }
        } else {
          debugPrint('Error loading image (no image) for ${element.title}');
        }
      }
      await Future.wait(preloadTasks);
      if (mounted) {
        setState(() => _isLoadingImages = false);
      }
    } catch (e) {
      debugPrint('Error loading images: $e');
      if (mounted) {
        // Handle error state if needed
      }
    }
  }
}
