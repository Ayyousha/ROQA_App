import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/models/users_models.dart';
import 'package:roqasocial/modules/chat/message_screen.dart';
import 'package:roqasocial/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoqaMainCubit, RoqaMainStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.indigo[200],
          appBar: _buildAppBar(),
          body: _buildListOfChats(context),
        );
      },
    );
  }

  /// App Bar
  AppBar _buildAppBar()=> AppBar(
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
        )),
    titleSpacing: 30,
    title: Text(
      'Chats',
      style: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.w600,
        fontSize: 30,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
          size: 30,
          color: Colors.indigo,
        ),
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );

  /// List Of Chats
  Widget _buildListOfChats(context){

    var cubit = RoqaMainCubit.get(context);
    var models = RoqaMainCubit.get(context).allUsers;

    return ConditionalBuilder(
      condition: models.length > 0,
      builder: (context) => RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView.separated(
          padding: EdgeInsets.only(
            bottom: 75,
          ),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              _buildUsers(models[index], context),
          separatorBuilder: (context, index) => SizedBox(
            height: 0,
          ),
          itemCount: models.length,
        ),
      ),
      fallback: (context) => Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          )),
    );
  }

  /// Users
  Widget _buildUsers(UsersModels model, context) => Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    NavigateTo(
                        context,
                        MessageScreen(
                          usersModel: model,
                        ));
                  },
                  child: _buildAvatarAndNameAndBio(model),
                ),
              ),
            ),
          ),
        ],
      );

  /// User Avatar & Name & Bio
  Widget _buildAvatarAndNameAndBio(model)=> Row(
    children: [
      SizedBox(
        width: 15,
      ),
      CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(
          '${model.image}',
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${model.name}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w100,
                fontSize: 18,
              ),
            ),
            Text(
              '${model.bio}.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w100,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 25,
      ),
    ],
  );
}
