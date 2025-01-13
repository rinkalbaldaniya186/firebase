import 'package:firebaseauth111/lib1/database/db_helper.dart';
import 'package:firebaseauth111/lib1/firebase/firebase_service.dart';
import 'package:firebaseauth111/lib1/model/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// import 'package:shoppio_flutter_app/database/db_helper.dart';
// import 'package:shoppio_flutter_app/firebase/firebase_service.dart';
// import 'package:shoppio_flutter_app/model/product.dart';
import 'dart:io';
import '../../../model/category.dart';

class Body extends StatefulWidget {
  Product? product;

  Body(this.product);

  @override
  State<Body> createState() => _BodyState(product);
}

class _BodyState extends State<Body> {
  List<Category> categoryList = [];

  int categoryId = -1;
  String? existingUrl;

  Product? product;

  _BodyState(this.product);

  final DbHelper _dbHelper = DbHelper();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController(text: '0.0');
  final _discountController = TextEditingController(text: '0');

  FirebaseService _service = FirebaseService();
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  void addProduct(Product product, BuildContext context) {
    _service.addProduct(product).then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  Future<void> pickImageFromCamera() async {
    var tempFile =
        await imagePicker.pickImage(source: ImageSource.camera); // XFile

    if (tempFile != null) {
      // print('path : ${tempFile.path}');
      var file = File(tempFile.path);

      print('imagePath (camera) : ${file.path}');
      print('fileName : ${basename(file.path)}'); // used to get fileName
      setState(() {
        imageFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  pickImageFromCamera();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.30),
                  radius: 60,
                  /* backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : AssetImage('assets/images/user.png') as ImageProvider,*/
                  child: imageFile != null
                      ? CircleAvatar(
                          radius: 60,
                          foregroundImage: FileImage(imageFile!),
                        )
                      : existingUrl != null
                          ? CircleAvatar(
                              radius: 60,
                              foregroundImage: NetworkImage(existingUrl!),
                            )
                          : Icon(
                              Icons.add,
                              size: 50,
                              color: Colors.black45,
                            ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              buildTitleFormField(),
              SizedBox(
                height: 16,
              ),
              buildDescriptionFormField(),
              SizedBox(
                height: 24,
              ),
              buildCategoryFormField(),
              SizedBox(
                height: 24,
              ),
              buildPriceFormField(),
              SizedBox(
                height: 24,
              ),
              buildAddProductButtonWidget(context),
              SizedBox(
                height: 24,
              ),
              /*  ElevatedButton(onPressed: () {
                File tempFile = File('/data/user/0/com.example.shoppio_app_flutter/files/1688204156419.jpg');
                setState(() {
                  imageFile = tempFile;
                });
              }, child: Text('GET FILE FROM INTERNAL STORAGE'))*/
            ],
          ),
        ),
      ),
    );
  }

  buildPriceFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter amount';
              } else {
                return null;
              }
            },
            onSaved: (newValue) {},
            decoration: InputDecoration(
              labelText: "Price",
              hintText: 'Enter Price',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: TextFormField(
            controller: _discountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter discount';
              } else {
                return null;
              }
            },
            onSaved: (newValue) {},
            decoration: InputDecoration(
              labelText: "Discount",
              hintText: 'Enter Discount',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
        )
      ],
    );
  }

  buildTitleFormField() {
    return TextFormField(
      controller: _titleController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Product",
        hintText: 'Product Name',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildDescriptionFormField() {
    return TextFormField(
      controller: _descController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: 'Product Description',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildCategoryFormField() {
    return DropdownButtonFormField(
      value: product == null ? null : categoryId,
      iconEnabledColor: Colors.black45,
      validator: (value) {
        if (value == null) {
          return 'Select category';
        } else {
          return null;
        }
      },
      onSaved: (newValue) {},
      decoration: InputDecoration(
          labelText: "Category",
          hintText: 'Select Category',
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      items: categoryList.map((category) {
        return DropdownMenuItem(
          value: category.id,
          child: Text(
            '${category.title}',
          ),
        );
      }).toList(),
      onChanged: (value) {
        categoryId = value!;
      },
    );
  }

  buildAddProductButtonWidget(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      onPressed: () async {
        String title = _titleController.text.toString().trim();
        String description = _descController.text.toString().trim();
        double price = _priceController.text.toString().trim().isEmpty
            ? 0.0
            : double.parse(_priceController.text.toString().trim());
        int discount = _discountController.text.toString().trim().isEmpty
            ? 0
            : int.parse(_discountController.text.toString().trim());

        var path = await saveImage(imageFile);
        print('imagePath : ${path}');

        if(path==null){
          print('please select image first');
          return;
        }


        if (product != null) {
          // update
          _service.updateProduct(
              title, description, categoryId, discount, price, product!.id, path!);
          Navigator.pop(context);
        } else {
          // add
          Product product = Product(
              title: title,
              description: description,
              mrp: price,
              discount: discount,
              categoryId: categoryId,
              imagePath: path!);
          addProduct(product, context);
        }

        /*print('''
          title : $title
          description : $description
          price : $price
          discount : $discount
          categoryId : $categoryId
        ''');*/
      },
      child: Text(
        product != null ? 'Update Product' : 'Add Product',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> getCategoryList() async {
    var list = await _dbHelper.getCategoryList();
    setState(() {
      categoryList = list;

      if (product != null) {
        _titleController.text = product!.title;
        _priceController.text = '${product!.mrp}';
        _descController.text = product!.description;
        _discountController.text = '${product!.discount}';
        categoryId = product!.categoryId;
        existingUrl = product!.imagePath;
      }
    });
  }

  Future<String?> saveImage(File? imageFile) async {
      if(imageFile!=null){
        // save to storage
        return await _service.uploadProduct(imageFile);
      }else{
        return existingUrl;
      }
  }
}
