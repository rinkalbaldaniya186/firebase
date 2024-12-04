import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseauth111/lib1/firebase/firebase_service.dart';
import 'package:firebaseauth111/lib1/routes/app_route.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/firebase/firebase_service.dart';
// import 'package:shoppio_flutter_app/model/product.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // DatabaseReference mRef = FirebaseDatabase.instance.ref();
  FirebaseService _service = FirebaseService();

  void delete(String? id) {
    _service.deleteProduct(id!).then((value){
      if(value){
        // success
      }else{
        // error
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.productScreen);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        /*stream: mRef.child('product-node').onValue,*/
        stream: _service.getProductList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            var productList = snapshot.data;

           /* print(snapshot.data!.snapshot.value);
            var productList = <Product>[];

            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map;

            map.values.forEach((element) {
              productList.add(Product.fromMap(element));
            });*/
            return ListView.builder(
              itemCount: productList?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.productScreen, arguments: productList[index]);
                  },
                  leading: productList![index].imagePath.isEmpty ? Icon(Icons.ac_unit) : Image.network(productList![index].imagePath, width: 80, height: 80, fit: BoxFit.cover),
                  title: Text('${productList![index].title}'),
                  subtitle: Text('${productList[index].description}'),
                  trailing: InkWell(
                    onTap: () {
                        delete(productList[index].id);
                    },
                    child: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('something went wrong'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }


}
