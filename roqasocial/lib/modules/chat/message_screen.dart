import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/models/messages_models.dart';
import 'package:roqasocial/models/users_models.dart';


class MessageScreen extends StatelessWidget {
    late UsersModels? usersModel;

  MessageScreen({this.usersModel});

  var messageController = TextEditingController();
  var Time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
       RoqaMainCubit.get(context).getMessage(
           receiverUId: usersModel!.uId!,
       );
      return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
        listener: (context, state)
        {
          if(state is sendMessageSuccessState)
          {
            messageController.text = '';
          }
        },
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.indigo,
            appBar: _buildAppBar(context),
            body: _buildBody(),
          );
        },
      );
      },
    );
  }

  /// App Bar
  AppBar _buildAppBar(context)=> AppBar(
    toolbarHeight: 70,
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

    titleSpacing: 0,
    title: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            usersModel!.image!,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                usersModel!.name!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                ),
              ),

            ],
          ),
        ),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,)),
        SizedBox(
          width: 10,
        ),
      ],
    ),
    leading: IconButton(

      padding: EdgeInsetsDirectional.zero,
      tooltip: 'Back',
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,

      ),
    ),
  );

  Widget _buildBody()=> Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/message.jpg'),
        fit: BoxFit.fill,
      ),
    ),
    child: ConditionalBuilder(
      condition: true,
      builder: (context) => Column(
        children: [
          SizedBox(height: 5,),
          _buildMessageList(context),
          _buildDivider(),
          _buildMessageTextFormFieldAndButton(context),
        ],
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    ),
  );

  /// Message List
  Widget _buildMessageList(context){

    var cubit = RoqaMainCubit.get(context);

    return Expanded(

      child: RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)
          {
            var message = RoqaMainCubit.get(context).Messages[index];

            if(cubit.usersModels!.uId == message.senderUId)
              return _builderMyMessage(message);

            return _builderMessage(message);
          },
          itemCount: cubit.Messages.length,
        ),
      ),
    );
  }

  /// Divider
  Widget _buildDivider()=> Container(
    height: 0.5,
    width: double.infinity,
    color: Colors.grey,
  );

  /// Message Text Form Field and Button
  Widget _buildMessageTextFormFieldAndButton(context){

    var cubit = RoqaMainCubit.get(context);

    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey[300],
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
                controller: messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your message ...',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w200
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: ()
              {
                cubit.sendMessage(
                  receiverUId: usersModel!.uId!,
                  message: messageController.text,
                  dateTime: Time.toString(),
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
  );
  }

  /// My Message
  Widget _builderMyMessage(MessagesModels models)=> Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        color: Colors.indigo,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            ' ${models.message} ',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    ),
  ),
);

  /// My Friends Message
  Widget _builderMessage(MessagesModels models)=> Align(
  alignment: AlignmentDirectional.centerStart,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight:  Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            ' ${models.message} ',
        ),
      ),
    ),
  ),
);


}
