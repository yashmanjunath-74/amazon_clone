import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screen/orders_screen.dart';
import 'package:amazon_clone/features/admin/screen/product_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarwidth = 48;
  double bottomBarBorderWidth = 5;

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> ListPages = [
    const ProductScreen(),
    const Center(
      child: Text("Analytics page"),
    ),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  //color: Colors.black,
                ),
              ),
              Container(
                child: Text(
                  'Admin',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatepage,
        items: [
          // POSTS
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              )
              // ANALYTICS
              ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarwidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
          ),
          // Cart
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarwidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.all_inbox_outlined),
            ),
          ),
        ],
      ),
      body: ListPages[_page],
    );
  }
}
