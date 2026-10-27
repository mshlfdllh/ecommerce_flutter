import 'package:ecom_flutter/pages/cart_page.dart';
import 'package:ecom_flutter/pages/detail_chat.dart';
import 'package:ecom_flutter/pages/home_page.dart';
import 'package:ecom_flutter/pages/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:ecom_flutter/pages/login_page.dart';
import 'package:ecom_flutter/pages/register_page.dart';
import 'package:ecom_flutter/pages/account_page.dart';
import 'package:ecom_flutter/pages/change_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Aesthetic Warm Linen & Terracotta Palette (Ordinary style)
  static const Color primaryTerracotta = Color(0xFFA9442C); // Warm Terracotta / Rust
  static const Color accentSand = Color(0xFFE5DDD0); // Soft Warm Sand
  static const Color scaffoldBg = Color(0xFFF7F4EE); // Warm Oat Linen Cream
  static const Color surfaceWarm = Colors.white; // Pure White Card
  static const Color primaryText = Color(0xFF211E1B); // Deep Espresso Charcoal
  static const Color mutedText = Color(0xFF7D776E); // Warm Taupe Grey
  static const Color borderWarm = Color(0xFFE8E2D8); // Delicate Warm Border

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SereneStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primaryTerracotta,
          secondary: primaryText,
          surface: surfaceWarm,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: scaffoldBg,

        // Text Theme
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: primaryText,
            letterSpacing: -0.6,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: primaryText,
            letterSpacing: -0.4,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: primaryText,
            letterSpacing: -0.2,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: primaryText,
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: primaryText,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: mutedText,
          ),
          labelLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: primaryText, size: 22),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: primaryText,
            letterSpacing: -0.2,
          ),
        ),

        // Card Theme
        cardTheme: CardThemeData(
          color: surfaceWarm,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: borderWarm,
              width: 1.2,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF9E988F),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: borderWarm,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: primaryTerracotta, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
          ),
          prefixIconColor: primaryTerracotta,
          suffixIconColor: mutedText,
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryTerracotta,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(64, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryTerracotta,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryText,
          contentTextStyle: const TextStyle(color: Colors.white),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: borderWarm,
          thickness: 1,
        ),
      ),
      home: const LoginPage(),
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/sign_up_page': (context) => const RegisterPage(),
        '/account_page': (context) => const AccountPage(),
        '/change_password_page': (context) => const ChangePasswordPage(),
        '/cart_page': (context) => const CartPage(),
        '/home_page': (context) => const HomePage(),
        '/list_chat': (context) => const ChatListPage(),
        '/detail_chat': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          final contactName =
              arguments is Map && arguments['contactName'] is String
                  ? arguments['contactName'] as String
                  : 'Customer Support';
          return ChatScreen(contactName: contactName);
        },
      },
    );
  }
}
