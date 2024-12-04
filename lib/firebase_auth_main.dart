import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth111/Screen/SignUpPage.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

void main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Done Initialize App');
  }
  catch(e){
    print('Error >>>>>> $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> CreateMethod(String email, String password) async {
    print("Method Call");
    try {
      print("Try Call");
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Credential User :- ${credential.user}");
    }
    on FirebaseAuthException catch (e) {
      print("FirebaseAuthException Call $e");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    catch (e) {
      print("Error >>>> $e");
      // print(e);
    }
  }

  Future<void> SignInMethod(String email, String password) async {
    print("Method Call");
    try {
      print("Try Call");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(credential.user != null){
        print('User Found');
        print('${credential.user!.uid}');
      }
    }
    on FirebaseAuthException catch (e) {
      print("FirebaseAuthException Call $e");
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    catch (e) {
      print("Error >>>> $e");
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Page"),
        backgroundColor: Colors.lightBlue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
            ),
            TextField(
              controller: _passwordController,
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                  // CreateMethod(_emailController.text, _passwordController.text);
                  SignInMethod(_emailController.text, _passwordController.text);
                },
                child: Text("Create User")
            ),
          ],
        ),
      ),
    );
  }
}