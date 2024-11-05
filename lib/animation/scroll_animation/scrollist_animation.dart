import 'package:animation/animation/scroll_animation/scroll_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScrollistAnimation extends StatefulWidget {
  const ScrollistAnimation({super.key});

  @override
  State<ScrollistAnimation> createState() => _ScrollistAnimationState();
}

class _ScrollistAnimationState extends State<ScrollistAnimation> {
  ScrollController controller=ScrollController();
  bool closeContainer = false;
  double myTopContainer=0;
  List<Widget> myItems=[];
  @override
  void initState() {
    myBodyItems();
    controller.addListener((){
      double value=controller.offset/120;
      setState(() {
        myTopContainer=value;
        closeContainer=controller.offset>50;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            AnimatedOpacity(
              opacity: closeContainer ? 0 : 1,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeContainer ? 0 : size.height * 0.31,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Discover",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black45),
                          ),
                          Spacer(),
                          Text("View all",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black45)),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            dicoverItems(size, Colors.orangeAccent,
                                "Most favorite", "20 Items"),
                            dicoverItems(size, Colors.blue,
                                "Newest", "20 Items"),
                            dicoverItems(size, Colors.green.shade400,
                                "Super saving", "20 Items"),
                            
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text("My coupons",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black45
              ),),),
              Expanded(child: ListView.builder(
                controller: controller,
                itemCount: myItems.length,
                itemBuilder: (context, index) {
                double opacity=1;
                if(myTopContainer>0.5){
                  opacity=index+0.5-myTopContainer;
                  if(opacity<0){
                    opacity=0;
                  }else if(opacity>1){
                    opacity=1;
                  }
                }
                  return  Opacity(
                    opacity:opacity,
                    child: Transform(
                      transform: Matrix4.identity()..scale(opacity,opacity),
                      alignment: Alignment.topCenter,
                      child: Align(
                        heightFactor: 0.7,
                        child: myItems[index],
                      ),
                      ), ) ;
                },))
          ],
        ),
      )),
    );
  }
 void myBodyItems(){
  List<Widget> listItems=[];
  for(ScrollItems items in dataItems){
    listItems.add(
      Container(
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        decoration: BoxDecoration(
          color: Color(items.color),
          boxShadow: const [
            BoxShadow(color: Colors.black26,blurRadius: 5)
          ]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              items.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
            Image.asset("assets/${items.image}")
          ],
        ),
      )
    );
  }
  setState(() {
    myItems=listItems;
  });
 }
  Container dicoverItems(Size size, Color color, String name, String item) {
    return Container(
      height: size.height * 0.23,
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.2,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
            const Positioned(
              bottom: 10,
              right: 5,
              child: Icon(
                Icons.favorite_border_sharp,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
