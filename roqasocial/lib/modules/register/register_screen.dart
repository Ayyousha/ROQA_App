
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/social_layout.dart';
import 'package:roqasocial/modules/register/cubit/cubit.dart';
import 'package:roqasocial/modules/register/cubit/states.dart';
import 'package:roqasocial/shared/components/components.dart';
import 'package:roqasocial/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoqaRegisterCubit(),
      child: BlocConsumer<RoqaRegisterCubit,RoqaRegisterStates>(
          listener: (context, state)
          {
            if(state is CreateUsersSuccessState)
            {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
              {
                NavigateAndFinish(context, HomeLayoutScreen());
              });
            }
          },
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.indigo,
            appBar: _buildAppBar(context),
            body: _buildBody(context,state),
          );
        },
      ),
    );
  }

  /// body
  Widget _buildBody(context,state)=> SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          _buildRegisterImage(),
          SizedBox(height: 10,),
          _buildRegisterText(),
          SizedBox(height: 15,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 30,),
                _buildFullNameTextFormField(),
                SizedBox(height: 15,),
                _buildEmailTextFormField(),
                SizedBox(height: 15,),
                _buildPasswordTextFormField(context),
                SizedBox(height: 15,),
                _buildPhoneTextFormField(context),
                SizedBox(height: 30,),
                _buildRegisterButton(context,state),
                SizedBox(height: 40,),
                // _buildBottomDesign(),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  /// App Bar
  AppBar _buildAppBar(context){

    var c = RoqaMainCubit.get(context);

    return AppBar(
        backgroundColor: Colors.indigo[500],
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.indigo[500],
            statusBarIconBrightness: Brightness.light
        ),
        leading: IconButton(
          onPressed: ()
          {
            c.boardController.animateToPage(
                0,
                duration: Duration(
                    milliseconds: 750
                ),
                curve: Curves.ease
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        )
    );
  }

  /// Register Image
  Widget _buildRegisterImage()=> Container(
    child: Image(
      width: 200,
      height: 120,
      image: AssetImage('assets/images/register.png'),
    ),
  );

  /// Register Text
  Widget _buildRegisterText()=> Text(
    'Register',
    style: TextStyle(
        color: Colors.white,
        fontSize: 25
    ),
  );

  /// Full Name Text Form Field
  Widget _buildFullNameTextFormField()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: defaultFormFieldLine(
      controller: _nameController,
      labelText: 'Full Name',
      prefix: Icons.person_outline,
      validate: (value)
      {
        if(value!.isEmpty){
          return 'Name should not be Empty .';
        }
        return null;
      },
      keyboardType: TextInputType.name,
    ),
  );

  /// Email Text Form Field
  Widget _buildEmailTextFormField()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: defaultFormFieldLine(
      controller: _emailController,
      labelText: 'Email',
      prefix: Icons.email_outlined,
      validate: (value)
      {
        if(value!.isEmpty){
          return 'Email should not be Empty .';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    ),
  );

  /// Password Text Form Field
  Widget _buildPasswordTextFormField(context) {

    var cubit = RoqaRegisterCubit.get(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: defaultFormFieldLine(
        controller: _passwordController,
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

      ),
    );
    }

  /// Phone Text Form Field
  Widget _buildPhoneTextFormField(context) {

    var cubit = RoqaRegisterCubit.get(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: defaultFormFieldLine(
          controller: _phoneController,
          labelText: 'Phone Number',
          keyboardType: TextInputType.phone,
          prefix: Icons.phone,
          validate: (value)
          {
            if(value!.isEmpty){
              return 'Phone should not be Empty .';
            }
            return null;
          },
          onSubmit: (value)
          {
            if(_formKey.currentState!.validate())
            {
              cubit.registerUsers(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                phone: _phoneController.text,
              );
            }
          }
      ),
    );
    }

  /// Register Button
  Widget _buildRegisterButton(context,state) {

    var cubit = RoqaRegisterCubit.get(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConditionalBuilder(
          condition: state is! CreateUsersLoadingState,
          builder: (context) =>  defaultCircularButton(
            function: ()
            {
              if(_formKey.currentState!.validate())
              {
                cubit.registerUsers(
                  name: _nameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  phone: _phoneController.text,
                );
                RoqaMainCubit.get(context).getUsers();
                RoqaMainCubit.get(context).getPostData();
                RoqaMainCubit.get(context).getAllUsers();
              }
            },
            text: 'Register',
            isCapital: false,
            width: 120,
            background: Colors.indigo[500]!,
            rounderRadius:  30,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),

        ),
      ],
    );
    }

  // /// Bottom Design
  // Widget _buildBottomDesign()=> Container(
  //     width: double.infinity,
  //     height: 0,
  //     decoration: BoxDecoration(
  //       color: Colors.indigo[500],
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(25),
  //         topLeft: Radius.circular(25),
  //       ),
  //     ),
  //   );
}
