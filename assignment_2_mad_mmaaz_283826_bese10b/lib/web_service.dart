import 'dart:convert';

import 'models/product.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<Product>> fetchProducts() async {
    const url = "https://fakestoreapi.com/products/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Iterable body = jsonDecode(response.body) as Iterable;
      return body.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception("Error: Unable to perform request");
    }
  }
}
