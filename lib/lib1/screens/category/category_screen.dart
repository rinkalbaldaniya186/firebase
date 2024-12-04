import 'package:firebaseauth111/lib1/model/category.dart';
import 'package:flutter/material.dart';
 import '../category/components/body.dart';

// import 'package:shoppio_flutter_app/model/category.dart';
// import 'package:shoppio_flutter_app/screens/category/components/body.dart';

class CategoryScreen extends StatelessWidget {

  Category? category;


  CategoryScreen({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category == null? 'Add Category': 'Update Category'),),
      body: Body(category),
    );
  }
}
