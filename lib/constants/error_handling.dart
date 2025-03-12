import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  print(response.statusCode);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    onSuccess();
  } else {
    switch (response.statusCode) {
      case 400:
        showSnackBar(context, jsonDecode(response.body)['message']);
        break;
      case 500:
        print(jsonDecode(response.body)['error']);
        showSnackBar(context, jsonDecode(response.body)['error']);
        break;
      default:
        showSnackBar(context, response.body);
    }
  }
}
