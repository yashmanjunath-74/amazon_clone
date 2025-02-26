import 'package:amazon_clone/common/widgets/rating.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  final ProductModel product;
  const SearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double avgrating = 0;
    double totalrating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalrating += product.rating![i].rating;

      if (totalrating != 0) {
        avgrating = totalrating / product.rating!.length;
      } else {
        avgrating = 0;
      }
      print(avgrating);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
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
                    child: Rating(rating: avgrating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\u{20B9}${product.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Eligible for FREE Shipping',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
