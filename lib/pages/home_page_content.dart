import 'package:ecom_flutter/widgets/home_appbar.dart';
import 'package:ecom_flutter/widgets/categories_widget.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';
import 'package:ecom_flutter/widgets/items_widget.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidBackground(
      child: SafeArea(
        bottom: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            const HomeAppbar(),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                height: 28,
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 145, 145, 145),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 20, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari produk pilihan',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Categories Product
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                'Kategori Produk',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF173A3A),
                ),
              ),
            ),
            CategoriesWidget(),
          ],
        ),
      ),
    );
  }
}
