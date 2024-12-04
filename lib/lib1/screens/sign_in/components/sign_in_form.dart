import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/firebase/firebase_service.dart';
// import 'package:shoppio_flutter_app/preference/pref_utils.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';
// import 'package:shoppio_flutter_app/utils/utils.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../firebase/firebase_service.dart';
import '../../../routes/app_route.dart';
import '../../../utils/utils.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError, _passwordError;

  FirebaseService _service = FirebaseService();

  Future<void> login(String email, String password, BuildContext context) async {
    var credential = await _service.login(email, password);

    if (credential is UserCredential) {
      // success
      if (credential!.user != null) {
        print('uid : ${credential!.user!.uid}');
        // navigate to home screen
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoute.homeScreen, (route) => false);
      }
    } else if (credential is String) {
      // failed
      print(credential);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildEmailFormField(),
          SizedBox(
            height: 24,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: 24,
          ),
          buildForgotPasswordWidget(context),
          SizedBox(
            height: 24,
          ),
          buildLoginButtonWidget(context)
        ],
      ),
    );
  }

  buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email address',
        labelText: 'Email',
        errorText: _emailError,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Mail.svg'),
      ),
    );
  }

  buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: 'Enter password',
        errorText: _passwordError,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Lock.svg'),
      ),
    );
  }

  buildForgotPasswordWidget(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "Forgot Password",
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  buildLoginButtonWidget(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      onPressed: () {
        // get all values from form field
        String email = _emailController.text.toString().trim();
        String password = _passwordController.text.toString().trim();

        resetFocus();

        if (!Utils.isValidEmail(email)) {
          // show error on email field
          setState(() {
            _emailError = 'Enter valid email address';
          });
        } else if (!Utils.isValidPassword(password)) {
          // show error on password field
          setState(() {
            _passwordError = 'Enter valid password';
          });
        } else {
          // navigate to home screen
          // store this data to database or server

          login(email, password, context);

          /* PrefUtils.updateLoginStatus(true).then((value) {
            if(value){
              Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (route) => false);
            }
          });*/
        }
      },
      child: Text(
        'Sign In',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  void resetFocus() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });
  }
}
