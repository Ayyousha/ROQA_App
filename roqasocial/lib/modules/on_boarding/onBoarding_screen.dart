import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <RoqaMainCubit,RoqaMainStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var c = RoqaMainCubit.get(context);

       return Scaffold(
         backgroundColor: Colors.indigo[500],
         body: Column(
           children: [
             Expanded(
               flex: 23,
               child: PageView.builder(
                 scrollDirection: Axis.vertical,
                 onPageChanged: (value) {},
                 controller: c.boardController,
                 itemBuilder: (context, index) => c.boarding[index],
                 itemCount: c.boarding.length,
               ),
             ),

             Expanded(
               child: Container(
                 width: double.infinity,
                 color: Colors.indigo[500],
                 child: Center(
                   child: SmoothPageIndicator(
                     controller: c.boardController,
                     count: c.boarding.length,
                     effect: ExpandingDotsEffect(
                       dotColor: Colors.white30,
                       activeDotColor: Colors.white,
                       dotHeight: 10,
                       dotWidth: 10,
                       expansionFactor: 4,
                       spacing: 5.0,
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
       );
      }
    );
  }


}


