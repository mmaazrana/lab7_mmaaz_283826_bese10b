import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../viewModels/product_view_model.dart';

class Catalog extends StatefulWidget {
  Catalog({Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  late final ProductListViewModel vm;
  late final List<ProductViewModel> _products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    vm = Provider.of<ProductListViewModel>(context, listen: false);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await vm.fetchProducts();
    setState(() {
      isLoading = false;
    });
    _products = vm.products;
  }

  final List<ProductViewModel> _added = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 222, 59),
        title: const Text(
          'Catalog',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            color: Color.fromARGB(255, 0, 0, 0),
            disabledColor: Color.fromARGB(0, 0, 0, 0),
            // Enable cart when atleast one item is added
            onPressed: _added.isNotEmpty
                ? () =>
                    Navigator.of(context).pushNamed('/cart', arguments: _added)
                : null,
            tooltip: 'Cart',
          )
        ],
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              itemCount: _products.length,
              itemBuilder: (context, i) {
                final alreadyAdded = _added.contains(_products[i]);
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12)),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(5),
                    minVerticalPadding: 5,
                    leading: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Image(
                        image: NetworkImage(_products[i].imageUrl),
                        width: 70,
                        height: 70,
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _products[i].title,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    trailing: alreadyAdded
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: const Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 3, 78, 5),
                              semanticLabel: "Added to cart",
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: const Text(
                              "ADD",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                    onTap: () {
                      setState(
                        () {
                          if (alreadyAdded) {
                            _added.remove(_products[i]);
                          } else {
                            _added.add(_products[i]);
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
