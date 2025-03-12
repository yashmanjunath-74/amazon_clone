import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/usermodel.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  void addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!.toString(), // Ensure id is a string
          }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  void rateProduct(
      {required BuildContext context,
      required ProductModel product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!.toString(), // Ensure id is a string
            'rating': rating,
          }));

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
