import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Subtotal extends StatelessWidget {
  const Subtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart.forEach((e) {
      final quantity = e['quantity'] as int?;
      final price = e['product']['price'] as int?;
      if (quantity != null && price != null) {
        sum += quantity * price;
      }
    });

    navigatetoAddressScreen(BuildContext context, int sum) {
      Navigator.pushNamed(context, AddressScreen.routeName,
          arguments: sum.toString());
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Subtotal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\u{20B9} ${sum}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              navigatetoAddressScreen(context, sum);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  GlobalVariables.secondaryColor, // Use your desired color
            ),
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
