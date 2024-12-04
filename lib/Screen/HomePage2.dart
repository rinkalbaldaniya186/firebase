import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseauth111/Screen/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage2 extends StatefulWidget {
  final String email;

  const HomePage2({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _updateFN = TextEditingController();
  final TextEditingController _updateLN = TextEditingController();
  final TextEditingController _updateAGE = TextEditingController();

  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> _writeData(String fn, String ln, String age) async {
    DatabaseReference ref = database.ref("users/123");

    await ref.set({
      "first name": fn,
      "last name": ln,
      "age": age,
    });

    _firstName.clear();
    _lastName.clear();
    _age.clear();
  }

  Future<void> _updateData(String Upfn, String Upln, String Upage) async {
    DatabaseReference ref = database.ref("users/My-Id");

    await ref.update({
      "first name": Upfn,
      "last name": Upln,
      "age": Upage,
    });

    _updateFN.clear();
    _updateLN.clear();
    _updateAGE.clear();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page 2'),
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                    const SizedBox(height: 20),
                    _buildTextField(_firstName, 'First Name'),
                    const SizedBox(height: 20),
                    _buildTextField(_lastName, 'Last Name'),
                    const SizedBox(height: 20),
                    _buildTextField(_age, 'Age'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String fn = _firstName.text;
                        String ln = _lastName.text;
                        String age = _age.text;
                        _writeData(fn, ln, age);
                      },
                      child: const Text('Add Data'),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_updateFN, 'Update First Name'),
                    const SizedBox(height: 20),
                    _buildTextField(_updateLN, 'Update Last Name'),
                    const SizedBox(height: 20),
                    _buildTextField(_updateAGE, 'Update Age'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String Upfn = _updateFN.text;
                        String Upln = _updateLN.text;
                        String Upage = _updateAGE.text;
                        _updateData(Upfn, Upln, Upage);
                      },
                      child: const Text('Update Data'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint,
      ),
    );
  }
}
