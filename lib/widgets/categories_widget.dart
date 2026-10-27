import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  final ValueChanged<String>? onCategorySelected;

  const CategoriesWidget({super.key, this.onCategorySelected});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int _selectedIndex = 0;

  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  final List<Map<String, dynamic>> _categories = const [
    {'title': 'Semua Produk', 'icon': Icons.grid_view_rounded},
    {'title': 'Smartphones', 'icon': Icons.phone_iphone_rounded},
    {'title': 'Laptops & Mac', 'icon': Icons.laptop_mac_rounded},
    {'title': 'Audio & Headshet', 'icon': Icons.headphones_rounded},
    {'title': 'Smartwatch', 'icon': Icons.watch_rounded},
    {'title': 'Gaming & Console', 'icon': Icons.sports_esports_rounded},
    {'title': 'Tablets', 'icon': Icons.tablet_mac_rounded},
    {'title': 'Aksesoris', 'icon': Icons.mouse_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final cat = _categories[index];
          final isSelected = _selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  if (widget.onCategorySelected != null) {
                    widget.onCategorySelected!(cat['title'] as String);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? textDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? textDark : borderWarm,
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isSelected ? 0.08 : 0.03),
                        blurRadius: isSelected ? 12 : 6,
                        offset: Offset(0, isSelected ? 4 : 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        cat['icon'] as IconData,
                        size: 17,
                        color: isSelected ? Colors.white : primaryTerracotta,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        cat['title'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected ? Colors.white : textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
