import 'package:flutter/material.dart';
import 'package:ecom_flutter/services/cart_service.dart';

class CartItemsamples extends StatefulWidget {
  final void Function(int itemCount, int totalAmount)? onCartChanged;

  const CartItemsamples({super.key, this.onCartChanged});

  @override
  State<CartItemsamples> createState() => _CartItemsamplesState();
}

class _CartItemsamplesState extends State<CartItemsamples> {
  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  @override
  void initState() {
    super.initState();
    CartService.instance.addListener(_handleCartUpdate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyCartChanged();
    });
  }

  @override
  void dispose() {
    CartService.instance.removeListener(_handleCartUpdate);
    super.dispose();
  }

  void _handleCartUpdate() {
    if (mounted) {
      setState(() {});
      _notifyCartChanged();
    }
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _incrementQty(int index) {
    CartService.instance.incrementQty(index);
  }

  void _decrementQty(int index) {
    CartService.instance.decrementQty(index);
  }

  void _removeItem(int index) {
    final items = CartService.instance.items;
    if (index >= 0 && index < items.length) {
      final title = items[index]['title'] as String;
      CartService.instance.removeItem(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title dihapus dari keranjang'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
    }
  }

  void _notifyCartChanged() {
    if (widget.onCartChanged == null) return;
    widget.onCartChanged!(
      CartService.instance.itemCount,
      CartService.instance.totalAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.instance.items;

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE9DF),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderWarm,
                  ),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 64,
                  color: primaryTerracotta,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Keranjang Anda Kosong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Keranjang masih kosong',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: textMuted),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final itemTotal = (item['price'] as int) * (item['qty'] as int);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          padding: const EdgeInsets.all(14),
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
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image Box
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F4EE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: (item['imageUrl'] != null &&
                          (item['imageUrl'] as String).isNotEmpty)
                      ? Image.network(
                          item['imageUrl'] as String,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                                color: primaryTerracotta,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                item['icon'] as IconData? ??
                                    Icons.devices_other_rounded,
                                size: 32,
                                color: textMuted,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            item['icon'] as IconData? ??
                                Icons.devices_other_rounded,
                            size: 32,
                            color: textMuted,
                          ),
                        ),
                ),
              ),

              const SizedBox(width: 14),

              // Title, Variant, Unit Price & Subtotal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item['variant'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        color: textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          _formatCurrency(item['price'] as int),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: primaryTerracotta,
                          ),
                        ),
                        if ((item['qty'] as int) > 1) ...[
                          const SizedBox(width: 6),
                          Text(
                            '(${_formatCurrency(itemTotal)})',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Action Column: Delete & Stepper
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
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEE2E2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFDC2626),
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
                      color: const Color(0xFFF7F4EE),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: borderWarm,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Minus
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _decrementQty(index),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove_rounded,
                                size: 14,
                                color: textDark,
                              ),
                            ),
                          ),
                        ),

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

                        // Plus
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _incrementQty(index),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: textDark,
                                shape: BoxShape.circle,
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
