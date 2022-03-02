import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_fluttter/modules/ToDoApp/DoneTasks/todoscreen.dart';
import 'package:udemy_fluttter/modules/ToDoApp/archivedTasks/archived_screen.dart';
import 'package:udemy_fluttter/modules/ToDoApp/tasks/tasks_screen.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';
import 'package:udemy_fluttter/shared/todo_cubit/states.dart';

class TodoCubit extends Cubit<TodoStatesClass>{
  TodoCubit(TodoStatesClass initialState) : super(initialState);
  static TodoCubit get(context) =>BlocProvider.of(context);
  int currentIndex = 0;
  late Database dataBase;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  List<Widget> screenList = [
    TasksScreen(),
    TodoScreen(),
    ArchivedScreen(),
  ];
  List<String> titles = ["New Tasks", "Todo Tasks", "Archived Tasks"];

  void todoChangeState(int index){
    currentIndex=index;
    emit(TodoChangeBottomNavBarState());
  }
  void createDataBase()  {
    openDatabase(
      'todo2.db',
      version: 1,
      onCreate: (database, version) {
        print("database has created");
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print("Table has created");
        }).catchError((error) {
          print("error is : ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print("database has opened");
      },
    ).then((value) {
      dataBase=value;
    emit(TodoCreateDataBaseState());
    });
  }
   insertToDataBase(
      {required String title,
        required String date,
        required String time}) async {
      await dataBase.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES( "$title", "$date", "$time", "new" )')
          .then((value) {
        print("$value inserted successfully");
        emit(TodoInsertDataBaseState());
        getDataFromDataBase(dataBase);
      }).catchError((onError) {
        print('The Error while insert is ${onError.toString()}');
      });
    });
  }

  void getDataFromDataBase (dataBase)
  {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['status']=='new')
          newTasks.add(element);
        else if(element['status']=='done')
          doneTasks.add(element);
        else archiveTasks.add(element);
        print(element['status']);
      });
      emit(TodoGetDataBaseState());
    });
  }

  void updateData({required String status,required int id})
  {
    dataBase.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]
   ).then((value) {
     getDataFromDataBase(dataBase);
      emit(TodoUpdateDataBaseState());

    });
  }
  bool isBottomSheetShown = false;
  IconData flotIcon = Icons.edit;

  void changeBottomSheet({
  required bool isShow,
    required IconData icon,})
  {
   isBottomSheetShown=isShow;
   flotIcon=icon;
   emit(TodoChangeBottomSheetState());
  }
  void deleteData({required int id})
  {
    dataBase.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(dataBase);
      emit(TodoDeleteDataBaseState());
    });
}

  bool isDark= false;
  void changeDarkMode({bool? fromShared})
  {
   if(fromShared!=null){

   isDark=fromShared;

     emit(ChangeAppMode());
   }
   else
     {
       isDark=!isDark;
     CashHelper.putBool(key: 'isDark', value: isDark).
     then((value) {
       emit(ChangeAppMode());
     });}

  }


}