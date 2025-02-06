import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    // sign up user
  }) async {
    try {
      User user = User(
        id: '', // ✅ Empty string instead of null
        name: name.isNotEmpty ? name : 'Unknown', // ✅ Provide default
        email: email.isNotEmpty ? email : 'No email',
        password: password,
        adress: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Account created successfully Logine with your credentials');
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
