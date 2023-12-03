import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/cart_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const Text('Your Cart'),
        backgroundColor:
            AppTheme.primaryBackgroundColor, // Replace with your theme color
        showEndDrawerIcon: true,
        showLeading: true,
      ),
      showDrawer: true,
      showAppBar: true,
      child: cartProvider.items.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (ctx, index) {
                      final productId =
                          cartProvider.items.keys.elementAt(index);
                      final cartItem = cartProvider.items[productId]!;
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                AppTheme.secondaryColor.withOpacity(
                              0.8,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: FittedBox(
                                child: Text(
                                  '\$${cartItem.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(cartItem.title),
                          subtitle: Row(
                            children: [
                              Text(
                                'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                              ),
                              const SizedBox(width: 10),
                              Text('${cartItem.quantity}x'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Remove the item
                              cartProvider.removeItem(productId);
                            },
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/comingsoon');
                      // Implement checkout functionality
                    },
                    child: Text(
                        'Checkout (\$${cartProvider.totalAmount.toStringAsFixed(2)})'),
                  ),
                ),
              ],
            ),
    );
  }
}
