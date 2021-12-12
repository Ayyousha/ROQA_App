// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roqasocial/layout/cubit/cubit.dart';
// import 'package:roqasocial/layout/cubit/states.dart';
// import 'package:roqasocial/modules/onBoarding_screen.dart';
// import 'package:roqasocial/shared/bloc_observer.dart';
// import 'package:roqasocial/shared/components/constance.dart';
// import 'package:roqasocial/shared/network/local/cache_helper.dart';
// import 'package:roqasocial/shared/style/themes.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/layout/social_layout.dart';
import 'package:roqasocial/modules/login/cubit/cubit.dart';
import 'package:roqasocial/modules/on_boarding/onBoarding_screen.dart';
import 'package:roqasocial/modules/register/cubit/cubit.dart';
import 'package:roqasocial/shared/bloc_observer.dart';
import 'package:roqasocial/shared/components/constance.dart';
import 'package:roqasocial/shared/network/local/cache_helper.dart';
import 'package:roqasocial/shared/style/themes.dart';

import 'modules/splash/splash_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  /// Foreground FCM
  FirebaseMessaging.onMessage.listen((event) {});
  /// When Click on Notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  /// Background FCM
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if(uId != null) {widget = HomeLayoutScreen();}
  else widget = OnBoardingScreen();


  runApp( MyApp(
    StartWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
 final Widget? StartWidget;

 MyApp({
    this.StartWidget,
});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // if( uId != null)
        BlocProvider(create: (context) => RoqaMainCubit()
          ..getUsers()
          ..getPostData()
          ..getAllUsers()
          ..getComments(),
        ),
        BlocProvider(create: (context) => RoqaLoginCubit(),
        ),
        BlocProvider(create: (context) => RoqaRegisterCubit(),
        ),


      ],
      child: BlocConsumer<RoqaMainCubit,RoqaMainStates>(
          listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightTheme,
            // darkTheme: DarkTheme,
            home: HomeLayoutScreen(),
          );
        },
      ),
    );
  }
}


