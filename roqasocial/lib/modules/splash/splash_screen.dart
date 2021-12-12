
import 'package:flutter/material.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/layout/social_layout.dart';
import 'package:roqasocial/modules/on_boarding/onBoarding_screen.dart';
import 'package:roqasocial/shared/components/components.dart';
import 'package:roqasocial/shared/components/constance.dart';
import 'package:roqasocial/shared/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async
  {
    uId = CacheHelper.getData(key: 'uId');

    await Future.delayed(Duration(milliseconds: 2500));
    if(uId != null)
    {
      NavigateAndFinish(context, HomeLayoutScreen());
    } else
      {
        NavigateAndFinish(context, OnBoardingScreen());
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 170),
              child: Column(
                children: [
                  Text(
                    'RoQa Social',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80,),
                    child: LinearProgressIndicator(),
                  ),
                ],
              ),
            ),

            Text('from ',style: TextStyle(color: Colors.grey,fontSize: 15),),
            SizedBox(height: 5,),
            Text('3YoUsHa',style: TextStyle(color: Colors.indigo,fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
