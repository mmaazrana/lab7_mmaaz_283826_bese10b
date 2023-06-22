import '../models/product.dart';
import '../web_service.dart';
import 'package:flutter/material.dart';

class ProductViewModel {
  final Product product;

  ProductViewModel({required this.product});

  String get title {
    return product.title;
  }

  int get id {
    return product.id;
  }

  String get imageUrl {
    return product.image;
  }
}

class ProductListViewModel extends ChangeNotifier {
  List<ProductViewModel> products = [];

  Future<void> fetchProducts() async {
    final results = await WebService().fetchProducts();
    products = results.map((item) => ProductViewModel(product: item)).toList();
    notifyListeners();
  }
}
