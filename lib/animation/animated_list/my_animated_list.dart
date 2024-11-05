import 'package:animation/animation/animated_list/model.dart';
import 'package:flutter/material.dart';

class MyAnimatedList extends StatefulWidget {
  const MyAnimatedList({super.key});

  @override
  State<MyAnimatedList> createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList> {
  final List<User> selectedUser=[];
  final GlobalKey<AnimatedListState> itemKey=GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> selectedKey=GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(right: 25, left: 25, top: 10),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12),
              child: Column(
                children: [
                  Text("Selected Member"),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(child: AnimatedList(
                    key: selectedKey,
                    scrollDirection: Axis.horizontal,
                    initialItemCount: selectedUser.length,
                    itemBuilder: (context, index, animation) {
                    return  displaySelectedItem(animation:animation, index:index,user: selectedUser[index]);
                  },))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: AnimatedList(
                  key: itemKey,
              initialItemCount: users.length,
              itemBuilder: (context, index, animation) {
                return userItems(index: index, animation: animation, user: users[index  ]);
              },
            ))
          ],
        ),
      )),
    );
  }

  Padding displaySelectedItem({required Animation<double> animation, required int index,required User user}) {
    return Padding(padding: EdgeInsets.only(right: 20),
                  child: FadeTransition(opacity: animation,
                  child: Column(
                    children: [
                        SizedBox(width: 50,
                        child: Text(
                          maxLines: 1,
                          users[index].name
                        ),),
                        SizedBox(height: 5,),
                        Stack(
                          children: [
                            Positioned(
                              child:SizedBox(
                                height: 70,
                                width: 70,
                                child: CircleAvatar(
                                  backgroundColor: Colors.deepPurpleAccent,
                                  backgroundImage: NetworkImage(users[index].image),
                                ),
                              ) ),
                                 Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: (){
                                      itemKey.currentState?.insertItem(users.length,
                                      duration: Duration(microseconds: 500));
                                      selectedKey.currentState?.removeItem(index, (context, animation) {
                                        return displaySelectedItem(animation: animation, index: index, user: user);
                                        
                                      },);
                                      selectedUser.remove(user);
                                      users.add(user);
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        
                                        shape: BoxShape.circle,color: Colors.white
                                      ),
                                      child: Icon(Icons.close,size: 15,),
                                    ),
                                  ))
                          ],
                        )
                    ],
                  ),),);
  }

  GestureDetector userItems({required Animation<double> animation, required int index,required User user}) {
    return GestureDetector(
                onTap: () {
                 if(selectedUser.length>4) return;
                  itemKey.currentState?.removeItem(index, (context, animation) {
                    return userItems(animation: animation, index: index, user: user);
                  },);
                    selectedKey.currentState!.insertItem(selectedUser.length,duration: Duration(microseconds: 500));
                    selectedUser.add(user);
                    users.remove(user);
                  
                },
                child: FadeTransition(
                  opacity: animation,
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent,
                            backgroundImage: NetworkImage(users[index].image),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(users[index].name),
                            Text(users[index].username)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
  }
}
