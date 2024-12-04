import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth111/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
    );
  }
}

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _professionController = TextEditingController();
CollectionReference _users = FirebaseFirestore.instance.collection('users1');

void _addUser() {
  _users.add({
    'name': _nameController.text,
    'profession': _professionController.text,
  });
  _nameController.clear();
  _professionController.clear();
}

void _editUser(DocumentSnapshot user, BuildContext context) {
  _nameController.text = user['name'];
  _professionController.text = user['profession'];
  
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text('Edit User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'User Name'),
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: _professionController,
            decoration: InputDecoration(labelText: 'User Profession'),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
               Navigator.pop(context);
             },
            child: Text('Cancel'),
        ),
        ElevatedButton(
            onPressed: () {
                _updateUser(user.id);
                Navigator.pop(context);
             },
            child: Text('Update'),
        )
      ],
    );
   }
  );
}

void _updateUser(String userId) {
  _users.doc(userId).update({
    'name': _nameController.text,
    'profession': _professionController.text,
  });
  _nameController.clear();
  _professionController.clear();
}

void _deleteUser(String userId) {
  _users.doc(userId).delete();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD APP"),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter User Name'
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _professionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter User Profession'
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                     _addUser();
                  },
                  child: Text('Add User')
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(child:
                StreamBuilder(
                    stream: _users.snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var user = snapshot.data?.docs[index];
                          var userData = user?.data() as Map<String, dynamic>?; // Cast to the correct type
                          var name = userData?['name'] ?? 'No Name';
                          return Dismissible(
                            key: Key(user!.id),
                            background: Container(
                              color: Colors.redAccent,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.delete, color: Colors.white,),
                            ),
                            onDismissed: (direction) {
                              _deleteUser(user.id);
                            },
                            direction: DismissDirection.endToStart,
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle: Text(user?['profession'],
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      _editUser(user,context);
                                    },
                                    icon: Icon(Icons.edit)
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                )
              )
            ],
          ),
        ),
    );
  }
}

//SingleChildScrollView(
//         child: Container(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _firstName,
//                     decoration: InputDecoration(
//                       hintText: 'First Name',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.lightBlue.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _lastName,
//                     decoration: InputDecoration(
//                       hintText: 'Last Name',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.lightBlue.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _dob,
//                     decoration: InputDecoration(
//                       hintText: 'Date of Birth',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.lightBlue.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _course,
//                     decoration: InputDecoration(
//                       hintText: 'Course',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.lightBlue.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _fees,
//                     decoration: InputDecoration(
//                       hintText: 'Fees',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.lightBlue.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     color: Colors.lightBlue.shade300,
//                     height: 50,
//                     width: 320,
//                     child: TextButton(onPressed: () {
//                         String fn = _firstName.text;
//                         String ln = _lastName.text;
//                         String age = _dob.text;
//                         String course = _course.text;
//                         String fees = _fees.text;
//
//                         createUser(fn,ln,age,course,fees);
//
//                         // Clear the text fields after adding data
//                         _firstName.clear();
//                         _lastName.clear();
//                         _dob.clear();
//                         _course.clear();
//                         _fees.clear();
//
//                      }, child: Text('Add Data',style: TextStyle(color: Colors.white, fontSize: 20),)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )