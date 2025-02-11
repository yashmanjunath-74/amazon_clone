import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.white),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              backgroundColor: GlobalVariables.secondaryColor.withOpacity(0.70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}
