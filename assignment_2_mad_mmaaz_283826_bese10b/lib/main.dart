import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lab7_task1_mmaaz_283826_bese10b/views/cart.dart';
import 'package:lab7_task1_mmaaz_283826_bese10b/views/catalog.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'models/product.dart';
import 'viewModels/product_view_model.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProductListViewModel(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => Catalog(),
            '/cart': (context) => const Cart(),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ));
  }
}
