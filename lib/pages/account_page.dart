import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideProfileAnimation;
  late Animation<double> _scaleAvatarAnimation;
  late Animation<Offset> _slideSettingsAnimation;

  // Warna tema segar & hidup (Fresh Mint & Teal)
  static const Color primaryTeal = Color(0xFF00B4D8);
  static const Color accentMint = Color(0xFF2EC4B6);
  static const Color softMint = Color(0xFF64DFDF);
  static const Color darkText = Color(0xFF1D3557);
  static const Color mutedText = Color(0xFF6C757D);

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController!,
      curve: Curves.easeOut,
    );

    _slideProfileAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController!, curve: Curves.easeOutCubic),
    );

    _scaleAvatarAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animController!, curve: Curves.easeOutBack),
    );

    _slideSettingsAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController!,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    if (!_animController!.isAnimating && !_animController!.isCompleted) {
      _animController!.forward();
    }
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animController == null) {
      _initAnimations();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7FBF9),
      // AppBar Lebih Hidup dengan Gradasi, Sudut Melengkung & Tombol Interaktif
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 64, 201, 185),
                  Color.fromARGB(255, 97, 238, 224),
                  Color.fromARGB(255, 153, 252, 218),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x2800B4D8),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.28),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, '/login_page');
                  }
                },
                tooltip: 'Kembali',
              ),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Account Page',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.28),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Tidak ada notifikasi baru saat ini'),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xFF2EC4B6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    );
                  },
                  tooltip: 'Notifikasi',
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Profil dengan Animasi Slide & Scale
              SlideTransition(
                position: _slideProfileAnimation,
                child: _buildProfileSection(),
              ),

              const SizedBox(height: 20),

              // Quick Stats E-Commerce Bar
              SlideTransition(
                position: _slideProfileAnimation,
                child: _buildQuickStatsBar(),
              ),

              const SizedBox(height: 26),

              // Judul Menu
              SlideTransition(
                position: _slideSettingsAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: accentMint,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Pengaturan Akun',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Daftar Menu Settings dengan Animasi Slide
              SlideTransition(
                position: _slideSettingsAnimation,
                child: _buildSettingsSection(context),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Header Profile Section dengan Gradasi & Bayangan Halus
  Widget _buildProfileSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 60, 218, 203),
            Color.fromARGB(255, 120, 240, 220),
            Color.fromARGB(255, 175, 247, 230),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2EC4B6).withOpacity(0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Row(
        children: [
          // Avatar dengan ScaleTransition & Bingkai Bersinar
          ScaleTransition(
            scale: _scaleAvatarAnimation,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://i.pravatar.cc/150?img=11',
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 85,
                      height: 85,
                      color: Colors.white24,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback ikon jika koneksi gambar gagal
                    return Container(
                      width: 85,
                      height: 85,
                      color: Colors.white30,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          // Informasi Nama, Email & Badge Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Prabu Widodo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.4,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'joko@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.92),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                // Badge Verified Member
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Gold Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
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

  // Quick Stats E-Commerce Bar (Pesanan, Voucher, Poin)
  Widget _buildQuickStatsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(Icons.shopping_bag_outlined, '12', 'Pesanan'),
          Container(height: 32, width: 1, color: Colors.grey.shade200),
          _buildStatColumn(Icons.confirmation_number_outlined, '5', 'Voucher'),
          Container(height: 32, width: 1, color: Colors.grey.shade200),
          _buildStatColumn(Icons.stars_rounded, '2.450', 'Poin Koin'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF2EC4B6), size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: mutedText,
          ),
        ),
      ],
    );
  }

  // List Menu Settings dengan Desain Card Cantik & Modern
  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    final effectiveIconColor = iconColor ?? const Color(0xFF2EC4B6);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon Container dengan background lembut
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: effectiveIconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: effectiveIconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Judul & Subtitle yang informatif
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: titleColor ?? darkText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: mutedText.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                // Trailing Arrow Icon
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kumpulan Menu Section
  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        _buildSettingItem(
          context,
          icon: Icons.person_outline_rounded,
          title: "Profile",
          subtitle: "Kelola data diri & informasi kontak",
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Membuka halaman Edit Profil'),
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
          icon: Icons.lock_outline_rounded,
          title: "Change Password",
          subtitle: "Ubah kata sandi untuk keamanan akun",
          onTap: () {
            Navigator.pushNamed(context, '/change_password_page');
          },
        ),
        _buildSettingItem(
          context,
          icon: Icons.privacy_tip_outlined,
          title: "Privacy & Policy",
          subtitle: "Kebijakan privasi & syarat penggunaan",
          onTap: () {},
        ),
        _buildSettingItem(
          context,
          icon: Icons.logout_rounded,
          title: "Logout",
          subtitle: "Keluar dari sesi akun Anda",
          iconColor: Colors.red.shade400,
          titleColor: Colors.red.shade600,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  // Dialog Logout Interaktif
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.redAccent, size: 24),
              SizedBox(width: 10),
              Text(
                'Konfirmasi Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: darkText,
                ),
              ),
            ],
          ),
          content: const Text(
            'Apakah Anda yakin ingin keluar dari akun ini?',
            style: TextStyle(fontSize: 15, color: mutedText),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: mutedText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade500,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login_page',
                  (route) => false,
                );
                messenger.showSnackBar(const SnackBar(content: Text('Sudah berhasil Logout')));
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
