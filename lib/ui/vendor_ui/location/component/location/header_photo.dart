import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderPhotoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 265,
      height: 235,
      child: SvgPicture.asset('assets/images/location_onboard.svg',
          width: double.infinity, height: 400),
    );
  }
}
