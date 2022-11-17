import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/create_post/create_post_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    CreatePostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = const [
    'Home',
    'Chats',
    'post',
    'Users',
    'Settings',
  ];

  void changeBottom(int index) {
    if (index == 1) getAllUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('NO image selected. ');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('NO image selected. ');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  //String profileImageURL = '';

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUploadUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //profileImageURL = value;
        updateUserData(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );

        //emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState(error));
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState(error));
    });
  }

  //String coverImageURL = '';

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUploadUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //coverImageURL = value;
        updateUserData(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        //emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    // emit(SocialUploadUserLoadingState());

    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uID: userModel!.uID,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadUserErrorState(error.toString()));
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('NO image selected. ');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        //emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uID: userModel!.uID,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  //************************************************************

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            postsID.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
          }).catchError((error) {});
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel!.uID)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  void commentPost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('comments')
        .doc(userModel!.uID)
        .set({
      'comment': 'good',
    }).then((value) {
      emit(SocialCommentPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCommentPostsErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    //users = [];
    if (users.isEmpty) {
      emit(SocialGetAllUsersLoadingState());

      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uID'] != userModel!.uID) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

//******************************************************

  void sendMessage({
    required String receiverID,
    required String text,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverID: receiverID,
      senderID: userModel!.uID,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userModel!.uID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
