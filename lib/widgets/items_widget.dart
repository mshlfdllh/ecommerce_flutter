import 'package:flutter/material.dart';
import 'package:ecom_flutter/services/cart_service.dart';
import 'package:ecom_flutter/widgets/address_picker_sheet.dart';

class ItemWidgets extends StatefulWidget {
  const ItemWidgets({super.key});

  @override
  State<ItemWidgets> createState() => _ItemWidgetsState();
}

class _ItemWidgetsState extends State<ItemWidgets> {
  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  final Set<int> _favorites = {1, 3};

  final List<Map<String, dynamic>> _electronicProducts = const [
    {
      'id': 1,
      'name': 'iPhone 16 Pro Max',
      'category': 'Smartphones',
      'specs': 'Desert Titanium • 256GB • A18 Pro',
      'price': 24999000,
      'originalPrice': 26999000,
      'discount': '8%',
      'tag': 'BESTSELLER',
      'rating': 4.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.phone_iphone_rounded,
    },
    {
      'id': 2,
      'name': 'MacBook Pro 16" M3',
      'category': 'Laptops',
      'specs': 'Space Black • 36GB RAM • 1TB SSD',
      'price': 39999000,
      'originalPrice': 44999000,
      'discount': '12%',
      'tag': 'EDITOR CHOICE',
      'rating': 5.0,
      'imageUrl':
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.laptop_mac_rounded,
    },
    {
      'id': 3,
      'name': 'Sony WH-1000XM5',
      'category': 'Audio',
      'specs': 'Silver Ivory • Hi-Res Noise Cancel',
      'price': 5499000,
      'originalPrice': 6299000,
      'discount': '13%',
      'tag': 'TRENDING',
      'rating': 4.8,
      'imageUrl':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.headphones_rounded,
    },
    {
      'id': 4,
      'name': 'Apple Watch Ultra 2',
      'category': 'Smartwatch',
      'specs': 'Titanium 49mm • Orange Ocean Loop',
      'price': 14999000,
      'originalPrice': 15999000,
      'discount': '6%',
      'tag': 'POPULAR',
      'rating': 4.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.watch_rounded,
    },
    {
      'id': 5,
      'name': 'iPad Pro M4 13"',
      'category': 'Tablets',
      'specs': 'Ultra Retina XDR OLED • 256GB',
      'price': 21499000,
      'originalPrice': 23999000,
      'discount': '10%',
      'tag': 'NEW',
      'rating': 4.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.tablet_mac_rounded,
    },
    {
      'id': 6,
      'name': 'PlayStation 5 Pro',
      'category': 'Gaming',
      'specs': '2TB Ultra High Speed • 4K 120Hz',
      'price': 13999000,
      'originalPrice': 14999000,
      'discount': '7%',
      'tag': 'HOT',
      'rating': 4.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.sports_esports_rounded,
    },
    {
      'id': 7,
      'name': 'Samsung S24 Ultra',
      'category': 'Smartphones',
      'specs': 'Titanium Gray • 512GB • Galaxy AI',
      'price': 20999000,
      'originalPrice': 22999000,
      'discount': '9%',
      'tag': 'FLAGSHIP',
      'rating': 4.8,
      'imageUrl':
          'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.smartphone_rounded,
    },
    {
      'id': 8,
      'name': 'AirPods Max Space',
      'category': 'Audio',
      'specs': 'Spatial Audio • Active Noise Cancel',
      'price': 8499000,
      'originalPrice': 9499000,
      'discount': '11%',
      'tag': 'PREMIUM',
      'rating': 4.7,
      'imageUrl':
          'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.headphones_outlined,
    },
  ];

  String _formatRupiah(int number) {
    return 'Rp ${number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  void _toggleFavorite(int id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    });
  }

  void _showAddToCartSnackbar(String productName) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$productName berhasil ditambah ke keranjang',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: textDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showBuyBottomSheet(BuildContext context, Map<String, dynamic> product) {
    int quantity = 1;
    final int unitPrice = product['price'] as int;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final int subtotal = unitPrice * quantity;
            const int voucherDiscount = 50000;
            final int totalPayment =
                (subtotal - voucherDiscount).clamp(0, 999999999);

