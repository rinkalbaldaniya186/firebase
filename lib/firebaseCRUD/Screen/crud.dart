import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebaseauth111/firebase_options.dart';

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

class _MainpageState extends State<Mainpage> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _course = TextEditingController();
  final TextEditingController _fees = TextEditingController();

  FirebaseFirestore docUser = FirebaseFirestore.instance;
  List<DocumentSnapshot> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    QuerySnapshot querySnapshot = await docUser.collection('users').get();
    setState(() {
      users = querySnapshot.docs;
    });
  }

  Future<void> createUser(String fn, String ln, String dob, String course, String fees) async {
    final user = <String, dynamic>{
      'first name': fn,
      'last name': ln,
      'date of birth': dob,
      'course': course,
      'fees': fees,
    };

    await docUser.collection('users').add(user);
    fetchUsers(); // Refresh user list
  }

  Future<void> updateUser(String id, String fn, String ln, String dob, String course, String fees) async {
    final user = <String, dynamic>{
      'first name': fn,
      'last name': ln,
      'date of birth': dob,
      'course': course,
      'fees': fees,
    };

    await docUser.collection('users').doc(id).update(user);
    fetchUsers(); // Refresh user list
  }

  Future<void> deleteUser(String id) async {
    await docUser.collection('users').doc(id).delete();
    fetchUsers(); // Refresh user list
  }

  void populateFields(DocumentSnapshot user) {
    _firstName.text = user['first name'];
    _lastName.text = user['last name'];
    _dob.text = user['date of birth'];
    _course.text = user['course'];
    _fees.text = user['fees'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management"),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // Input Fields
                  TextField(
                    controller: _firstName,
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'First Name'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _lastName,
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Last Name'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _dob,
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Date of Birth'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _course,
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Course'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _fees,
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Fees'),
                  ),
                  SizedBox(height: 20),
                  // Add Button
                  Container(
                    color: Colors.lightBlue.shade300,
                    height: 50,
                    width: 320,
                    child: TextButton(
                      onPressed: () async {
                        String fn = _firstName.text;
                        String ln = _lastName.text;
                        String dob = _dob.text;
                        String course = _course.text;
                        String fees = _fees.text;

                        await createUser(fn, ln, dob, course, fees);
                        _firstName.clear();
                        _lastName.clear();
                        _dob.clear();
                        _course.clear();
                        _fees.clear();
                      },
                      child: Text(
                        'Add User',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  // User List
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text('${user['first name']} ${user['last name']}'),
                        subtitle: Text('DOB: ${user['date of birth']} | Course: ${user['course']} | Fees: ${user['fees']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                populateFields(user);
                                // Optionally, you can store the user ID for updates
                                // so you can update this specific user
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteUser(user.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
