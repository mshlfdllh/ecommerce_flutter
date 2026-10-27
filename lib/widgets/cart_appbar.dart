import 'package:flutter/material.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';
import 'package:ecom_flutter/services/cart_service.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: GlassContainer(
          borderRadius: 24,
          blur: 16,
          opacity: 0.88,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              // Back button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacementNamed(context, '/home_page');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: borderWarm,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: textDark,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Title
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Keranjang Belanja',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'Pilihan Gadget Sehari-hari',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Trailing Options
              PopupMenuButton<String>(
                color: Colors.white,
                onSelected: (value) {
                  if (value == 'clear') {
                    CartService.instance.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Keranjang telah dikosongkan'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: borderWarm,
                    ),
                  ),
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    size: 20,
                    color: textDark,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: const BorderSide(
                    color: borderWarm,
                  ),
                ),
                elevation: 10,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'promo',
                    child: Row(
                      children: [
                        Icon(Icons.discount_outlined, size: 18, color: primaryTerracotta),
                        SizedBox(width: 10),
                        Text('Kupon & Voucher', style: TextStyle(color: textDark)),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: Color(0xFFDC2626)),
                        SizedBox(width: 10),
                        Text('Kosongkan Keranjang', style: TextStyle(color: Color(0xFFDC2626))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
