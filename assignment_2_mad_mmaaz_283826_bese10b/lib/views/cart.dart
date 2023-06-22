import 'package:flutter/material.dart';

import '../models/product.dart';
import '../viewModels/product_view_model.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Read the arguments
    final _cartItems =
        ModalRoute.of(context)!.settings.arguments as List<ProductViewModel>;
    final tiles = _cartItems.map(
      (product) {
        return ListTile(
          title: Text(
            product.title,
            style: const TextStyle(fontSize: 18.0),
          ),
        );
      },
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
        : <Widget>[];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 222, 59),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (_, index) {
                  final product = _cartItems[index];
                  final nameWords = product.title;

                  return Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(120, 255, 255, 255),
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                        border: Border.all(color: Colors.black45)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(5),
                      title: Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Text(nameWords as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87))),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${_cartItems.fold<double>(0, (sum, product) => sum + product.product.price)}',
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      backgroundColor: Color.fromARGB(255, 255, 222, 59),
                    ),
                    child: const Text(
                      'Buy',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
