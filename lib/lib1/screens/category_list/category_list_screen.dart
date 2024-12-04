import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';
// import 'package:shoppio_flutter_app/screens/category_list/components/body.dart';
import '../category_list/components/body.dart';


class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category List'),),
      body: Body(),
    );
  }
}
