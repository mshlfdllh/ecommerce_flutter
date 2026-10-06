import 'package:ecom_flutter/widgets/cart_appbar.dart';
import 'package:ecom_flutter/widgets/cart_bottomnavbar.dart';
import 'package:ecom_flutter/widgets/cart_itemsamples.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const Color primaryGold = Color(0xFF167B72);
  static const Color textDark = Color(0xFF173A3A);
  static const Color textMuted = Color(0xFF617875);

  int _itemCount = 5;
  int _totalAmount = 5870000;

  void _updateCart(int itemCount, int totalAmount) {
    setState(() {
      _itemCount = itemCount;
      _totalAmount = totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LiquidBackground(
        child: Column(
          children: [
            const CartAppBar(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 14, bottom: 20),
                children: [
                  GlassContainer(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    borderRadius: 20,
                    blur: 18,
                    opacity: 0.58,
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryGold.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: primaryGold,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alamat Pengiriman Utama',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: textDark,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Jl. Sudirman No. 45, Jakarta Selatan',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textMuted,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text('Ubah')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  CartItemsamples(onCartChanged: _updateCart),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CartBottomNavbar(
        itemCount: _itemCount,
        totalAmount: _totalAmount,
      ),
    );
  }
}
