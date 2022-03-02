// // https //newsapi.org/
// // v2/top-headlines?
// // country=eg&category=business&
// // // apikey=65f7f556ec76449fa7dc7c0069f040ca
//
//
//
// https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&
// apiKey=1fa8a8274fd94f14badadf38da9dd335
import 'package:udemy_fluttter/modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';

import 'components.dart';

void signOut(context)=> CashHelper.removeData(key: 'token').then((value) {
  if(value)
    navigateAndFinish(context, ShopLoginScreen());
});

String ?token;
String ?uid;
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}