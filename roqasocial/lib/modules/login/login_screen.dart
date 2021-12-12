
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/social_layout.dart';
import 'package:roqasocial/modules/login/cubit/cubit.dart';
import 'package:roqasocial/modules/login/cubit/states.dart';
import 'package:roqasocial/shared/components/components.dart';
import 'package:roqasocial/shared/network/local/cache_helper.dart';



class LoginScreen extends StatelessWidget {
var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoqaLoginCubit(),
      child: BlocConsumer<RoqaLoginCubit,RoqaLoginStates>(
          listener: (context, state)
          {
            if(state is LoginErrorState)
            {
              ShowToast(
                text: 'There is an error entering the email or password',
                state: ToastStates.ERROR,
              );
            };
            if(state is LoginSuccessState)
            {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
              {
                RoqaMainCubit.get(context).getUsers();
                RoqaMainCubit.get(context).getPostData();
                RoqaMainCubit.get(context).getAllUsers();
                NavigateAndFinish(context, HomeLayoutScreen());
              });
            };
          },
          builder: (context, state)
      {
        return  Scaffold(
          appBar: buildThemeOverlayStyle(),
          backgroundColor: Colors.indigo[500],
          body: buildBody(context,state),
        );
      }
      ),
    );
  }
  /// Body
  Widget buildBody(context,state)=>SingleChildScrollView(
    child: Form(
      key: formKey,
      /// Design Column
      child: Column(
        children: [
          /// Design Container
          Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            /// Text Field & Button
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                buildLoginImage(),
                buildLoginText(),
                SizedBox(height: 25,),
                /// Email Text Field
                buildEmailTextFormField(),
                SizedBox(height: 10,),
                /// Password Text Field
                buildPasswordTextFormField(context),
                SizedBox(height: 30,),
                /// Login Button
                buildLoginButton(context,state),
                buildRegisterText(),
              ],
            ),
          ),
          /// Register Button
          SizedBox(height: 20,),
          buildRegisterButton(context),

        ],
      ),
    ),
  );

  /// Theme Overlay Style
  AppBar buildThemeOverlayStyle()=> AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  /// Login Image
  Widget buildLoginImage()=> Container(
    child: Image(
      width: 200,
      height: 160,
      image: AssetImage('assets/images/login.png'),
    ),
  );

  /// Login Text
  Widget buildLoginText()=> Text(
    'Login',
    style: TextStyle(
        color: Colors.black54,
        fontSize: 25
    ),

  );

  /// Email Text Form Field
  Widget buildEmailTextFormField()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: defaultFormFieldLine(
      controller: emailController,
      labelText: 'Email',
      prefix: Icons.email_outlined,
      validate: (value)
      {
        if(value!.isEmpty){
          return 'Email should not be Empty .';

        }
        return null;
      },
      keyboardType: TextInputType.text,
    ),
  );

  /// Password Text Form Field
  Widget buildPasswordTextFormField(context) {
    var cubit = RoqaLoginCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: defaultFormFieldLine(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          labelText: 'Password',
          isPassword: cubit.isPassword,
          suffix: cubit.suffix,
          suffixPress: ()
          {
            cubit.changeSuffix();
          },
          prefix: Icons.lock_outline,
          validate: (value)
          {
            if(value!.isEmpty){
              return 'Password is very short .';
            }
            return null;
          },
          onSubmit: (value)
          {
            if(formKey.currentState!.validate())
            {
              cubit.userLogin(
                email: emailController.text,
                password: passwordController.text,
              );
            }
          }
      ),
    );
  }

  /// Login Button
  Widget buildLoginButton(context,state) {

    var cubit = RoqaLoginCubit.get(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: ConditionalBuilder(
            condition: state is! LoginLoadingState,
            builder: (context) => defaultCircularButton(
              function: ()
              {
                if(formKey.currentState!.validate())
                {
                  cubit.userLogin(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  RoqaMainCubit.get(context).getUsers();
                  RoqaMainCubit.get(context).getPostData();
                  RoqaMainCubit.get(context).getAllUsers();
                }
              },
              text: 'Login',
              isCapital: false,
              width: 120,
              background: Colors.indigo[500]!,
              rounderRadius:  30,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  /// Register Text
  Widget buildRegisterText()=> Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            'Dose\'t have an Account,',
            style: TextStyle(
                fontSize: 16,
                color: Colors.indigo[500]
            ),
          ),
        ],
      ),
    );

  /// Register Button
  Widget buildRegisterButton(context){

    var c = RoqaMainCubit.get(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        defaultCircularButton(
          function: ()
          {
            c.boardController.nextPage(
                duration: Duration(
                    milliseconds: 750
                ), curve: Curves.ease
            );
          },
          text: 'Register Now ',
          TextColor: Colors.indigo[500],
          isCapital: false,
          width: 180,
          background: Colors.white,
          rounderRadius:  30,
        ),
      ],
    );
  }

}
