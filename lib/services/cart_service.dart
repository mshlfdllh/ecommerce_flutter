import 'package:flutter/material.dart';

class CartService extends ChangeNotifier {
  static final CartService instance = CartService._internal();
  CartService._internal();

  final List<Map<String, dynamic>> _items = [
    {
      'id': 1,
      'title': 'iPhone 16 Pro Max',
      'variant': 'Desert Titanium • 256GB • iBox',
      'price': 24999000,
      'qty': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.phone_iphone_rounded,
    },
    {
      'id': 2,
      'title': 'MacBook Pro 16" M3 Max',
      'variant': 'Space Black • 36GB RAM • 1TB SSD',
      'price': 39999000,
      'qty': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.laptop_mac_rounded,
    },
    {
      'id': 3,
      'title': 'Sony WH-1000XM5',
      'variant': 'Silver Ivory • Wireless Noise Cancel',
      'price': 5499000,
      'qty': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.headphones_rounded,
    },
    {
      'id': 4,
      'title': 'Apple Watch Ultra 2',
      'variant': '49mm Titanium • Ocean Band',
      'price': 14999000,
      'qty': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500&auto=format&fit=crop&q=80',
      'icon': Icons.watch_rounded,
    },
  ];

  List<Map<String, dynamic>> get items => _items;

  int get itemCount =>
      _items.fold<int>(0, (sum, i) => sum + (i['qty'] as int));

  int get totalAmount => _items.fold<int>(
        0,
        (sum, i) => sum + (i['price'] as int) * (i['qty'] as int),
      );

  bool get isEmpty => _items.isEmpty;

  void addItem(Map<String, dynamic> product) {
    final title = product['name'] ?? product['title'];
    final id = product['id'];

    final index = _items.indexWhere(
      (item) => item['id'] == id || item['title'] == title,
    );

    if (index >= 0) {
      _items[index]['qty'] = (_items[index]['qty'] as int) + 1;
    } else {
      _items.add({
        'id': id ?? (_items.length + 1),
        'title': title,
        'variant': product['specs'] ?? 'Garansi Resmi • Original',
        'price': product['price'] ?? 0,
        'qty': 1,
        'imageUrl': product['imageUrl'] ?? '',
        'icon': product['icon'] ?? Icons.devices_other_rounded,
      });
    }
    notifyListeners();
  }

  void incrementQty(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index]['qty'] = (_items[index]['qty'] as int) + 1;
      notifyListeners();
    }
  }

  void decrementQty(int index) {
    if (index >= 0 && index < _items.length) {
      if ((_items[index]['qty'] as int) > 1) {
        _items[index]['qty'] = (_items[index]['qty'] as int) - 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  String _deliveryAddress = 'Jl. Sudirman No. 45, SCBD, Jakarta Selatan';
  String get deliveryAddress => _deliveryAddress;

  final List<Map<String, String>> savedAddresses = [
    {
      'label': 'Rumah',
      'address': 'Jl. Sudirman No. 45, SCBD, Jakarta Selatan',
      'recipient': 'Muhammad Sahel (0812-3456-7890)',
    },
    {
      'label': 'Kantor',
      'address': 'Gedung Equity Tower Lt. 22, SCBD, Jakarta Selatan',
      'recipient': 'Muhammad Sahel - Work (0812-9876-5432)',
    },
    {
      'label': 'Apartemen',
      'address': 'Tower C Lt. 15, Senopati Suites, Jakarta Selatan',
      'recipient': 'Muhammad Sahel (0813-1122-3344)',
    },
  ];

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

