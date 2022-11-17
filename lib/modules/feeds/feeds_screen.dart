import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) => ConditionalBuilder(
        condition: SocialCubit.get(context).posts.isNotEmpty &&
            SocialCubit.get(context).userModel != null,
        fallback: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (BuildContext context) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                margin: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    const Image(
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/happy-dark-skinned-girl-enjoys-every-moment-life-dances-moves-raises-arms-clenches-fists-closes-eyes-has-good-mood-wears-denim-sarafan-turtleneck-isolated-pink-wall_273609-42165.jpg?w=1060&t=st=1668469608~exp=1668470208~hmac=ba149fac3c00bb70d7d17cd09524128fedb8323f54f222cc5c9296fbc40297ce',
                      ),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8.0,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: SocialCubit.get(context).posts.length,
                itemBuilder: (context, index) => buildPostItem(
                    context, SocialCubit.get(context).posts[index], index),
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPostItem(context, PostModel model, int index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 14.0,
                    ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20.0,
                          onPressed: () {},
                          child: const Text(
                            '#Lorem_Ipsum',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20.0,
                          onPressed: () {},
                          child: const Text(
                            '#Lorem_Ipsum',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20.0,
                          onPressed: () {},
                          child: const Text(
                            '#Lorem_Ipsum',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20.0,
                          onPressed: () {},
                          child: const Text(
                            '#Lorem_Ipsum',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20.0,
                          onPressed: () {},
                          child: const Text(
                            '#Lorem_Ipsum',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              IconlyLight.heart,
                              color: Colors.red,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 14.0,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconlyLight.chat,
                              color: Colors.amber,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).comments[index]} comment',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 14.0,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: CircleAvatar(
                              radius: 18.0,
                              backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel!.image}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 14.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsID[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconlyLight.heart,
                            color: Colors.red,
                            size: 18.0,
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'Like',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 14.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
