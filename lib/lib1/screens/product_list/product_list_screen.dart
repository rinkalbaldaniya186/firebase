import 'package:flutter/material.dart';
//import 'package:shoppio_flutter_app/screens/product_list/components/body.dart';
 import '../product_list/components/body.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List'),),
      body: Body(),
    );
  }
}
