import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final url = Uri.parse(
        'https://flutter-shop-update-a0cd2-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    isFavorite = !isFavorite;
    notifyListeners();
    final response =
        await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
    print(response.statusCode);
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Could not add to favorite');
    }
  }
}
