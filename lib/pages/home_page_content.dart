import 'package:ecom_flutter/widgets/home_appbar.dart';
import 'package:ecom_flutter/widgets/categories_widget.dart';
import 'package:ecom_flutter/widgets/items_widget.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //Appbar
        HomeAppbar(),
        //search box
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 48,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, size: 25, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Product...',
                    border: InputBorder.none,
                  ),
                ),)
              ]
            ),
          ),
        ),

        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Text('Kategori', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        ),

         const CategoriesWidget(),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Text('Produk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        ),
        const ItemWidgets(),
      
        //Item produk
      ],
    );
  }
}