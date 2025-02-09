import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopBotton extends StatefulWidget {
  const TopBotton({super.key});

  @override
  State<TopBotton> createState() => _TopBottonState();
}

class _TopBottonState extends State<TopBotton> {
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
            AccountButton(text: 'Log Out', onTap: () {}),
            AccountButton(text: 'Your Wish List', onTap: () {})
          ],
        )
      ],
    );
  }
}