            return Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F211E1B),
                    blurRadius: 24,
                    offset: Offset(0, -6),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: borderWarm,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.bolt_rounded,
                                color: primaryTerracotta, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Checkout Kilat',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: textDark,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              size: 20, color: textMuted),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const Divider(color: borderWarm, height: 16),

                    // Product Summary Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 64,
                            height: 64,
                            color: const Color(0xFFF7F4EE),
                            child: Image.network(
                              product['imageUrl'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                product['icon'] as IconData,
                                color: textMuted,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: textDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product['specs'] as String,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: textMuted,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatRupiah(unitPrice),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: primaryTerracotta,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Quantity Selector
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F4EE),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderWarm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Jumlah Barang',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: textDark,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (quantity > 1) {
                                    setModalState(() => quantity--);
                                  }
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: borderWarm),
                                  ),
                                  child: const Icon(Icons.remove,
                                      size: 14, color: textDark),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: textDark,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setModalState(() => quantity++);
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: borderWarm),
                                  ),
                                  child: const Icon(Icons.add,
                                      size: 14, color: textDark),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Shipping & Payment Method
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderWarm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 16, color: primaryTerracotta),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Kirim ke: ${CartService.instance.deliveryAddress}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: textDark,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    showAddressPickerSheet(context,
                                        onAddressChanged: () {
                                      setModalState(() {});
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(6),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryTerracotta,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: borderWarm, height: 16),
                          const Row(
                            children: [
                              Icon(Icons.payment_rounded,
                                  size: 16, color: primaryTerracotta),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Metode: SerenePay / QRIS Instant (Bebas Biaya)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: textDark,
                                  ),
                                ),
                              ),
                              Icon(Icons.check_circle_rounded,
                                  size: 16, color: Colors.green),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Total Calculation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 13,
                            color: textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _formatRupiah(totalPayment),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: primaryTerracotta,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Bayar Sekarang Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _showSuccessPurchaseDialog(
                              context, product, quantity, totalPayment);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryTerracotta,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_outline_rounded, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Bayar & Pesan Sekarang',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSuccessPurchaseDialog(
    BuildContext context,
    Map<String, dynamic> product,
    int quantity,
    int totalPayment,
  ) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF2E7D32),
                    size: 38,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pesanan Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Terima kasih telah berbelanja di SereneStore.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: textMuted,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F4EE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderWarm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Produk',
                              style: TextStyle(
                                  fontSize: 12, color: textMuted)),
                          Text('${product['name']} (x$quantity)',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: textDark)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Bayar',
                              style: TextStyle(
                                  fontSize: 12, color: textMuted)),
                          Text(_formatRupiah(totalPayment),
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: primaryTerracotta)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nomor Order',
                              style: TextStyle(
                                  fontSize: 12, color: textMuted)),
                          Text('SRN-998231',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: textDark)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(dialogCtx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryTerracotta,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Selesai & Lanjut Belanja',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.52,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
      ),
      itemCount: _electronicProducts.length,
      itemBuilder: (context, index) {
        final product = _electronicProducts[index];
        final isFav = _favorites.contains(product['id']);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderWarm,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF211E1B).withOpacity(0.04),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Container
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                    child: Container(
                      height: 135,
                      width: double.infinity,
                      color: const Color(0xFFF7F4EE),
                      child: Image.network(
                        product['imageUrl'] as String,
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
                              product['icon'] as IconData,
                              size: 48,
                              color: textMuted,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Tag Badge (Bestseller, Trending, etc.)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: borderWarm,
                        ),
                      ),
                      child: Text(
                        product['tag'] as String? ?? 'ORIGINAL',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: textDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => _toggleFavorite(product['id'] as int),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: borderWarm,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 16,
                            color: isFav ? primaryTerracotta : textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Product Info Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            product['specs'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Price and Action Buttons (Add to Cart + Beli)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _formatRupiah(product['price'] as int),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: primaryTerracotta,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      _formatRupiah(product['originalPrice'] as int),
                                      style: const TextStyle(
                                        fontSize: 9,
                                        color: textMuted,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Actions: Add to Cart (+) & Buy Now (Beli)
                          Row(
                            children: [
                              // + Keranjang icon button
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    CartService.instance.addItem(product);
                                    _showAddToCartSnackbar(
                                        product['name'] as String);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F4EE),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: borderWarm, width: 1.2),
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: 15,
                                      color: textDark,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Beli button
                              Expanded(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => _showBuyBottomSheet(
                                        context, product),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      decoration: BoxDecoration(
                                        color: primaryTerracotta,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryTerracotta
                                                .withOpacity(0.25),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.flash_on_rounded,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Beli',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}