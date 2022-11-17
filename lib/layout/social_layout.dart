import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/create_post/create_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SocialNewPostState) {
          navigateTo(
            context,
            CreatePostScreen(),
          );
        }
      },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.notification,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.paperUpload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.setting),
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              cubit.changeBottom(index);
            },
          ),
        );
      },
    );
  }
}

//***** for verify the mail ******

// ConditionalBuilder(
// condition: SocialCubit.get(context).model != null,
// fallback: (BuildContext context) => const Center(
// child: CircularProgressIndicator(),
// ),
// builder: (BuildContext context) {
// // var model = SocialCubit.get(context).model;
//
// return Column(
// children: [
// if (!(FirebaseAuth.instance.currentUser!.emailVerified))
// Container(
// height: 50.0,
// padding: const EdgeInsets.symmetric(
// horizontal: 10.0,
// ),
// color: Colors.amber.withOpacity(0.7),
// child: Row(
// children: [
// const Icon(Icons.info_outline),
// const SizedBox(
// width: 5.0,
// ),
// const Expanded(
// child: Text(
// 'Please verify your email',
// ),
// ),
// const SizedBox(
// width: 10.0,
// ),
// TextButton(
// onPressed: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value) {
// showToast(
// text: 'Check your mail',
// state: ToastState.success,
// );
// }).catchError((error) {
// print(error.toString());
// });
// },
// child: const Text(
// 'Send email verification',
// ),
// ),
// ],
// ),
// ),
// ],
// );
// },
// )
