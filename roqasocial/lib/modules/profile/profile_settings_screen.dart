

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqasocial/layout/cubit/cubit.dart';
import 'package:roqasocial/layout/cubit/states.dart';
import 'package:roqasocial/modules/profile/profile_screen.dart';
import 'package:roqasocial/shared/components/components.dart';


class ProfileSettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var nameController =TextEditingController();
  var bioController =TextEditingController();
  var phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoqaMainCubit,RoqaMainStates>(
        listener: (context, state) {},
        builder: (context, state) {

          nameController.text = RoqaMainCubit.get(context).usersModels!.name!;
          bioController.text = RoqaMainCubit.get(context).usersModels!.bio!;
          phoneController.text = RoqaMainCubit.get(context).usersModels!.phone!;

          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context, state),
          );
        },
    );
  }

  /// App Bar
  AppBar _buildAppBar(context)=> AppBar(
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context,ProfileScreen());
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.indigo[500],
      ),
    ),
    title: Text(
      'Edit You Profile',
      style: TextStyle(
        color: Colors.indigo[500],
      ),
    ),
  );

  /// Body
  Widget _buildBody(context, state) {

    var profileImage = RoqaMainCubit.get(context).ProfileImage;
    var coverImage = RoqaMainCubit.get(context).CoverImage;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCoverAndImage(context),
                SizedBox(height: 10,),

                SizedBox(height: 10,),
                if( state is! getUsersDataSuccessState)
                  if(profileImage != null || coverImage != null )
                    _buildCoverAndImageButton(context, state),
                SizedBox(height: 10,),
                SizedBox(height: 5,),

                _buildNameTextFormField(),
                SizedBox(height: 10,),

                _buildBioTextFormField(),
                SizedBox(height: 10,),

                _buildPhoneTextFormField(),
                SizedBox(height: 25,),

                _buildUpdateButton(context, state),
                SizedBox(height: 20,),

                _buildLogOutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Cover and Image
  Widget _buildCoverAndImage(context) {

    var cubit = RoqaMainCubit.get(context);
    var models = RoqaMainCubit.get(context).usersModels!;
    var profileImage = RoqaMainCubit.get(context).ProfileImage;
    var coverImage = RoqaMainCubit.get(context).CoverImage;

    return Container(
      height: 225,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.indigo[500],
                  ),
                  child: coverImage == null ? Image(image: NetworkImage('${models.cover}',), fit: BoxFit.fill,)
                      : Image(
                    image: FileImage(coverImage), fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 15,
                    child: IconButton(
                        onPressed: ()
                        {
                          cubit.getCoverImage();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.indigo,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 64,
                child: profileImage == null ?
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    '${models.image}',
                  ),
                )
                    :
                CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(profileImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 15,
                  child: IconButton(
                      onPressed: ()
                      {
                        cubit.getProfileImage();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: Colors.indigo,
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Cover and Image Button
  Widget _buildCoverAndImageButton(context, state){

    var cubit = RoqaMainCubit.get(context);
    var profileImage = RoqaMainCubit.get(context).ProfileImage;
    var coverImage = RoqaMainCubit.get(context).CoverImage;

    return Row(
      children: [
        if(profileImage != null)
          ConditionalBuilder(
            condition: state is! uploadProfileImageLoadingState,
            builder: (context) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: defaultButton(
                  background: Colors.indigo[500]!,
                  text: 'Profile',
                  function: ()
                  {
                    cubit.uploadProfileImage(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  },
                ),
              ),
            ),
            fallback: (context) => Expanded(child: Center(child: CircularProgressIndicator())),
          ),
        if(coverImage != null)
          ConditionalBuilder(
            condition: state is! uploadCoverImageLoadingState,
            builder: (context) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: defaultButton(
                  background: Colors.indigo[500]!,
                  text: 'Cover',
                  function: ()
                  {
                    cubit.uploadCoverImage(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  },
                ),
              ),
            ),
            fallback: (context) => Expanded(child: Center(child: CircularProgressIndicator())),
          ),
      ],
    );
  }

  /// Name Text Form Field
  Widget _buildNameTextFormField()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: defaultFormFieldLine(
      controller: nameController,
      keyboardType: TextInputType.name,
      labelText: 'Name',
      validate: (value)
      {
        if(value!.isEmpty)
        {
          return 'Name Should Update';
        }
        return null;
      },
      prefix: Icons.person,
    ),
  );

  /// Bio Text Form Field
  Widget _buildBioTextFormField()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: defaultFormFieldLine(
      controller: bioController,
      keyboardType: TextInputType.text,
      labelText: 'Bio',
      validate: (value)
      {
        if(value!.isEmpty)
        {
          return 'Bio Should Update';
        }
        return null;
      },
      prefix: Icons.description,
    ),
  );

  /// Phone Text Form Field
  Widget _buildPhoneTextFormField()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: defaultFormFieldLine(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      labelText: 'Phone',
      validate: (value)
      {
        if(value!.isEmpty)
        {
          return 'Phone Should Update';
        }
        return null;
      },
      prefix: Icons.phone,
    ),
  );

  /// Update Button
  Widget _buildUpdateButton(context, state) {

    var cubit = RoqaMainCubit.get(context);

    return ConditionalBuilder(
    condition: state is! updateUserDataLoadingState,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: defaultButton(
        background: Colors.indigo[500]!,
        text: 'Update',
        function: ()
        {
          if(formKey.currentState!.validate())
          {
            cubit.updateUserData(
              name: nameController.text,
              bio: bioController.text,
              phone: phoneController.text,
            );
          }
        },
      ),
    ),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
  }

  /// LogOut Button
  Widget _buildLogOutButton(context) {

    var cubit = RoqaMainCubit.get(context);

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Center(
        child: MaterialButton(
          height: double.infinity,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          onPressed: ()
          {
            cubit.signOut(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LogOut',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10,),
              Icon(
                Icons.logout,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
