import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            fallback: (BuildContext context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (BuildContext context) => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  buildChatItem(context, SocialCubit.get(context).users[index]),
              separatorBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: SocialCubit.get(context).users.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(userModel: model),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      );
}
