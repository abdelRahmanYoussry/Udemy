import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';
import 'package:udemy_fluttter/shared/network/remote/dio_helper.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_cubit.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_state.dart';
import 'package:udemy_fluttter/shared/todo_cubit/cubit.dart';
import 'package:udemy_fluttter/shared/todo_cubit/states.dart';
import 'layout/news_layout/News_home_layout.dart';
import 'shared/components/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CashHelper.init();
 bool? isDark=CashHelper.getBool(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget{
  late final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider (create: (context) => NewsCubit(NewsInitialState())..getBusiness()..getSports()..getScience(), ) ,
      BlocProvider(create: (BuildContext context) => TodoCubit(TodoInitialState())..changeDarkMode(
       fromShared: isDark),)],
      child: BlocConsumer<TodoCubit,TodoStatesClass>
        (listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch:Colors.deepOrange ,
                scaffoldBackgroundColor:Colors.white ,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle:SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                  ) ,
                  color: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme:BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    elevation:40
                ),
                textTheme:TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                )
            ),
            darkTheme: ThemeData(
                primarySwatch:Colors.deepOrange ,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle:SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light
                    ) ,
                    color:HexColor('333739'),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.white
                    )
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme:BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('333739'),
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation:40,
                ),
                textTheme:TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),
            themeMode: TodoCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light ,
            home: NewsHomeLayout(),
          );
        },

      ),
    );
  }
}
