import 'dart:io';

import 'package:firebaseauth111/lib1/database/db_helper.dart';
import 'package:firebaseauth111/lib1/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:shoppio_flutter_app/database/db_helper.dart';
// import 'package:shoppio_flutter_app/model/category.dart';

class Body extends StatefulWidget {
  Category? category;

  Body(this.category);

  @override
  State<Body> createState() => _BodyState(category);
}

class _BodyState extends State<Body> {
  Category? category;

  _BodyState(this.category);

  final titleController = TextEditingController();
  final descController = TextEditingController();

  File? imageFile;

  ImagePicker imagePicker = ImagePicker();

  DbHelper dbHelper = DbHelper();

  Future<void> pickImageFromGallery() async {
    var tempFile =
        await imagePicker.pickImage(source: ImageSource.gallery); // XFile

    if (tempFile != null) {
      // print('path : ${tempFile.path}');
      var file = File(tempFile.path);

      print('imagePath (gallery) : ${file.path}');
      print('fileName : ${basename(file.path)}'); // used to get fileName
      setState(() {
        imageFile = file;
      });
    }
  }

  Future<void> addCategory(Category category, BuildContext context) async {
    int? id = await dbHelper.insert(category);

    if (id != -1) {
      print('category added successfully');
      category.id = id;
      Navigator.pop(context, category);
    } else {
      print('getting error');
    }
  }

  Future<void> updateCategory(Category category, BuildContext context) async {
    int? id = await dbHelper.update(category);

    if (id != -1) {
      print('category updated successfully');
      Navigator.pop(context, category);
    } else {
      print('getting error');
    }
  }

  Future<String?> saveImage(File imageFile) async {
    String name = basename(imageFile.path);
    print('name : $name');

    Directory root = await getApplicationSupportDirectory();

    String existPath = join(root.path, name);
    File mFile = File(existPath);

    if (await mFile.exists() == false) {
      print('file created');
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.svg';
      print(root);
      print(fileName);
      var path = await join(root.path, fileName);
      File file = await imageFile.copy(path);
      return file.path;

    }
    return imageFile.path;
  }

  @override
  void initState() {
    if (category != null) {
      //update
      titleController.text = category!.title ?? '';
      descController.text = category!.description ?? '';
      imageFile = File(category!.imagePath!);
    }
    super.initState();
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
                  pickImageFromGallery();

                  /*  Directory tempDir = await getTemporaryDirectory();
                  print('tempDirectory : ${tempDir.path}');

                  Directory documentDir = await getApplicationDocumentsDirectory();
                  print('documentDirectory : ${documentDir.path}');

                  Directory supportDir = await getApplicationSupportDirectory();
                  print('supportDirectory : ${supportDir.path}');*/
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.30),
                  radius: 60,
                  /* backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : AssetImage('assets/images/user.png') as ImageProvider,*/
                  child: imageFile != null
                      ? SvgPicture.file(
                          imageFile!,
                          height: 50,
                          colorFilter:
                              ColorFilter.mode(Colors.black45, BlendMode.srcIn),
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
              buildAddCategoryButtonWidget(context),
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

  buildTitleFormField() {
    return TextFormField(
      controller: titleController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Category",
        hintText: 'Category Name',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildDescriptionFormField() {
    return TextFormField(
      controller: descController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: 'Description',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildAddCategoryButtonWidget(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      onPressed: () async {
        String title = titleController.text.toString().trim();
        String desc = descController.text.toString().trim();

        if (imageFile != null) {
          var path = await saveImage(imageFile!);
          print('imagePath (database) : $path');

          if (path != null) {
            if (category != null) {
              // update
              Category cat = Category.withId(
                  title: title,
                  description: desc,
                  id: category!.id,
                  date: category!.date, imagePath: path);
              updateCategory(cat, context);
            } else {
              // add
              Category category =
                  Category(title: title, description: desc, imagePath: path);
              addCategory(category, context);
            }
          }
        }
      },
      child: Text(
        category == null ? 'Add Category' : 'Update Category',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
