import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/components/rounded_icon_button.dart';

import '../../../components/rounded_icon_button.dart';
import '../../../components/search_field.dart';

class LayoutHeader extends StatelessWidget {
  const LayoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      /*mainAxisAlignment: MainAxisAlignment.spaceBetween,*/
      children: [
        RoundedIconButton(
          iconData: Icons.menu,
          onPress: () {
            // to open navigation drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        SizedBox(width: 10,),
        Expanded(
          child: SearchField(),
        ),
        SizedBox(width: 10,),
        RoundedIconButton(
          iconData: Icons.shopping_cart,
          onPress: () {
            print('cart icon clicked');
          },
        ),
      ],
    );
  }
}
