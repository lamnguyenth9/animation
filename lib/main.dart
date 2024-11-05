import 'package:animation/animation/add_to_cart_animation/shopping_cart_button.dart';
import 'package:animation/animation/on_boarding/animated_onboarding.dart';
import 'package:animation/animation/scroll_animation/scrollist_animation.dart';
import 'package:flutter/material.dart';

import 'animation/animated_list/my_animated_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAnimatedList(),
    );
  }
}