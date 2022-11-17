import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({
    required this.userModel,
  });

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context)
            .getMessages(receiverID: userModel.uID as String);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) => Scaffold(
            appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${userModel.name}',
                    ),
                  ],
                )),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.isNotEmpty,
              fallback: (BuildContext context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Empty!',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      IconlyLight.message,
                      color: Colors.grey,
                      size: 80.0,
                    ),
                  ],
                ),
              ),
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (SocialCubit.get(context).userModel!.uID ==
                              message.senderID) {
                            return buildMyMessage(message);
                          } else {
                            return buildMessage(message);
                          }
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10.0,
                        ),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300] as Color,
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: textController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              // borderRadius: BorderRadiusDirectional.all(
                              //   Radius.circular(10.0),
                              // ),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverID: userModel.uID as String,
                                  text: textController.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                textController.text = '';
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                IconlyLight.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );
}
