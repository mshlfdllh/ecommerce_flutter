import 'package:flutter/material.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';
import 'package:ecom_flutter/pages/detail_chat.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  bool _showUnreadOnly = false;
  String _searchQuery = '';

  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  final List<Map<String, dynamic>> _chats = const [
    {
      'name': 'Apple Authorized Store',
      'lastMessage': 'Pesanan iPhone 16 Pro Max kamu sudah siap dikirim!',
      'time': '10:30 AM',
      'unreadCount': 2,
      'isRead': false,
      'verified': true,
      'icon': Icons.apple_rounded,
      'iconColor': Color(0xFF211E1B),
    },
    {
      'name': 'Sony Official Indonesia',
      'lastMessage': 'Garansi resmi 1 tahun Sony WH-1000XM5 telah aktif.',
      'time': '09:15 AM',
      'unreadCount': 1,
      'isRead': false,
      'verified': true,
      'icon': Icons.headphones_rounded,
      'iconColor': Color(0xFFA9442C),
    },
    {
      'name': 'Samsung Flagship Store',
      'lastMessage': 'Unit Galaxy S24 Ultra Titanium Gray ready stock kak.',
      'time': 'Kemarin',
      'unreadCount': 0,
      'isRead': true,
      'verified': true,
      'icon': Icons.smartphone_rounded,
      'iconColor': Color(0xFF3B5E49),
    },
    {
      'name': 'PlayStation Official Store',
      'lastMessage': 'Paket PS5 Pro kamu dikemas dengan bubble wrap tebal.',
      'time': 'Kemarin',
      'unreadCount': 0,
      'isRead': true,
      'verified': true,
      'icon': Icons.sports_esports_rounded,
      'iconColor': Color(0xFF334155),
    },
    {
      'name': 'SereneStore Customer Care',
      'lastMessage': 'Terima kasih telah menghubungi layanan pelanggan SereneStore.',
      'time': '12 Okt',
      'unreadCount': 0,
      'isRead': true,
      'verified': false,
      'icon': Icons.support_agent_rounded,
      'iconColor': Color(0xFFA9442C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredChats = _chats.where((chat) {
      final matchesFilter = !_showUnreadOnly || chat['isRead'] == false;
      final matchesSearch = (chat['name'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          (chat['lastMessage'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LiquidBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: GlassContainer(
                  borderRadius: 24,
                  blur: 16,
                  opacity: 0.88,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
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
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderWarm),
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
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Pesan & CS Toko',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: textDark,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Text(
                              'Official Brand Stores Support',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF86EFAC),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, size: 7, color: Color(0xFF16A34A)),
                            SizedBox(width: 5),
                            Text(
                              'Online',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Search Bar & Filter Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: borderWarm,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textDark,
                        ),
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.search_rounded,
                            color: textMuted,
                            size: 20,
                          ),
                          hintText: 'Cari percakapan toko...',
                          hintStyle: const TextStyle(
                            color: Color(0xFF9E988F),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    size: 18,
                                    color: textMuted,
                                  ),
                                  onPressed: () =>
                                      setState(() => _searchQuery = ''),
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Filter Chips
                    Row(
                      children: [
                        _buildFilterChip(
                          label: 'Semua Pesan',
                          isSelected: !_showUnreadOnly,
                          onTap: () => setState(() => _showUnreadOnly = false),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          label: 'Belum Dibaca',
                          isSelected: _showUnreadOnly,
                          badgeCount: _chats
                              .where((c) => c['isRead'] == false)
                              .length,
                          onTap: () => setState(() => _showUnreadOnly = true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Chat List
              Expanded(
                child: filteredChats.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 48,
                              color: textMuted.withOpacity(0.5),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Tidak ada percakapan ditemukan',
                              style: TextStyle(
                                color: textMuted,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        itemCount: filteredChats.length,
                        itemBuilder: (context, index) {
                          final chat = filteredChats[index];
                          return _buildChatItem(chat);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    int? badgeCount,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? textDark : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? textDark : borderWarm,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : textDark,
              ),
            ),
            if (badgeCount != null && badgeCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected ? primaryTerracotta : textDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    final bool isUnread = !(chat['isRead'] as bool);
    final IconData iconData = chat['icon'] as IconData? ?? Icons.storefront_rounded;
    final Color iconColor = chat['iconColor'] as Color? ?? primaryTerracotta;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnread ? primaryTerracotta.withOpacity(0.4) : borderWarm,
            width: isUnread ? 1.4 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF211E1B).withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    contactName: chat['name'] as String,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Store Icon Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F4EE),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: borderWarm,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        iconData,
                        size: 26,
                        color: iconColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name and Last Message
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                chat['name'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isUnread
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                  color: textDark,
                                  letterSpacing: -0.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (chat['verified'] == true) ...[
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.verified_rounded,
                                size: 14,
                                color: primaryTerracotta,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chat['lastMessage'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isUnread
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isUnread ? textDark : textMuted,
                            height: 1.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Time and Unread Badge
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat['time'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isUnread ? FontWeight.w700 : FontWeight.w400,
                          color: isUnread ? primaryTerracotta : textMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (isUnread && (chat['unreadCount'] as int) > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryTerracotta,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${chat['unreadCount']}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else
                        const Icon(
                          Icons.done_all_rounded,
                          size: 16,
                          color: textMuted,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
