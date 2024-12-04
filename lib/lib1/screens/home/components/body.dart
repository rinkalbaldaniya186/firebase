import 'package:firebaseauth111/lib1/screens/home/components/header.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/screens/home/components/header.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            LayoutHeader(),
          ],
        ),
      ),
    );
  }
}
