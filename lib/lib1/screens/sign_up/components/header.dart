import 'package:flutter/material.dart';

import '../../../constants.dart';

class LayoutHeader extends StatelessWidget {
  const LayoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Register Account",
          style: headingStyle,
        ),
        SizedBox(
          height: 8,
        ),
        const Text(
          "Complete your details or continue\nwith social media",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
