import 'dart:math';

import 'package:animation/animation/dowload_button_animation/custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DowloadButtonAnimation extends StatefulWidget {
  const DowloadButtonAnimation({super.key});

  @override
  State<DowloadButtonAnimation> createState() => _DowloadButtonAnimationState();
}

class _DowloadButtonAnimationState extends State<DowloadButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
        _animationController.addStatusListener((status){
          if(status==AnimationStatus.completed){
            return _animationController.reset();
          }
        });
    super.initState();
  }

  late final Animation<double> width = Tween<double>(begin: 250, end: 110)
      .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0, 0.3, curve: Curves.fastOutSlowIn)));

  late final Animation<double> fontSize = Tween<double>(begin: 30, end: 0)
      .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0, 0.3, curve: Curves.fastOutSlowIn)));
  late final Animation<double> opacity = TweenSequence([
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
        weight: 50),
    TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
        weight: 50),
  ]).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.03, 0.5, curve: Curves.fastOutSlowIn),
    ),
  );

  late final Animation<double> arc =
      Tween<double>(begin: 0.0, end: 2 * pi).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 0.8, curve: Curves.fastOutSlowIn),
    ),
  );
  Offset firstDot = const Offset(-15, 5);
  Offset firstCommon = const Offset(-5, 15);
  Offset secondDot = const Offset(20, -10);
  late final Animation<Offset> first =
      Tween<Offset>(begin: firstDot, end: firstCommon).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.900, 0.99, curve: Curves.fastOutSlowIn),
    ),
  );
  late final Animation<Offset> second =
      Tween<Offset>(begin: firstCommon, end: secondDot).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.900, 0.99, curve: Curves.fastOutSlowIn),
    ),
  );
  late final Animation<Offset> centerDot =
      Tween<Offset>(begin: Offset.zero, end: firstDot).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 0.9, curve: Curves.fastOutSlowIn),
    ),
  );
// for  animating dot size
  late final Animation<double> dotSize =
      Tween<double>(begin: 8.0, end: 3.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 0.9, curve: Curves.fastOutSlowIn),
    ),
  );
  // for  animating dot opacity
  late final Animation<double> dotOpacity =
      Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 0.3, curve: Curves.fastOutSlowIn),
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              _animationController.forward();
            },
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: width.value,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.blue, width: 5),
                      ),
                      child: Center(
                        child: Text(
                          "Download",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize.value),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: opacity.value,
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.black,
                      ),
                    ),
                    CustomPaint(
                      painter:
                          ArcPaint(startAngle: -pi / 2, endAngle: arc.value),
                    ),
                    CustomPaint(
                      painter: LinerPaint(
                          first: first,
                          second: second,
                          firstDot: firstDot,
                          firstCommon: firstCommon,
                          secondDot: secondDot),
                    ),
                    Opacity(
                      opacity: opacity.value,
                      child: CustomPaint(
                        painter: DotPainter(
                            radius: dotSize.value, offset: centerDot.value),
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
