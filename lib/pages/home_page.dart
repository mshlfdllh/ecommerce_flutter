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

  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EE),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePageContent(),
          CartPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 68,
        color: Colors.white,
        buttonBackgroundColor: primaryTerracotta,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOutCubic,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          });
        },
        items: [
          Icon(
            Icons.home_rounded,
            size: 26,
            color: _currentIndex == 0 ? Colors.white : textMuted,
          ),
          Icon(
            Icons.shopping_bag_rounded,
            size: 26,
            color: _currentIndex == 1 ? Colors.white : textMuted,
          ),
          Icon(
            Icons.person_rounded,
            size: 26,
            color: _currentIndex == 2 ? Colors.white : textMuted,
          ),
        ],
      ),
    );
  }
}
