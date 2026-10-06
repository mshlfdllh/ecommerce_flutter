import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecom_flutter/pages/cart_page.dart';
import 'package:ecom_flutter/pages/account_page.dart';
import 'package:ecom_flutter/pages/home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [HomePageContent(), CartPage(), AccountPage()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        color: const Color(0xFF167B72),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: const [
          Icon(Icons.home_rounded, size: 24, color: Colors.white),
          Icon(Icons.shopping_bag_rounded, size: 24, color: Colors.white),
          Icon(Icons.person_rounded, size: 24, color: Colors.white),
        ],
      ),
    );
  }
}
