import 'package:flutter/material.dart';

// class CategoriesWidget extends StatelessWidget {
//   const CategoriesWidget({super.key});

//   static const Color primaryGold = Color(0xFF167B72);
//   static const Color textDark = Color(0xFF173A3A);

//   final List<Map<String, dynamic>> _categories = const [
//     {'title': 'Sandal', 'icon': Icons.snowshoeing_rounded},
//     {'title': 'Sepatu', 'icon': Icons.hiking_rounded},
//     {'title': 'Jam Tangan', 'icon': Icons.watch_rounded},
//     {'title': 'Tas Kulit', 'icon': Icons.shopping_bag_outlined},
//     {'title': 'Baju Pria', 'icon': Icons.checkroom_rounded},
//     {'title': 'Kacamata', 'icon': Icons.remove_red_eye_outlined},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       child: Row(
//         children: List.generate(_categories.length, (index) {
//           final cat = _categories[index];
//           final isFirst = index == 0;

//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             decoration: BoxDecoration(
//               color: isFirst ? primaryGold : Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: isFirst
//                   ? null
//                   : Border.all(color: Colors.white.withValues(alpha: 0.7)),
//               boxShadow: [
//                 BoxShadow(
//                   color: isFirst
//                       ? primaryGold.withValues(alpha: 0.3)
//                       : Colors.black.withValues(alpha: 0.03),
//                   blurRadius: 10,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: isFirst
//                         ? Colors.white.withValues(alpha: 0.2)
//                         : const Color(0xFFF7F5EE),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     cat['icon'] as IconData,
//                     size: 18,
//                     color: isFirst ? Colors.white : primaryGold,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   cat['title'] as String,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: isFirst ? Colors.white : textDark,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Outfit',
      'Makanan',
      'Pakaian',
      'Elektronik',
      'Skincare',
      'Obat-obatan',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/img.png', width: 25, height: 25, fit: BoxFit.cover ),
                  const SizedBox(width: 5),
                  Text(
                    categories[i],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
