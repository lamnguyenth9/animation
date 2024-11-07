import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ButtonAnimation extends StatelessWidget {
  const ButtonAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const MyButtonItems(
                // ignore: sort_child_properties_last
                child: Text(
                  "Click here",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                color: Colors.white),
            const MyButtonItems(
                // ignore: sort_child_properties_last
                child: Text(
                  "Click here",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                color: Colors.pinkAccent),
            MyButtonItems(
                // ignore: sort_child_properties_last
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText("Hello"),
                    WavyAnimatedText("Look at the wawe"),
                    WavyAnimatedText("I hope to find job")
                  ],
                  isRepeatingAnimation: true,

                  ),
                color: Colors.orange)
          ],
        ),
      ),
    );
  }
}

class MyButtonItems extends StatefulWidget {
  final Widget child;
  final Color color;
  const MyButtonItems({super.key, required this.child, required this.color});

  @override
  State<MyButtonItems> createState() => _MyButtonItemsState();
}

class _MyButtonItemsState extends State<MyButtonItems>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _animationController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (state == AnimationStatus.dismissed) {
        _animationController.forward(from: 0);
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Colors.purple, widget.color, Colors.blue],
                  stops: [0, _animationController.value, 1])),
          child: widget.child,
        );
      },
    ));
  }
}
