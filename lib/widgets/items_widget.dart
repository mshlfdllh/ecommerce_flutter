import 'package:flutter/material.dart';

class ItemWidgets extends StatelessWidget {
  const ItemWidgets({super.key});

  final List<String> myProductName = const [
    'Pakaian bayi',
    'Makanan bayi',
    'Iphone 14 Pro Max',
    'Buku Sejarah jakarta timur , rawamangun',
    'Labore',
    'Pengharum ruangan',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: myProductName.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Badge Diskonto & Tombol Favorit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '50%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Colors.red,
                  ),
                ],
              ),

              // Gambar Produk
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      'assets/images/img.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Nama Produk
              Tooltip(
                message: myProductName[i],
                child: Text(
                  myProductName[i],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Deskripsi Singkat
              const Text(
                'Deskripsi Produk singkat',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 141, 134, 134),
                ),
              ),

              const Spacer(),

              // Harga & Icon Keranjang
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rp. 100.000',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  // Menggunakan Material + InkWell agar event tap responsive & punya latar belakang
                  Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pushNamed(context, '/cart_page');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.shopping_cart_checkout,
                          size: 20,
                          color: Color.fromARGB(255, 24, 23, 23),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}