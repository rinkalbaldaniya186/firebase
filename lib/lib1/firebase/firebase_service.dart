import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseauth111/lib1/model/app_user.dart';
import 'package:path/path.dart';
// import 'package:shoppio_flutter_app/model/app_user.dart';

import '../model/product.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    // factory constructor
    return _instance;
  }

  FirebaseService._internal(); // named constructor

  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  final DatabaseReference _mRef = FirebaseDatabase.instance.ref(); // getting path of root node
  final Reference _storageRef = FirebaseStorage.instance.ref();

  Future<dynamic> login(String email, String password) async {
    try {
      UserCredential credential = await _mAuth.signInWithEmailAndPassword(email: email, password: password);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<dynamic> signUp(String email, String password) async {
    try {
      final credential = await _mAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    return await _mAuth.signOut();
  }

  /***********************************FirebaseDatabase***************************************/

  // insert data into firebase real time database
  Future<void> createUser(AppUser user) async {
    await _mRef.child('user-node').child(user.id!).set(user.toMap());
  }

  // add product into firebase real time database
  Future<bool> addProduct(Product product) async {
    var id = _mRef.push().key;
    if (id != null) {
      product.id = id;
      await _mRef.child('product-node').child(product.id!).set(product.toMap());
      return true;
    }
    return false;
  }

  // get all product list
  Stream<List<Product>> getProductList() {
    return _mRef.child('product-node').onValue.map((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>;
      if (map == null) {
        return [];
      }

      return map.values.map((e) {
        Map<dynamic, dynamic> value = e;
        return Product.fromMap(value);
      }).toList();
    });
  }

  // delete product
  Future<bool> deleteProduct(String pId) async {
    try {
      await _mRef.child('product-node').child(pId).remove();
      return true;
    } catch (e) {}
    return false;
  }

  Future<void> updateProduct(String title, String desc, int catId, int dis, double price, String? pId, String path) async {
      await _mRef.child('product-node').child(pId!).update({
        'title': title,
        'description':desc,
        'categoryId': catId,
        'mrp' : price,
        'discount':dis,
        'imagePath':path
      });
  }

  /***********************************FirebaseDatabase***************************************/

  Future<String?> uploadProduct(File imageFile) async {

    String? url;

    try {
      String fileName = basename(imageFile.path);     // get file name
      var ex = extension(fileName);     // will get extension from file name
      String mFileName = '${DateTime.now().millisecondsSinceEpoch}$ex';

      await _storageRef.child('product').child(mFileName).putFile(imageFile);     // to store file in FirebaseStorage
      url = await _storageRef.child('product').child(mFileName).getDownloadURL();   // to get downloadUrl from stored image

    } on FirebaseException catch (e) {

    }
    return url;
  }


}
