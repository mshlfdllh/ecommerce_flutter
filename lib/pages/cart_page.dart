import 'package:ecom_flutter/widgets/cart_appbar.dart';
import 'package:ecom_flutter/widgets/cart_bottomnavbar.dart';
import 'package:ecom_flutter/widgets/cart_itemsamples.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';
import 'package:ecom_flutter/services/cart_service.dart';
import 'package:ecom_flutter/widgets/address_picker_sheet.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  int _itemCount = 4;
  int _totalAmount = 85496000;

  void _updateCart(int itemCount, int totalAmount) {
    setState(() {
      _itemCount = itemCount;
      _totalAmount = totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPushed = Navigator.canPop(context);
    final double bottomPadding = isPushed ? 0 : 70;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EE),
      body: LiquidBackground(
        child: Column(
          children: [
            const CartAppBar(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                children: [
                  if (_itemCount > 0) ...[
                    // Delivery Address & Protection Card
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: borderWarm,
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF211E1B).withOpacity(0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F4EE),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: borderWarm,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.local_shipping_outlined,
                                  color: primaryTerracotta,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Alamat Pengiriman Utama',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      CartService.instance.deliveryAddress,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: textMuted,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  showAddressPickerSheet(context,
                                      onAddressChanged: () {
                                    setState(() {});
                                  });
                                },
                                child: const Text('Ubah'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F4EE),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: borderWarm,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  size: 14,
                                  color: primaryTerracotta,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Gratis Asuransi Pengiriman & Garansi Toko',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: textDark,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],

                  // Cart Items
                  CartItemsamples(onCartChanged: _updateCart),
                ],
              ),
            ),
            if (_itemCount > 0)
              Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: CartBottomNavbar(
                  itemCount: _itemCount,
                  totalAmount: _totalAmount,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
