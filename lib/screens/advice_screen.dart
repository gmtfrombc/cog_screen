import 'package:cached_network_image/cached_network_image.dart';
import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/onboarding/dynamic_onboarding_screen.dart';
import 'package:cog_screen/screens/view_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdviceScreen extends StatefulWidget {
  final HealthElement healthElement;
  final String moduleName;
  const AdviceScreen(
      {super.key, required this.healthElement, required this.moduleName});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final double horizontalMargin = 8.0;
  final double verticalMargin = 4.0;
  final EdgeInsets cardPadding = const EdgeInsets.all(8.0);
  final Color cardShadowColor = AppTheme.secondaryColor.withOpacity(0.7);
  bool isLoading = true;
  String userId = '';
  double defaultImageSize = 250.0;
  Map<String, String> imageUrls = {};

  @override
  void initState() {
    super.initState();
    // Add a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isLoading = false; // Set loading to false after the build is complete
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    userId = authProvider.currentUser?.uid ?? '';

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: true,
        showLeading: true,
      ),
      showDrawer: true,
      showAppBar: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
            )
          : _buildAdviceContent((context)),
    );
  }

// plan to use ChatGPT for refactoring this: see _buildAdviceContent, _buildSectionCards, from the chat.
  Widget _buildAdviceContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCards(
              context,
              widget.healthElement.assessments,
              'Assessments',
              _buildTopCard,
              defaultImageSize,
            ),
            _buildSectionCards(
                context,
                widget.healthElement.protocols,
                'Protocols',
                _buildMiddleCard,
                180 // Reduced height for middle cards
                ),
            _buildSectionCards(
              context,
              widget.healthElement.learningCenter,
              'Learning Center',
              _buildMainCard,
              200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCards(
    BuildContext context,
    List<ContentItem> items,
    String sectionTitle,
    Function(BuildContext, ContentItem) buildCardFunction,
    double cardHeight,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: sectionTitle),
        SizedBox(
          height: cardHeight,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return buildCardFunction(context, items[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopCard(
    BuildContext context,
    ContentItem item,
  ) {
    debugPrint(
        'Building top card in AdviceScreen for item: ${item.title} with surveyType: ${item.surveyType}');

    HealthElementImage image =
        findImageForContentItem(item, widget.healthElement.images);
    String imageUrl = image.url ?? '';
    return InkWell(
      onTap: () {
        debugPrint(
            'Navigating to DynamicOnboardingScreen with item: ${item.title} and surveyType: ${item.surveyType}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DynamicOnboardingScreen(
              onboardingContent: item,
            ),
          ),
        );
      },
      child: Container(
        width: defaultImageSize,
        height: defaultImageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          color: item.cardColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                left: 20,
                child: SizedBox(
                  height: 80,
                  width: 210,
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      //letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 70,
                right: 10,
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8.0,
                bottom: 2.0,
                child: Image(
                  image: CachedNetworkImageProvider(imageUrl),
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not available');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleCard(BuildContext context, ContentItem item) {
    double screenWidth = MediaQuery.of(context).size.width;
    HealthElementImage image =
        findImageForContentItem(item, widget.healthElement.images);
    String imageUrl = image.url ?? '';
    return InkWell(
      onTap: () {
        //todo: not all items will have a _handleButtonClick event (i.e. 'isInterested' button click)
        _handleButtonClick();
        Navigator.pushNamed(
          context,
          item.route,
        );
      },
      child: Container(
        width: screenWidth - 20,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 2), // Changes position of shadow
            ),
          ],
        ),
        child: Card(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.0,
                child: Image.network(
                  imageUrl,
                  width: defaultImageSize,
                  height: defaultImageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading image: $error');
                    return const Text('Image not available');
                  },
                ),
              ),
              Positioned(
                //top: 25,
                left: 20,
                bottom: 20,
                child: SizedBox(
                  height: 80,
                  width: 220,
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      //letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 70,
                right: 10,
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
              ),
              const Positioned(
                right: 12.0,
                bottom: 12.0,
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context,
    ContentItem item,
  ) {
    HealthElementImage image =
        findImageForContentItem(item, widget.healthElement.images);
    String imageUrl = image.url ?? '';
    return InkWell(
      onTap: () {
        if (item.url != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewScreen(url: item.url!),
            ),
          );
        } else {
          Navigator.pushNamed(context, item.route);
        }
      },
      child: Container(
        width: 180,
        height: 250, // Set the height of the container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          shadowColor: cardShadowColor,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: CachedNetworkImageProvider(imageUrl),
                  width: double.infinity,
                  height:
                      250, // Ensure the image height matches the container height
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not available'); // Error handling
                  },
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 77,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 0.5, // Border thickness
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0), // Add padding inside the container
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Center the contents horizontally
                      children: [
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.white.withOpacity(0.9),
                          size: 18,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            item.description,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 20,
                child: SizedBox(
                  height: 100,
                  width: 130,
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.9,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Positioned(
                right: 12.0,
                bottom: 12.0,
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonClick() async {
    debugPrint(
        'Handling button click in AdviceScreen for element: ${widget.healthElement.title}');

    HealthElement healthElement = widget.healthElement;
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseService().recordUserAction(userId,
          '${healthElement.title}: Interested'); // Removed the navigation call from here
    } catch (e) {
      debugPrint('Error recording user action: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  HealthElementImage findImageForContentItem(
      ContentItem item, List<HealthElementImage> images) {
    HealthElementImage defaultImage =
        HealthElementImage(name: '', type: '', folder: '', url: null);
    return images.firstWhere(
      (img) {
        return img.name == item.imageUrl;
      },
      orElse: () => defaultImage,
    );
  }
}
