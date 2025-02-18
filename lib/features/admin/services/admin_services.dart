import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class AdminServices {
  // sell Product service
  void sellProduct({
    required BuildContext context,
    required String productName,
    required double price,
    required double quantity,
    required String description,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dtroxur2z', 'nniuhyjr');
      List<String> imageUrl = [];

      for (int i = 0; i < images.length; i++) {
        try {
          final CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName),
          );

          print("Uploaded Image URL: ${res.secureUrl}"); // Debugging
          imageUrl.add(res.secureUrl);
        } catch (e) {
          if (e is DioException) {
            print("Cloudinary Upload Error: ${e.response?.data}");
          } else {
            print("Cloudinary Upload Error: ${e.toString()}");
          }
          showSnackBar(context, "Image upload failed: ${e.toString()}");
          return; // Stop execution if upload fails
        }
      }
      print("Payload: $imageUrl");

      ProductModel product = ProductModel(
        productName: productName,
        price: price,
        quantity: quantity,
        description: description,
        category: category,
        images: imageUrl,
      );
      print("Payload: ${product.toJson()}");

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all Product
  Future<List<ProductModel>> fetchAllproduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                ProductModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required ProductModel Product,
    required VoidCallback Onsuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': Product.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Onsuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
