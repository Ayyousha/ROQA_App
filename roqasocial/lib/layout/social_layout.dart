
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/modules/post/post_screen.dart';
import 'package:roqasocial/shared/components/components.dart';

class HomeLayoutScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c =  RoqaMainCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              c.Screens[c.currentIndex],
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: size.width,
                  height: 70,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomPainter(),
                      ),
                      Center(
                        heightFactor: 0.5,
                        child:
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child:  FloatingActionButton(
                                  heroTag: null,
                                  backgroundColor: Colors.indigo[500],
                                  child: Icon(Icons.add),
                                  elevation: 0.1,
                                  onPressed: ()
                                  {
                                    NavigateTo(context, PostScreen());
                                  }
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.home,
                                color: c.currentIndex == 0 ? Colors.indigo[500] : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                c.setBottomBarIndex(0);
                              },
                              splashColor: Colors.white,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.chat,
                                  color: c.currentIndex == 1 ? Colors.indigo[500] : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  c.setBottomBarIndex(1);
                                }),
                            Container(
                              width: size.width * 0.20,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.supervised_user_circle,
                                  color: c.currentIndex == 2 ? Colors.indigo[500] : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  c.setBottomBarIndex(2);
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.person,
                                  color: c.currentIndex == 3 ? Colors.indigo[500] : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  c.setBottomBarIndex(3);
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}