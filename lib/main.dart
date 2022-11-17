import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'modules/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/cubit.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

    showToast(text: 'on message', state: ToastState.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

    showToast(text: 'on message opened app', state: ToastState.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  uID = CacheHelper.getData(key: 'uID');
  //token = CacheHelper.getData(key: 'token');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  if (onBoarding != null) {
    if (uID != null) {
      widget = const SocialLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.startWidget});
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
