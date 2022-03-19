import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/todo_cubit/cubit.dart';
import 'package:udemy_fluttter/shared/todo_cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TodoCubit(TodoInitialState())..createDataBase(),
      child: BlocConsumer<TodoCubit, TodoStatesClass>(
        listener: (BuildContext context, TodoStatesClass state)
        {
        if(state is TodoInsertDataBaseState)
        {
          Navigator.pop(context);
        }
        },
        builder: (BuildContext context, TodoStatesClass state) {
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex])),
            body: ConditionalBuilder(
              condition: true,
              builder: (context)=>cubit.screenList[cubit.currentIndex],
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDataBase(title: titleController.text,
                        date: dateController.text,
                        time: timeController.text);
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultFormText(
                                            control: titleController,
                                            type: TextInputType.text,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Title Can't be Empty";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                            //  print(value.toString());
                                            },
                                            onTap: () {
                                              print(timeController.toString());
                                            },
                                            label: "Task Title",
                                            prefix: Icons.title),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        defaultFormText(
                                            control: timeController,
                                            type: TextInputType.datetime,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Time Can't be Empty";
                                              }
                                              return null;
                                            },
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime: TimeOfDay.now())
                                                  .then((value) {
                                                timeController.text = value!.format(context).toString();

                                                print(value.format(context));
                                              });
                                            },
                                            label: "Task Time",
                                            prefix: Icons.watch_later_rounded),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        defaultFormText(
                                          control: dateController,
                                          type: TextInputType.datetime,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Date Can't be Empty";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2021-12-01'),
                                            ).then((value) {
                                              dateController.text = DateFormat.yMMMd().format(value!);
                                            });
                                          },
                                          label: "Task Date",
                                          prefix: Icons.calendar_today,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          elevation: 20)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.flotIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // iconSize: 30,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.todoChangeState(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "To Do",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
