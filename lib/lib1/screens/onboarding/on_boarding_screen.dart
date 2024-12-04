import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/screens/onboarding/components/body.dart';
 import '../onboarding/components/body.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
