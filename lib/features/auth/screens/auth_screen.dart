import 'package:amazon_clone/common/widgets/custom_buttton.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth groupValue = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Cretae an account',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: groupValue,
                  onChanged: (Auth? val) {
                    setState(() {
                      groupValue = val!;
                    });
                  }),
              onTap: () {},
            ),
            if (groupValue == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextfield(
                            controller: _nameController, hintText: 'Name'),
                        const SizedBox(height: 10),
                        CustomTextfield(
                            controller: _emailController, hintText: 'Email'),
                        const SizedBox(height: 10),
                        CustomTextfield(
                            controller: _passwordController,
                            hintText: 'Password'),
                        const SizedBox(height: 10),
                        CustomButtton(text: 'Sign up', onTap: () {})
                      ],
                    )),
              ),
            ListTile(
              title: const Text('Sign in',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: groupValue,
                  onChanged: (Auth? val) {
                    setState(() {
                      groupValue = val!;
                    });
                  }),
              onTap: () {},
            ),
            if (groupValue == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextfield(
                            controller: _emailController, hintText: 'Email'),
                        const SizedBox(height: 10),
                        CustomTextfield(
                            controller: _passwordController,
                            hintText: 'Password'),
                        const SizedBox(height: 10),
                        CustomButtton(text: 'Sign In', onTap: () {})
                      ],
                    )),
              ),
          ],
        ),
      )),
    );
  }
}
