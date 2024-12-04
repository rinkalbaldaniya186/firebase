import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumberScreen extends StatefulWidget {
  const LoginWithPhoneNumberScreen({super.key});

  @override
  State<LoginWithPhoneNumberScreen> createState() => _LoginWithPhoneNumberScreenState();
}

TextEditingController _phoneNumber = TextEditingController();
TextEditingController _codeOTP = TextEditingController();
String _verificationId = '';
String _smsCode = '';
FirebaseAuth auth = FirebaseAuth.instance;

Future<void> _getOTP(String mobnum) async {

  await auth.verifyPhoneNumber(
    phoneNumber: mobnum,
    verificationCompleted: (PhoneAuthCredential credential) {
      print('Verification completed');
    },
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      else
        print(e.message);
    },
    codeSent: (String verificationId, int? resendToken) async {
      _verificationId = verificationId;
      print('Resend Token : $resendToken');
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

Future<void> _signInWithPhoneNumber(String _smsCode) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );
    await auth.signInWithCredential(credential);
    // Navigate to home screen or show success message
  } catch (e) {
    print('Error while signinwithPhonenumber: $e');
  }
}

class _LoginWithPhoneNumberScreenState extends State<LoginWithPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
            ),
         ),
         child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter Mobile Number with Country Code',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
                      filled: true,
                      hintText: 'Mobile Number',
                      fillColor: Colors.white54,
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _codeOTP,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
                      filled: true,
                      hintText: 'OTP',
                      fillColor: Colors.white54,
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _getOTP(_phoneNumber.text);
                        },
                        child: Text("Get OTP"),
                        style: ElevatedButton.styleFrom(
                          //primary: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(width: 40,),
                      ElevatedButton(
                        onPressed: () {
                            _smsCode = _codeOTP.text;
                            _signInWithPhoneNumber(_smsCode);
                        },
                        child: Text('Login Now')
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
   );
  }
}
