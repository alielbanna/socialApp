import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'components.dart';

void singOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size for each chunk
  pattern.allMatches(text).forEach(
        (match) => print(match.group(0)),
      );
}

String? token = '';
String? uID = '';
