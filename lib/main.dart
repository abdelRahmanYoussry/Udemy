import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_fluttter/modules/ShopApp/Layout/ShopLayout.dart';
import 'package:udemy_fluttter/modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopCubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/Layout/SocialLayout.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/login/social_login.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';
import 'package:udemy_fluttter/shared/network/remote/dio_helper.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_cubit.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_state.dart';
import 'package:udemy_fluttter/shared/todo_cubit/cubit.dart';
import 'package:udemy_fluttter/shared/todo_cubit/states.dart';
import 'package:udemy_fluttter/styles/Themes.dart';
import 'modules/ShopApp/ShopCubit/shopState.dart';
import 'modules/ShopApp/onBoarding/onBoarding.dart';
import 'modules/SocialApp/SocialCubit/state.dart';
import 'shared/components/bloc_observer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(text: 'onBackGroundMessage', state: ToastState.Success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var firebaseToken=await FirebaseMessaging.instance.getToken();
  print(firebaseToken);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'onMessage', state: ToastState.Success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'onMessageOpenedApp', state: ToastState.Success);

  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CashHelper.init();
 bool ?isDark=CashHelper.getData(key: 'isDark');
 Widget ?widget;
 uid=CashHelper.getData(key: 'uid');
 print(uid);
if(uid!=null){
  widget=SocialLayout();
}else{
  widget=SocialLogin();

}
 //bool? onBoarding=CashHelper.getData(key: 'onBoarding');
//token=CashHelper.getData(key: 'token');
//  if(onBoarding!=null)
//    {
//      if(token !=null)
//        widget=ShopLayoutScreen();
//      else widget= ShopLoginScreen();
//    }else
//      {
//        widget=OnBoardingScreen();
//      }

  runApp(MyApp(
      isDark:isDark,
     startWidget:widget ,
  ));
}

class MyApp extends StatelessWidget{
    bool? isDark;
    Widget  ? startWidget;

  MyApp({this.isDark, this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider (create: (context) =>
      NewsCubit(NewsInitialState())..getBusiness()..getSports()..getScience(), ) ,
      BlocProvider(create: (BuildContext context) => TodoCubit(TodoInitialState())..changeDarkMode(
       fromShared: false
       //!isDark!
      ),
      ),
      BlocProvider(create: (BuildContext context) => ShopCubit(ShopInitialState())..getHomeData()..getCategoriesData()..getFavouriteData()..getUserData()
        ),
      BlocProvider(create: (BuildContext context) => SocialCubit(SocialInitialState())..getUserData()..getPost()
        ),
      ],
      child: BlocConsumer<TodoCubit,TodoStatesClass>
        (listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:TodoCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light ,
            home: startWidget
          );
        },

      ),
    );

  }

}
