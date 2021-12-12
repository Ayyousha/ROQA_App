
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/models/comments_models.dart';
import 'package:roqasocial/models/post_models.dart';
import 'package:roqasocial/models/users_models.dart';
import 'package:roqasocial/modules/home/open_profile_screen.dart';
import 'package:roqasocial/modules/home/photo_viewer_screen.dart';
import 'package:roqasocial/modules/profile/profile_screen.dart';
import 'package:roqasocial/shared/components/components.dart';

class HomeScreen extends StatelessWidget {

  var _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
        listener: (context, state)
        {
          if(state is getCommentSuccessState)
          {
            _commentController.text = '';
          }
        },
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.indigo[200],
            body : NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                _buildAppBar(context, state),
              ],
              body: _buildPostList(context),
            ),
          );
        },
    );
  }

  /// App Bar
  SliverAppBar _buildAppBar(context, state)=> SliverAppBar(
    toolbarHeight: 80,
    floating: true,
    backgroundColor: Colors.white,
    elevation: 2,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    title: Row(
      children: [
        SizedBox(width: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RoQa Feed',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 30,
              ),
            ),
            Text(
              'Your Friends Recent Post.',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Spacer(),
        ConditionalBuilder(
          condition: state is! getUsersDataLoadingState,
          builder: (context) => CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              '${RoqaMainCubit.get(context).usersModels!.image}',
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
        SizedBox(width: 5,),
      ],
    ),
  );

  /// Post List
  Widget _buildPostList(context) {
    var cubit = RoqaMainCubit.get(context);

   return ConditionalBuilder(
      condition: cubit.postModel.length > 0 ,
      builder: (context) => RefreshIndicator(
        onRefresh: cubit.refresh,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: ListView.separated(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 75,
          ),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => _defaultPosts(cubit.postModel[index],cubit.usersModels!,context,index),
          separatorBuilder: (context, index) => SizedBox(height: 3,),
          itemCount: cubit.postModel.length,
        ),
      ),
      fallback: (context) => Center(child: CircularProgressIndicator(
        color: Colors.white,
      )),
    );
  }

  /// Posts
  Widget _defaultPosts(PostModels models,UsersModels model,context,index){
    final photo = models.imagePost!;

    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        margin: EdgeInsetsDirectional.only(
          start: 5,
          end: 5,
          bottom: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Head of Post
            _buildHeadOfPost(context,models),
            /// post
            _buildPostText(context,models),
            /// HashTag
            if(models.hashTag != null )
              _buildPostHashTag(context,models),
            /// Image Post
            if(models.imagePost != '' )
              _buildPostImage(context,photo),
            /// like & comment info
            _buildLikeAndCommentInfo(context,index),
            Column(
              children: [
                /// Divider
                _buildDivider(),
                /// Put Like & comment
                _buildLikeAndCommentPress(context,index),
                /// Divider
                _buildDivider(),
              ],
            ),
            /// Comment Avatar & Comment
            _buildCommentAvatarAndComment(context,model),
          ],
        )
    );
  }

  /// Head Of Post
  Widget _buildHeadOfPost(context,models){

    return InkWell(
      onTap: ()
      {
        NavigateTo(context, OpenProfileScreen(
          cover : models.cover,
          image : models.image,
          name : models.name,
          bio : models.bio,
        ));
      },
      child: Hero(
        tag: models,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundImage: NetworkImage('${models.image}'),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${models.name}',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1!
                          .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      '${models.dateTime}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle2!
                          .copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              IconButton(
                splashRadius: 25,
                onPressed: (){},
                icon: Icon(
                    Icons.more_horiz
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Post Text
  Widget _buildPostText(context,models){

    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 5,right: 25,),
      child: Text(
        '${models.text}',
        style: Theme.of(context).textTheme.subtitle1!
            .copyWith(
            fontWeight: FontWeight.w200,
            fontSize: 15
        ),
      ),
    );
  }

  /// Post HashTag
  Widget _buildPostHashTag(context,models){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Container(
        width: double.infinity,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: Container(
                height: 18,
                child: MaterialButton(
                  onPressed: (){},
                  child:Text(
                    '${models.hashTag}',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                  minWidth: 1,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Post Image
  Widget _buildPostImage(context,photo){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          onTap: ()
          {
            NavigateTo(context, PhotoViewerScreen(photo: photo));
          },
          child: Hero(
            tag: photo,
            child: Image(
                image: NetworkImage('${photo}'),
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  /// Like And Comment Info
  Widget _buildLikeAndCommentInfo(context,index){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 17,
                ),
                SizedBox(width: 3,),

                Text(
                  '${RoqaMainCubit.get(context).likes[index].bitLength}',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Icon(
                  Icons.insert_comment,
                  color: Colors.yellow,
                  size: 17,
                ),
                SizedBox(width: 3,),
                Text(
                  '${RoqaMainCubit.get(context).commentId.length}',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.grey
                  ),
                ),
                SizedBox(width: 4,),
                Text(
                  'Comments',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Divider
  Widget _buildDivider()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      height: 0.2,
      width: double.infinity,
      color: Colors.grey,
    ),
  );


  /// Like And Comment Press
  Widget _buildLikeAndCommentPress(context,index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(

          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: ()
            {
              RoqaMainCubit.get(context).putLike(
                  RoqaMainCubit.get(context).postId[index]
              );
            },
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'Like',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),

        Expanded(
          child: InkWell(

            borderRadius: BorderRadius.circular(5),
            onTap: ()
            {
              _buildBottomSheet(context);
            },
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.comment,
                    color: Colors.yellow,
                    size: 22,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'comment',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // /// Like And Comment Press
  // Widget _buildLikeAndCommentPress(context,index){
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 5),
  //     child: Row(
  //       children: [
  //         InkWell(
  //           borderRadius: BorderRadius.circular(5),
  //           onTap: ()
  //           {
  //             RoqaMainCubit.get(context).putLike(
  //                 RoqaMainCubit.get(context).postId[index]
  //             );
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(
  //                 vertical: 20,
  //                 horizontal: 50
  //             ),
  //             child: Row(
  //               children: [
  //                 Icon(
  //                   Icons.favorite,
  //                   color: Colors.redAccent,
  //                   size: 22,
  //                 ),
  //                 SizedBox(width: 5,),
  //                 Text(
  //                   'Like',
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           borderRadius: BorderRadius.circular(5),
  //           onTap: ()
  //           {
  //             _buildBottomSheet(context);
  //           },
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 20,
  //                     bottom: 20,
  //                     right: 20,
  //                     left: 20
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.comment,
  //                       color: Colors.yellow,
  //                       size: 22,
  //                     ),
  //                     SizedBox(width: 5,),
  //                     Text(
  //                       'comment',
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Comment Avatar And Comment
  Widget _buildCommentAvatarAndComment(context,model){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: InkWell(
        onTap: ()
        {
          _buildBottomSheet(context);
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      '${model.image}'),
                ),
                SizedBox(width: 15,),
                Text(
                  'write a comment ...',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.send,
                  color: Colors.black54,
                ),
                SizedBox(width: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom Sheet
  void _buildBottomSheet(context) {
    showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            Navigator.pop(context,);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Comments',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400),),
      ),
      body: Column(
        children: [
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(

                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                    '${RoqaMainCubit.get(context).commentId[index].image}',
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${RoqaMainCubit.get(context).commentId[index].name}',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                child: Text(
                                  '${RoqaMainCubit.get(context).commentId[index].text}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 8,),
              itemCount: RoqaMainCubit.get(context).commentId.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:  25,bottom: 10,right: 20,top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(
                            fontWeight: FontWeight.w200
                        ),
                        controller: _commentController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write your Comment ...',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w200
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        RoqaMainCubit.get(context).createComment(
                          text: _commentController.text,
                        );
                      },
                      icon: Icon(
                        Icons.send,
                        size: 25,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
  );
  }



}
