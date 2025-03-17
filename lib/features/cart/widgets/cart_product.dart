import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;

  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = ProductModel.fromMap(productCart['product']);

    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
            ),
            // SizedBox(width: 10),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.productName,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\u{20B9}${product.price}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    'Eligible for FREE Shipping',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    'In stock',
                    style: TextStyle(fontSize: 16, color: Colors.teal),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
