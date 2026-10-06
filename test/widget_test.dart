// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:ecom_flutter/main.dart';
import 'package:ecom_flutter/pages/cart_page.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });

  testWidgets('Cart back button opens the registered home route', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const CartPage(),
        routes: {'/home_page': (_) => const Scaffold(body: Text('Beranda'))},
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded).first);
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsOneWidget);
  });

  testWidgets('Empty cart shows its glass state and hides checkout', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: CartPage()));

    for (var index = 0; index < 4; index++) {
      final deleteButton = find.byIcon(Icons.delete_outline_rounded).first;
      await tester.ensureVisible(deleteButton);
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();
    }

    expect(find.text('Keranjang Anda Kosong'), findsOneWidget);
    expect(find.text('Keranjang masih kosong'), findsOneWidget);
    expect(find.text('Checkout'), findsNothing);
  });
}
