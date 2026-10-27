import 'package:flutter/material.dart';
import 'package:ecom_flutter/widgets/glass_container.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const Color primaryTerracotta = Color(0xFFA9442C);
  static const Color textDark = Color(0xFF211E1B);
  static const Color textMuted = Color(0xFF7D776E);
  static const Color borderWarm = Color(0xFFE8E2D8);

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController!,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController!, curve: Curves.easeOutCubic),
    );

    _animController!.forward();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: LiquidBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top AppBar
                    GlassContainer(
                      borderRadius: 24,
                      blur: 16,
                      opacity: 0.88,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
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
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home_page',
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: borderWarm),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: textDark,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Akun Saya',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const Spacer(),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Navigator.pushNamed(context, '/list_chat');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: borderWarm),
                                ),
                                child: const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: textDark,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Profile Section
                    _buildProfileSection(),

                    const SizedBox(height: 16),

                    // Stats Quick Bar
                    _buildQuickStatsBar(),

                    const SizedBox(height: 20),

                    // Section Title: Layanan Gadget & Garansi
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 16,
                            decoration: BoxDecoration(
                              color: primaryTerracotta,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Layanan Gadget & Garansi Resmi',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Warranty & Service Quick Actions
                    _buildGadgetServicesSection(context),

                    const SizedBox(height: 20),

                    // Section Title: Pengaturan Akun
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 16,
                            decoration: BoxDecoration(
                              color: textDark,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Pengaturan & Keamanan Akun',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Settings List
                    _buildSettingsSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderWarm, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF211E1B).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryTerracotta, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/avatar.png',
                width: 66,
                height: 66,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 66,
                    height: 66,
                    color: const Color(0xFFF7F4EE),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 36,
                      color: primaryTerracotta,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'M Sahel Fadillah',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: textDark,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'sahel.tech@gmail.com',
                  style: TextStyle(
                    fontSize: 12,
                    color: textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F4EE),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderWarm),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_user_rounded,
                        color: primaryTerracotta,
                        size: 13,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Member Eksklusif',
                        style: TextStyle(
                          color: textDark,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderWarm, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF211E1B).withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(
            Icons.shopping_bag_outlined,
            '8',
            'Pesanan',
            primaryTerracotta,
          ),
          Container(
            height: 28,
            width: 1,
            color: borderWarm,
          ),
          _buildStatColumn(
            Icons.confirmation_number_outlined,
            '4',
            'Voucher',
            textDark,
          ),
          Container(
            height: 28,
            width: 1,
            color: borderWarm,
          ),
          _buildStatColumn(
            Icons.shield_outlined,
            '3',
            'Garansi Aktif',
            primaryTerracotta,
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    IconData icon,
    String value,
    String label,
    Color accentColor,
  ) {
    return Column(
      children: [
        Icon(icon, color: accentColor, size: 22),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textDark,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildGadgetServicesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderWarm, width: 1.2),
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
          _buildSettingTile(
            icon: Icons.verified_rounded,
            iconColor: primaryTerracotta,
            title: 'Klaim Garansi Resmi (Apple / Sony)',
            subtitle: 'Cek status garansi & klaim perbaikan',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua unit produk dalam garansi aktif'),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildSettingTile(
            icon: Icons.track_changes_rounded,
            iconColor: textDark,
            title: 'Lacak Pengiriman Gadget',
            subtitle: 'Pantau paket elektronik yang sedang dikirim',
            onTap: () {
              Navigator.pushNamed(context, '/cart_page');
            },
          ),
          _buildDivider(),
          _buildSettingTile(
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: primaryTerracotta,
            title: 'Chat CS & Official Store',
            subtitle: 'Hubungi Apple Store atau Sony CS',
            onTap: () {
              Navigator.pushNamed(context, '/list_chat');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderWarm, width: 1.2),
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
          _buildSettingTile(
            icon: Icons.person_outline_rounded,
            iconColor: textDark,
            title: 'Edit Profil Pengguna',
            subtitle: 'Nama, nomor HP, dan alamat',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            icon: Icons.lock_outline_rounded,
            iconColor: primaryTerracotta,
            title: 'Ganti Kata Sandi',
            subtitle: 'Perbarui kata sandi akun',
            onTap: () {
              Navigator.pushNamed(context, '/change_password_page');
            },
          ),
          _buildDivider(),
          _buildSettingTile(
            icon: Icons.notifications_none_rounded,
            iconColor: textMuted,
            title: 'Notifikasi & Promo',
            subtitle: 'Pengingat rilis gadget & diskon',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            icon: Icons.logout_rounded,
            iconColor: const Color(0xFFDC2626),
            title: 'Keluar dari Akun',
            subtitle: 'Keluar dan kembali ke halaman login',
            onTap: () => _showLogoutDialog(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDestructive ? const Color(0xFFDC2626) : textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: textMuted.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 52,
      endIndent: 16,
      color: borderWarm,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(
              color: borderWarm,
            ),
          ),
          title: const Text(
            'Konfirmasi Keluar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textDark,
            ),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun?',
            style: TextStyle(fontSize: 13, color: textMuted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login_page');
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
