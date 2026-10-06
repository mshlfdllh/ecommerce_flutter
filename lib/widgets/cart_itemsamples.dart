import 'package:flutter/material.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';

class CartItemsamples extends StatefulWidget {
  const CartItemsamples({super.key, required this.onCartChanged});

  final void Function(int itemCount, int totalAmount) onCartChanged;

  @override
  State<CartItemsamples> createState() => _CartItemsamplesState();
}

class _CartItemsamplesState extends State<CartItemsamples> {
  static const Color primaryGold = Color(0xFF167B72);
  static const Color textDark = Color(0xFF173A3A);
  static const Color textMuted = Color(0xFF617875);

  // Sample dynamic list for interactive cart
  final List<Map<String, dynamic>> _items = [
    {
      'id': 1,
      'title': 'Aura Chronograph Watch',
      'variant': 'Gold Bezel • 42mm',
      'price': 1450000,
      'qty': 1,
      'image': 'assets/images/img.png',
    },
    {
      'id': 2,
      'title': 'Saffiano Leather Tote Bag',
      'variant': 'Cognac Brown • Genuine Leather',
      'price': 2100000,
      'qty': 1,
      'image': 'assets/images/img.png',
    },
    {
      'id': 3,
      'title': 'Oxford Captoe Dress Shoe',
      'variant': 'Espresso • Size 42',
      'price': 950000,
      'qty': 2,
      'image': 'assets/images/img.png',
    },
    {
      'id': 4,
      'title': 'Silk Jacquard Evening Scarf',
      'variant': 'Golden Paisley • 100% Silk',
      'price': 420000,
      'qty': 1,
      'image': 'assets/images/img.png',
    },
  ];

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _incrementQty(int index) {
    setState(() {
      _items[index]['qty']++;
    });
    _notifyCartChanged();
  }

  void _decrementQty(int index) {
    setState(() {
      if (_items[index]['qty'] > 1) {
        _items[index]['qty']--;
      } else {
        _removeItem(index);
      }
    });
    if (_items.isNotEmpty) _notifyCartChanged();
  }

  void _removeItem(int index) {
    final title = _items[index]['title'];
    setState(() {
      _items.removeAt(index);
    });
    _notifyCartChanged();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title dihapus dari keranjang'),
        backgroundColor: textDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _notifyCartChanged() {
    final itemCount = _items.fold<int>(
      0,
      (count, item) => count + item['qty'] as int,
    );
    final totalAmount = _items.fold<int>(
      0,
      (total, item) => total + (item['price'] as int) * (item['qty'] as int),
    );
    widget.onCartChanged(itemCount, totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return GlassContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        borderRadius: 28,
        blur: 22,
        opacity: 0.64,
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFF167B72).withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 42,
                color: primaryGold,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Keranjang Anda Kosong',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: textDark,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Temukan produk pilihan dan tambahkan ke sini.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: textMuted),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home_page');
              },
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: const Text('Jelajahi koleksi'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(_items.length, (index) {
        final item = _items[index];
        final itemTotal = item['price'] * item['qty'];

        return GlassContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          borderRadius: 22,
          blur: 18,
          opacity: 0.62,
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image with rounded border
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F7F2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEDE9DF)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: primaryGold,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item['variant'],
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatCurrency(itemTotal),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: primaryGold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Action buttons: Delete & Stepper
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Delete Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _removeItem(index),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFE55656),
                          size: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Quantity Stepper Pill
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F5EE),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFEAE6DC)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Minus button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _decrementQty(index),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.remove_rounded,
                                size: 14,
                                color: textDark,
                              ),
                            ),
                          ),
                        ),

                        // Qty count
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${item['qty']}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                        ),

                        // Plus button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _incrementQty(index),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 26,
                              height: 26,
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
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
