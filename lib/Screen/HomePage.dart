import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth111/Screen/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController _firstName = TextEditingController();
TextEditingController _lastName = TextEditingController();
TextEditingController _age = TextEditingController();
FirebaseFirestore db = FirebaseFirestore.instance;
List gUser = [];


Future<void> signOutMethod(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    print('User signed out successfully.');

    var pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedin", false);
    await pref.remove("UNAME");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  } catch (e) {
    print("Sign out error: $e");
  }
}

void _addDatatoCloud(String fn, String ln, String age) {

  final user = <String, dynamic>{
    "first": fn,
    "last": ln,
    "age": age
  };

// Add a new document with a generated ID
  db.collection("users").add(user).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));

  _firstName.clear();
  _lastName.clear();
  _age.clear();
}

Future<void> _readDatatoCloud(String fn, String ln, String age) async {

  await db.collection("users").doc("QLKCBfT13AoY4OZoghRg").get().then((event) {
    var data = event.data() as Map<String, dynamic>;

    data.forEach((key, value) => gUser.add(value),);
  });

}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue.shade300,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Sign Out'),
                onTap: () => signOutMethod(context),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, ${widget.email} !!!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
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
                controller: _age,
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Age'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                String fn = _firstName.text;
                String ln = _lastName.text;
                String age = _age.text;
                _addDatatoCloud(fn,ln,age);
              }, child: Text('Add Data')),
              ElevatedButton(
                  onPressed: () {
                    String fn = _firstName.text;
                    String ln = _lastName.text;
                    String age = _age.text;
                    _readDatatoCloud(fn, ln, age);
                    setState(() {

                    });
                  },
                  child: Text('Read Data')
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: gUser.length,
                  itemBuilder: (context, index) {
                    return Text(gUser[index]);
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
