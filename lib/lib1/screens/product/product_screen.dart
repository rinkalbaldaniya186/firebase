import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/screens/product/components/body.dart';
import '../../model/product.dart';
import '../product/components/body.dart';

class ProductScreen extends StatelessWidget {

  Product? product;

  ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product'),),
      body: Body(product),
    );
  }
}
