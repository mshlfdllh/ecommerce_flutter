import 'package:flutter/material.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
        child: GlassContainer(
          borderRadius: 24,
          blur: 22,
          opacity: 0.68,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            children: [
              // Back button
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home_page');
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: const Color(0xFF173A3A),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF167B72)
                      .withValues(alpha: 0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(width: 16),
              // Title
              const Expanded(
                child: Text(
                  'Keranjang',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF173A3A),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              // Trailing action
              PopupMenuButton<String>(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF167B72).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.more_vert_rounded,
                    size: 22,
                    color: const Color(0xFF173A3A),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                offset: const Offset(0, 48),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(Icons.delete_sweep_outlined, size: 20),
                        SizedBox(width: 12),
                        Text('Clear Cart'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'wishlist',
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border_rounded, size: 20),
                        SizedBox(width: 12),
                        Text('Move to Wishlist'),
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
