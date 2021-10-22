import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:udemy_fluttter/shared/todo_cubit/cubit.dart';
import 'package:udemy_fluttter/shared/todo_cubit/states.dart';
class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TodoCubit,TodoStatesClass>(
        listener: (context,state){},
      builder: (context,state) {
          var tasks=TodoCubit.get(context).newTasks;
          return tasksEmptyBuilder(tasks:tasks );
    }
    );}

  }
