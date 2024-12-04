import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSuffixIcon extends StatelessWidget {

  String svgIcon;

  CustomSuffixIcon(this.svgIcon);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        18,
        18,
        18,
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: 18,
        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.srcIn),
      ),
    );

  }

}
