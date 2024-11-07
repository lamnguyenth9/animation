import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Center(child: Text("Animated background")), 
        vsync: this, 
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnMaxRadius: 40,
            spawnMaxSpeed: 40,
            particleCount: 80,
            spawnMinSpeed: 15,
            baseColor: Colors.orange,
            image: Image(image: AssetImage("assets/images/pizza.png"))

          )
        )),
    );
  }
}