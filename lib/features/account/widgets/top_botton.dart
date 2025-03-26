import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class TopBotton extends StatefulWidget {
  const TopBotton({super.key});

  @override
  State<TopBotton> createState() => _TopBottonState();
}

class _TopBottonState extends State<TopBotton> {
  final AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Order',
              onTap: () {},
            ),
            AccountButton(text: 'Turn Seller', onTap: () {})
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            AccountButton(
                text: 'Log Out', onTap: () => accountServices.logOut(context)),
            AccountButton(text: 'Your Wish List', onTap: () {})
          ],
        )
      ],
    );
  }
}
