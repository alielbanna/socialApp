import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, Object? state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastState.error);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uID',
              value: state.uID,
            ).then((value) {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (BuildContext context) => defaultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have any account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              child: const Text('Register Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
