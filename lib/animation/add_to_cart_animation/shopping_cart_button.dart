import 'package:flutter/material.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isExpanded=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart animation button"),
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            isExpanded=!isExpanded;
          });
        },
        child: Center(
          child: AnimatedContainer(
            height: 70,
            width:isExpanded?220: 90,
            decoration: BoxDecoration(
              color:isExpanded?Colors.green: Colors.purpleAccent,
             borderRadius: BorderRadius.circular(isExpanded?50: 10)   
            ),
            duration: Duration(milliseconds: 800),
            child: Icon(
             isExpanded? Icons.check: Icons.shopping_cart,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}