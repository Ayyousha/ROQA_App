
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';

class OpenProfileScreen extends StatelessWidget {
  var cover;
  var image;
  var name;
  var bio;

  OpenProfileScreen
  ({
   required this.cover,
   required this.image,
   required this.name,
   required this.bio,
  });
  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 means normal animation speed.
    return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.indigo[200],
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child:  Hero(
                      tag: image,
                      child: Column(
                        children: [
                          _buildCoverAndImage(context),
                          SizedBox(
                            height: 5,
                          ),
                          // Profile Name
                          _buildProfileName(context),
                          SizedBox(
                            height: 5,
                          ),
                          // Profile Bio
                          _buildProfileBio(context),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

          );
        },
    );
  }

  /// App Bar
  AppBar _buildAppBar(context)=> AppBar(
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
    titleSpacing: 0 ,
    title: Text(
      '${name}Profile',
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ),
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black87,
      ),
    ),
  );

  /// Cover And Image
  Widget _buildCoverAndImage(context)=> Container(
    height: 200,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Align(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
              image:  DecorationImage(
                image: NetworkImage(cover),
                fit: BoxFit.fill,

              ),
            ),
          ),
          alignment: AlignmentDirectional.topStart,
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          radius: 65,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(image),
          ),
        ),
      ],
    ),
  );

  /// Profile Name
  Widget _buildProfileName(context)=> Text(
    name,
    style: Theme.of(context).textTheme.bodyText1,
  );

  /// Profile Bio
  Widget _buildProfileBio(context)=> Text(
    bio,
    style: Theme.of(context).textTheme.caption!.copyWith(
      overflow:TextOverflow.ellipsis,

    ),
  );
}
