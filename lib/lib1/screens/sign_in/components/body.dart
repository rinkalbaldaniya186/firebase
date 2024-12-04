import 'package:firebaseauth111/lib1/screens/sign_in/components/footer.dart';
import 'package:firebaseauth111/lib1/screens/sign_in/components/header.dart';
import 'package:firebaseauth111/lib1/screens/sign_in/components/sign_in_form.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/screens/sign_in/components/footer.dart';
// import 'package:shoppio_flutter_app/screens/sign_in/components/header.dart';
// import 'package:shoppio_flutter_app/screens/sign_in/components/sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {

          return SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      LayoutHeader(),
                      SizedBox(height: 24,),
                      SignInForm(),
                      SizedBox(height: 24,),
                      LayoutFooter(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
