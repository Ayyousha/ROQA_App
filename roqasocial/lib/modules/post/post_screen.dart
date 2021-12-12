

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';


import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/layout/social_layout.dart';
import 'package:roqasocial/models/users_models.dart';
import 'package:roqasocial/modules/on_boarding/onBoarding_screen.dart';

import 'package:roqasocial/shared/components/components.dart';

class PostScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();

  var tagController = TextEditingController();
  var textController = TextEditingController();
  var Date = DateFormat.yMMMMEEEEd().format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
        listener: (context, state)
        {
          if(state is createPostSuccessState)
          {
            textController.text = '';
            tagController.text = '';
            RoqaMainCubit.get(context).removePostImage();
            NavigateAndFinish(context, HomeLayoutScreen());
          }else
            {
              print('Error when Data sending ');
            }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.indigo[200],
            appBar: _buildAppBar(context),
            body: _buildBody(context),
          );
        },
    );
  }

  /// App Bar
  AppBar _buildAppBar(context) {

  var cubit = RoqaMainCubit.get(context);
  var postImage = RoqaMainCubit.get(context).PostImage;

  return AppBar(
  toolbarHeight: 80,
  backgroundColor: Colors.white,
  elevation: 2,
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white,
  ),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      )
  ),
  titleSpacing: 0,
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_back_ios,
      color: Colors.black,
    ),
  ),
  title: Text(
    'Create Post',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w100,
      fontSize: 22,
    ),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(
          top: 22,
          bottom: 20,
          right: 15

      ),
      child: defaultButton(
        width: 83,
        function: ()
        {
          if(postImage != null) {
            cubit.uploadPostImage(
              text: textController.text,
              dateTime: Date.toString(),
              hashTag: tagController.text,
            );
          }else{
            cubit.createPost(
              text: textController.text,
              dateTime: Date.toString(),
              hashTag: tagController.text,
            );
          }
        },
        text: 'Post',
      ),
    ),
  ],
);}

  /// Body
  Widget _buildBody(context){

    var postImage = RoqaMainCubit.get(context).PostImage;

    return Padding(
      padding: const EdgeInsets.only(
        top:5 ,
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildAvatarAndName(context),
            SizedBox(height: 10,),
            _buildMyDivider(),
            _buildHashTag(),
            _buildTextFormField(context),
            Spacer(),
            if(postImage != null)
              _buildPhotoContainer(context),
            _buildAddPhotoButton(context),
          ],
        ),

      ),
    );
  }

  /// Avatar and Name
  Widget _buildAvatarAndName(context) {

    var model = RoqaMainCubit.get(context).usersModels;

    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          left: 15

      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${model!.image}',
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Text(
              '${model.name}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// My Divider
  Widget _buildMyDivider()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: MyDivider(),
  );

  /// HashTag
  Widget _buildHashTag()=> Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10
    ),
    child: TextFormField(
      controller: tagController,
      maxLines: 1,
      style: TextStyle(
        fontWeight: FontWeight.w100,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        hintText: '#hash_Tag',
        isCollapsed: true,
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w300,
        ),
      ),

    ),
  );

  /// Text Form Field
  Widget _buildTextFormField(context) {
    var model = RoqaMainCubit.get(context).usersModels;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,

      ),
      child: TextFormField(
        controller: textController,
        maxLines: 5,
        style: TextStyle(
          fontWeight: FontWeight.w100,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: 'What is in your Mind...,${model!.name} ',
          isCollapsed: true,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w300,
          ),
        ),

      ),
    );
  }

  /// Photo Container
  Widget _buildPhotoContainer(context) {

    var postImage = RoqaMainCubit.get(context).PostImage;

    return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: postImage != null ? Image(
          image:FileImage(postImage),
          fit: BoxFit.fill,
        ) : Image(image: NetworkImage(
            'https://image.freepik.com/free-photo/medium-shot-man-wearing-vr-glasses_23-2149126949.jpg'),fit: BoxFit.fill,),

      ),
    ),
  );}

  /// add Photo Button
  Widget _buildAddPhotoButton(context)=> Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: defaultButton(
            function: ()
            {
              RoqaMainCubit.get(context).getPostImage();
            },
            text: 'Add Photo',
            isCapital: false,

          ),
        ),
      ),
    ],
  );


}
