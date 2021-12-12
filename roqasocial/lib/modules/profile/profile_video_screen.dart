
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roqasocial/modules/profile/profile_screen.dart';
import 'package:roqasocial/shared/components/components.dart';

class VideoScreen extends StatefulWidget {
  final String? name,mediaUrl,description;

  const VideoScreen({Key? key, this.name, this.mediaUrl,  this.description }) : super(key: key);


  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoScreen> {
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();


  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16/9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.mediaUrl!
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  /// App Bar
  AppBar _buildAppBar()=> AppBar(
    backgroundColor: Colors.indigo[500],
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.indigo[500],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    title: Text(
      widget.name!,
      style: TextStyle(
          color: Colors.white
      ),
    ),
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context,ProfileScreen());
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    ),
  );

  /// Body
  Widget _buildBody()=> Padding(
    padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 10
    ),
    child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.grey[300],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(),
            SizedBox(height: 20,),
            _buildDivider(),
            _buildNameOfVideo(),
            _buildDescriptionOfVideo(),
            SizedBox(height: 80,),
            Container(
              height: 50,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.indigo[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  /// Video Player
  Widget _buildVideoPlayer()=> Container(
    color: Colors.indigo,
    height: 195,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: AspectRatio(
        aspectRatio: 16/9,
        child: BetterPlayer(
          key: _betterPlayerKey,
          controller: _betterPlayerController,
        ),
      ),
    ),
  );

  /// Divider
  Widget _buildDivider()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: MyDivider(),
  );

  /// Name of Video
  Widget _buildNameOfVideo()=> Padding(
    padding: const EdgeInsets.only(
      left: 10,
      right: 10,
      top: 5,

    ),
    child: Text(
      '${widget.name!} : ',
      style: TextStyle(
        fontSize: 30,

      ),
    ),
  );

  /// Description of Video
  Widget _buildDescriptionOfVideo()=> Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      widget.description!,
    ),
  );


}