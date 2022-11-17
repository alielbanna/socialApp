import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uID: value.user!.uid,
      );
      //emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uID,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uID: uID,
      bio: 'write your bio ...',
      image:
          'https://img.freepik.com/premium-photo/portrait-joyful-young-afro-american-man_171337-84575.jpg',
      cover:
          'https://img.freepik.com/free-photo/unshaven-adult-man-with-dark-skin-laughs-happily-holds-chin-stands-carefree_273609-37032.jpg?w=1060&t=st=1668559382~exp=1668559982~hmac=ad055127b80438f24bb44d627fe8f7c2799827ed62f62ecbe737d7a8f1a1b8a3',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());
  }
}
