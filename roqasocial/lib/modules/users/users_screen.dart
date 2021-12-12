import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/models/users_models.dart';
import 'package:roqasocial/modules/chat/message_screen.dart';
import 'package:roqasocial/shared/components/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoqaMainCubit, RoqaMainStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.indigo[200],
          appBar: _buildAppBar(),
          body: _buildListOfUsers(context),
        );
      },
    );
  }

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
      'Users',
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


  Widget _buildListOfUsers(context){

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


  Widget _buildUsers(UsersModels model, context) => Column(
    children: [
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: NetworkImage('${model.cover}'),fit: BoxFit.fill),
            color: Colors.white,
          ),
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 15,),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 44,
                      child:
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          '${model.image}',
                        ),
                      )
                      ,
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(width: 85,),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                ' ${model.name} ',
                                style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.black45,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 3,),
                              Text(
                                ' ${model.bio}',
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


                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
