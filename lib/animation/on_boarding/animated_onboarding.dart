import 'package:animation/animation/on_boarding/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
class AnimatedOnboarding extends StatefulWidget {
  const AnimatedOnboarding({super.key});

  @override
  State<AnimatedOnboarding> createState() => _AnimatedOnboardingState();
}

class _AnimatedOnboardingState extends State<AnimatedOnboarding> {
  final PageController _controller=PageController();
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPaint(),
            child: SizedBox(
              height: size.height / 1.35,
              width: size.width,
            ),
          ),
          Positioned(
            top: 30,
            right: 0,left: 0,
            child: Lottie.network(onboardintItems[currentIndex].lottieURL,
            width: 500,
            alignment: Alignment.topCenter,)),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 270,
                child: Column(
                  children: [
                    Flexible(child: PageView.builder(
                      controller: _controller,
                      itemCount: onboardintItems.length,
                      itemBuilder: (context, index) {
                        final item=onboardintItems[index];
                        return Column(
                          children: [
                              Text(item.subtitle,
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                
                                fontSize: 18,
                                color: Colors.black45
                              ),),
                              SizedBox(height: 50,),
                              Text(item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black
                              ),),

                          ],
                        );
                        
                      },
                      onPageChanged: (value){
                        setState(() {
                          currentIndex=value;
                        });
                      },)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           for(int index=0;index<onboardintItems.length;index++)
                           doIndicator(isSelected: index==currentIndex)
                        ],
                      ),
                      SizedBox(height: 50,)
                  ],
                ),
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
         _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
      }),
    );
  }
}
Widget doIndicator({required bool isSelected}){
  return Padding(padding: EdgeInsets.only(right: 7),
  child: AnimatedContainer(duration: Duration(microseconds: 500),
  height: isSelected ?8:6,
  width: isSelected?8:6,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: isSelected?Colors.black:Colors.black26
  ),),);
}

class ArcPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 175)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 175)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(orangeArc, Paint()..color = Colors.orange);
    //White
    Path whiteArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 180)
      ..quadraticBezierTo(
          size.width / 2, size.height - 60, size.width, size.height - 180)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(
        whiteArc, Paint()..color = Color.fromARGB(255, 144, 202, 249));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
