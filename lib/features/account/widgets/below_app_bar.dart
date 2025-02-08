import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Welcome!  ',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
