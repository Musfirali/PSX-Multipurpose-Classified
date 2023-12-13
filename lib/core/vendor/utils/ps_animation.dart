import 'package:flutter/animation.dart';

Animation<double> curveAnimation(AnimationController controller,
    {int count = 2, int index = 1}) {
  return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    parent: controller,
    curve: Interval((1 / count) * index, 1, curve: Curves.fastOutSlowIn),
  ));
}
