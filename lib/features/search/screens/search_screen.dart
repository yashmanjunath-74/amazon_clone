import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> productList = [];

  SearchServices searchServices = SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchsearchProduct();
  }

  void fetchsearchProduct() async {
    productList = await searchServices.fetchSearchProduct(
        searchQuery: widget.searchQuery, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(widget.searchQuery),
        ),
      ),
    );
  }
}
