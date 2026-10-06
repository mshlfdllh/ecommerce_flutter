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

  static const Color textDark = Color(0xFF173A3A);
  static const Color textMuted = Color(0xFF617875);

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
                    // Top AppBar Liquid Glass
                    GlassContainer(
                      borderRadius: 28,
                      blur: 24,
                      opacity: 0.7,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          GlassContainer(
                            shape: BoxShape.circle,
                            blur: 15,
                            opacity: 0.5,
                            padding: const EdgeInsets.all(2),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: textDark,
                                size: 18,
                              ),
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home_page',
                                  );
                                }
                              },
                              tooltip: 'Kembali',
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Akun Saya',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const Spacer(),
                          GlassContainer(
                            shape: BoxShape.circle,
                            blur: 15,
                            opacity: 0.5,
                            padding: const EdgeInsets.all(2),
                            child: IconButton(
                              icon: const Icon(
                                Icons.notifications_none_rounded,
                                color: textDark,
                                size: 20,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Tidak ada notifikasi baru',
                                    ),
                                    backgroundColor: const Color(0xFF173A3A),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                );
                              },
                              tooltip: 'Notifikasi',
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Profile Liquid Glass Card
                    _buildProfileSection(),

                    const SizedBox(height: 16),

                    // Stats Quick Bar
                    _buildQuickStatsBar(),

                    const SizedBox(height: 22),

                    // Section Title: Pengaturan Akun
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 18,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF45B6A2), Color(0xFF167B72)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Pengaturan Akun',
                            style: TextStyle(
                              fontSize: 16,
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
    return GlassContainer(
      borderRadius: 30,
      blur: 24,
      opacity: 0.75,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF45B6A2).withValues(alpha: 0.18),
          const Color(0xFFFF8D75).withValues(alpha: 0.15),
          Colors.white.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Avatar with Liquid Glow Ring
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF45B6A2),
                  Color(0xFF167B72),
                  Color(0xFFFF8D75),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF167B72).withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/avatar.png',
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF45B6A2), Color(0xFF167B72)],
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 42,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Prabu Widodo',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: textDark,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'joko@gmail.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF45B6A2), Color(0xFF167B72)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF45B6A2).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Gold Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
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
    return GlassContainer(
      borderRadius: 26,
      blur: 20,
      opacity: 0.65,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(
            Icons.shopping_bag_outlined,
            '12',
            'Pesanan',
            const Color(0xFF167B72),
          ),
          Container(
            height: 28,
            width: 1,
            color: Colors.black.withValues(alpha: 0.08),
          ),
          _buildStatColumn(
            Icons.confirmation_number_outlined,
            '5',
            'Voucher',
            const Color(0xFFFF8D75),
          ),
          Container(
            height: 28,
            width: 1,
            color: Colors.black.withValues(alpha: 0.08),
          ),
          _buildStatColumn(
            Icons.stars_rounded,
            '2.450',
            'Poin Koin',
            const Color(0xFFB7D66A),
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
            fontWeight: FontWeight.w500,
            color: textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    final effectiveColor = iconColor ?? const Color(0xFF167B72);

    return GlassContainer(
      borderRadius: 22,
      blur: 18,
      opacity: 0.62,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: effectiveColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: effectiveColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: titleColor ?? textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(fontSize: 12, color: textMuted),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: textMuted,
                    size: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        _buildSettingItem(
          context,
          icon: Icons.person_outline_rounded,
          title: "Profile",
          subtitle: "Kelola data diri & informasi kontak",
          iconColor: const Color(0xFF45B6A2),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Membuka detail profil'),
                backgroundColor: const Color(0xFF173A3A),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.shopping_cart_outlined,
          title: "Cart",
          subtitle: "Keranjang",
          iconColor: const Color(0xFF167B72),
          onTap: () {
            Navigator.pushNamed(context, '/cart_page');
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.lock_outline_rounded,
          title: "Change Password",
          subtitle: "Ubah kata sandi untuk keamanan akun",
          iconColor: const Color(0xFFFF8D75),
          onTap: () {
            Navigator.pushNamed(context, '/change_password_page');
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.privacy_tip_outlined,
          title: "Privacy & Policy",
          subtitle: "Kebijakan privasi & syarat penggunaan",
          iconColor: const Color(0xFFB7D66A),
          onTap: () {},
        ),
        _buildSettingItem(
          context,
          icon: Icons.logout_rounded,
          title: "Logout",
          subtitle: "Keluar dari sesi akun Anda",
          iconColor: const Color(0xFFE55656),
          titleColor: const Color(0xFFE55656),
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(24),
          child: GlassContainer(
            borderRadius: 30,
            blur: 28,
            opacity: 0.85,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Color(0xFFE55656),
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Konfirmasi Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Apakah Anda yakin ingin keluar dari akun Anda?',
                  style: TextStyle(fontSize: 14, color: textMuted),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE55656),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE55656)
                                .withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login_page',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
