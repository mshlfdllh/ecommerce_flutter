import 'package:flutter/material.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  static const Color primaryGold = Color(0xFF167B72);
  static const Color textDark = Color(0xFF173A3A);
  static const Color textMuted = Color(0xFF617875);

  final List<Map<String, dynamic>> _items = const [
    {
      'title': 'Chronograph Gold Watch',
      'desc': 'Luxury Bezel Edition',
      'price': 'Rp 1.450.000',
      'discount': '-30%',
      'rating': '4.9',
    },
    {
      'title': 'Saffiano Leather Bag',
      'desc': 'Handcrafted Tote',
      'price': 'Rp 2.100.000',
      'discount': '-20%',
      'rating': '5.0',
    },
    {
      'title': 'Classic Oxford Shoes',
      'desc': 'Genuine Calf Leather',
      'price': 'Rp 950.000',
      'discount': '-15%',
      'rating': '4.8',
    },
    {
      'title': 'Silk Jacquard Scarf',
      'desc': 'Autumn Premium Edition',
      'price': 'Rp 420.000',
      'discount': '-50%',
      'rating': '4.9',
    },
    {
      'title': 'Titanium Frame Glasses',
      'desc': 'Anti-Radiation Lens',
      'price': 'Rp 780.000',
      'discount': '-25%',
      'rating': '4.7',
    },
    {
      'title': 'Velvet Evening Blazer',
      'desc': 'Tailored Luxury Fit',
      'price': 'Rp 1.850.000',
      'discount': '-40%',
      'rating': '4.9',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];

        return GlassContainer(
          borderRadius: 20,
          blur: 16,
          opacity: 0.66,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Discount badge & Favorite Heart Icon
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE55656),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item['discount'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF167B72).withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: primaryGold,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Product Image
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/images/img.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_bag_outlined,
                            size: 48,
                            color: primaryGold,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // Product Info & Price
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['desc'] as String,
                      style: const TextStyle(fontSize: 11, color: textMuted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['price'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: primaryGold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 218, 185, 93),
                                primaryGold,
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryGold.withValues(alpha: 0.35),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${item['title']} ditambahkan ke keranjang',
                                  ),
                                  backgroundColor: primaryGold,
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
