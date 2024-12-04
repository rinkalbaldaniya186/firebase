import 'dart:io';

import 'package:firebaseauth111/lib1/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:shoppio_flutter_app/database/db_helper.dart';
// import 'package:shoppio_flutter_app/model/category.dart';

import '../../../database/db_helper.dart';
import '../../../routes/app_route.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var categoryList = <Category>[];

  DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var category =
              await Navigator.pushNamed(context, AppRoute.categoryScreen);

          if (category is Category) {
            setState(() {
              categoryList.add(category);
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              var category = await Navigator.pushNamed(
                  context, AppRoute.categoryScreen,
                  arguments: categoryList[index]);
              if (category is Category) {
                var index = categoryList
                    .indexWhere((element) => element.id == category.id);

                setState(() {
                  categoryList[index] = category;
                });
              }
            },
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.amber.shade100,
              child: SvgPicture.file(
                File('${categoryList[index].imagePath}'),
                height: 24,
                colorFilter: ColorFilter.mode(Colors.amber, BlendMode.srcIn),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {

              },
              child: Icon(Icons.delete),
            ),
            title: Text(categoryList[index].title!),
            subtitle: Text(categoryList[index].description!),
          );
        },
      ),
    );
  }

  Future<void> getCategoryList() async {
    var list = await _dbHelper.getCategoryList();
    setState(() {
      categoryList = list;
    });
  }
}
