import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/modules/profile/profile_video_screen.dart';
import 'package:roqasocial/modules/profile/profile_settings_screen.dart';
import 'package:roqasocial/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var cubit = RoqaMainCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.indigo[200],
            appBar: _buildAppBar(context),
            body: RefreshIndicator(
              onRefresh: RoqaMainCubit.get(context).refresh,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 2.5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: _buildDetailsOfAccount(context),
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5,),
                      _buildVideoPost(context),
                      SizedBox(height: 70,),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }

  /// App Bar
  AppBar _buildAppBar(context){

    var models = RoqaMainCubit.get(context).usersModels!;

    return AppBar(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Image(
            image: NetworkImage(
              '${models.cover}',
            ),
            fit: BoxFit.cover,
          ),
        ) ,
      ),
      titleSpacing: 0,
      backgroundColor: Colors.indigo[500],
      toolbarHeight: 210,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white.withOpacity(0),
      ),


      title: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              // height: 225,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 44,
                        child:
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            '${models.image}',
                          ),
                        )
                        ,
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 85,),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  ' ${models.name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.black45,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 3,),
                                Text(
                                  ' ${models.bio}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.black45,
                                    fontSize: 13,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black45,
                            ),
                            child: IconButton(
                              onPressed: ()
                              {
                                NavigateTo(context, ProfileSettingsScreen());
                              },
                              icon:Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: 25,),
                        ],
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  /// Details Of Account
  Widget _buildDetailsOfAccount(context)=> Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Expanded(
        child: Column(
          children: [
            Text(
              'Follow',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,

              ),
            ),
            SizedBox(height: 10,),
            Text(
              '165',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      SizedBox( width: 7,),
      Container(
        height: 50,
        width: 0.3,
        color: Colors.black87,
      ),
      SizedBox( width: 7,),
      Expanded(
        child: Column(
          children: [
            Text(
              'Posts',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '${RoqaMainCubit.get(context).postModel.length}',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      SizedBox( width: 7,),
      Container(
        height: 50,
        width: 0.3,
        color: Colors.black87,
      ),
      SizedBox( width: 10,),
      Expanded(
        child: Column(
          children: [
            Text(
              'Following',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '269',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    ],
  );

  /// Video Post
  Widget _buildVideoPost(context)=> GridView.count(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    padding: EdgeInsetsDirectional.only(
      end: 5,
      start: 5,

    ),
    crossAxisCount: 1,
    // mainAxisSpacing: 3.0,
    // crossAxisSpacing: 3,
    // childAspectRatio: 1 / 1.5,
    children: videoList
        .map((e) => GestureDetector(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        margin: EdgeInsetsDirectional.only(
          bottom: 7.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Head of Post
            Padding(
              padding: const EdgeInsets.only(right: 20,top: 7.5,bottom: 2.5,left: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(RoqaMainCubit.get(context).usersModels!.image!),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          RoqaMainCubit.get(context).usersModels!.name!,
                          style: Theme.of(context).textTheme.bodyText1!
                              .copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          '${RoqaMainCubit.get(context).usersModels!.bio!}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle2!
                              .copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: MyDivider(),
            ),
            /// post
            // Container(
            //   width: double.infinity,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     // color: Colors.grey[300],
            //     borderRadius: BorderRadius.only(
            //       topRight: Radius.circular(15),
            //       topLeft: Radius.circular(15),
            //     ),
            //   ),
            //
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 10),
            //     child: Text(
            //       e['name']!,
            //       style: Theme.of(context).textTheme.subtitle1!
            //           .copyWith(
            //           fontWeight: FontWeight.w200,
            //           fontSize: 25,
            //         color: Colors.black54
            //       ),
            //     ),
            //   ),
            // ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: GestureDetector(
                    onTap: ()
                    {
                    },

                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Hero(
                          tag: 'video',
                          child: InkWell(
                            onTap: ()
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VideoScreen(
                                  name:e['name'],
                                  mediaUrl:e['media_url'],
                                  description:e['description'],
                                )
                                ),
                              );
                            },
                            child: Image(
                              fit: BoxFit.fill,
                                width: double.infinity,
                                image: NetworkImage(e['thumb_url']!,)
                            ),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.black26,
                            child: InkWell(
                              onTap: ()
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => VideoScreen(
                                    name:e['name'],
                                    mediaUrl:e['media_url']!,
                                    description:e['description']!,
                                  )
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
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
            SizedBox(height: 0,)
          ],
        ),
      ),
    )).toList(),
  );








  var videoList = [
    {
      'name': 'Big Buck Bunny',
      'hash': 'Big_Buck_Bunny',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      'thumb_url':
      'https://i.ytimg.com/vi/7x0emrTCgbA/maxresdefault.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org",

    },
    {
      'name': "Elephant Dream",
      'hash': 'Elephant_Dream',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      'thumb_url':
      'https://i.ytimg.com/vi/kPdv44HtEoA/maxresdefault.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org",
    },
    {
      'name': "For Bigger Blazes",
      'hash': 'For_Bigger_Blazes',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      'thumb_url':
      'https://d2z1w4aiblvrwu.cloudfront.net/ad/76Ab/google-chromecast-bigger-blazes-large-7.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
    {
      'name': 'Big Buck Bunny',
      'hash': 'Big_Buck_Bunny',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      'thumb_url':
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images_480x270/ForBiggerEscapes.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
    {
      'name': "For Bigger Escape",
      'hash': 'For_Bigger_Escape',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      'thumb_url':
      'https://www.pearson.com/content/dam/one-dot-com/one-dot-com/english/Images/BookCovers/Primary/NewBigFun/new-big-fun-student-book.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"

    },
    {
      'name': "For Bigger Fun",
      'hash': 'For_Bigger_Fun',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      'thumb_url':
      'https://i.ytimg.com/vi/9s4aQraY3nI/maxresdefault.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
    {
      'name': "For Bigger Joyrides",
      'hash': 'For_Bigger_Joyrides',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
      'thumb_url':
      'https://d2z1w4aiblvrwu.cloudfront.net/ad/75GS/google-chromecast-bigger-meltdowns-large-5.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
    {
      'name': "For Bigger Meltdowns",
      'hash': 'For_Bigger_Meltdowns',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
      'thumb_url':
      'https://i.ytimg.com/vi/BwhvASARMhY/maxresdefault.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
    {
      'name': "Sintel",
      'hash': "Sintel",
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4" ,
      'thumb_url':
      'https://www.forbes.com/wheels/wp-content/uploads/2021/05/2022-Suba-ru-Outback-Wilderness-hero.jpg',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
    {
      'name': "Tears of Steel",
      'hash': 'Tears_of_Steel',
      'media_url':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
      'thumb_url':
      'https://images-na.ssl-images-amazon.com/images/S/sgp-catalog-images/region_US/umvhu-AQDPA6DB4EX-Full-Image_GalleryCover-en-US-1492588913366._UY500_UX667_RI_VaEQ8wbkqY5SsPqVMk4J1L3OfBknQmZew_TTW_.png',
      'description': "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
    },
  ];
}





