import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/service/home_service.dart';
import 'package:amazon_clone/features/product_deatails/screen/product_deatails_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class CategoryDeals extends StatefulWidget {
  final String categary;
  static const String routeName = '/categary-deals';
  const CategoryDeals({super.key, required this.categary});

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  HomeService homeService = HomeService();
  List<ProductModel> productList = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchCategaryList();
  }

  fetchCategaryList() async {
    productList = await homeService.fetchCategaryProduct(
        context: context, category: widget.categary);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.categary,
              style: TextStyle(fontWeight: FontWeight.w400),
            )),
      ),
      body: productList.isEmpty
          ? Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'keep shopping for ${widget.categary}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      itemCount: productList.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        var product = productList[index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ProductDeatailsScreen.routeName,
                              arguments: product),
                          child: Column(
                            children: [
                              SizedBox(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 1.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 15),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  product.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 15),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  product.price.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
