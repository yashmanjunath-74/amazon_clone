import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/service/home_service.dart';
import 'package:amazon_clone/features/product_deatails/screen/product_deatails_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  ProductModel? product;

  HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOftheDay();
  }

  void fetchDealOftheDay() async {
    product = await homeService.fetchDealOftheDay(context: context);
  }

  void navigateToProductDetails() {
    Navigator.pushNamed(context, ProductDeatailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.productName.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: navigateToProductDetails,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal  of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(children: [
                        const Text('₹'),
                        const SizedBox(width: 5),
                        Text(
                          product!.price.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ]),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        product!.productName,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                height: 100,
                                fit: BoxFit.fitWidth,
                                width: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      child: Text(
                        'see all ',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
              );
  }
}
