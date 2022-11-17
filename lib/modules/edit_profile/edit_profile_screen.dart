import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: const Text(
                  'UPDATE',
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUploadUserLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUploadUserLoadingState)
                    const SizedBox(
                      height: 5.0,
                    ),
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.5),
                                  child: const Icon(
                                    IconlyLight.camera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: const Icon(
                                  IconlyLight.camera,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  isUpper: false,
                                  text: 'Upload Profile Image',
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                ),
                                // if (state is SocialUploadUserLoadingState)
                                //   const SizedBox(
                                //     height: 5.0,
                                //   ),
                                // if (state is SocialUploadUserLoadingState)
                                //   const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (SocialCubit.get(context).profileImage != null &&
                            SocialCubit.get(context).coverImage != null)
                          const SizedBox(
                            width: 5.0,
                          ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  isUpper: false,
                                  text: 'Upload Cover Image',
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                ),
                                // if (state is SocialUploadUserLoadingState)
                                //   const SizedBox(
                                //     height: 5.0,
                                //   ),
                                // if (state is SocialUploadUserLoadingState)
                                //   const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: IconlyLight.profile,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    label: 'Bio',
                    prefix: IconlyLight.infoSquare,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: IconlyLight.call,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
