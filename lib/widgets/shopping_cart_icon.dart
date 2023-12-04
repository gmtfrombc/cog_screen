import 'package:cog_screen/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/screens/cart_screen.dart'; // Import your CartScreen

class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        borderRadius:
            BorderRadius.circular(25), // Gives a circular ripple effect

        child: Stack(
          alignment: Alignment.center,
          children: [
            const IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.black,
              ),
              onPressed: null,
            ),
            if (cart.itemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '${cart.itemCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
