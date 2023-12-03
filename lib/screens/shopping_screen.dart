import 'package:cog_screen/models/product_model.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/cart_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/data/product_data.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BaseScreen(
        authProvider: Provider.of<AuthProviderClass>(context, listen: false),
        customAppBar: CustomAppBar(
          title: const Text('Store'),
          showShoppingCartIcon: true,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildCard(context, product);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Product product) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Theme.of(context).cardColor],
                stops: const [0.7, 0.9],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 8.0,
              ),
              child: Text(
                product.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0, // Slightly increase the bottom padding
            left: 8.0,
            right: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  color: Theme.of(context).primaryColor,
                  iconSize: 22,
                  splashRadius: 20,
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addItem(
                      product.id,
                      product.price,
                      product.name,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
