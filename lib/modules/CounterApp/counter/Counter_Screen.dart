import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>CubitCounter(CounterInitialState),
      child: BlocConsumer<CubitCounter,CounterStates>
        (
          builder: (BuildContext context,CounterStates state){
            return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                       CubitCounter.get(context).minus();
                        //print('${CubitCounter.get(context).counter}');
                      },
                      child: Text("Minus", style: TextStyle(fontSize: 30))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      '${CubitCounter.get(context).counter}',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                       CubitCounter.get(context).plus();
                        //print('${CubitCounter.get(context).counter}');
                      },
                      child: Text(
                        "Plus",
                        style: TextStyle(fontSize: 30),
                      )),
                ],
              ),
            ),
          );},
          listener: (BuildContext context,CounterStates state){
            if(state is CounterMinusState) print('MinusState ${state.counter}');
            if(state is CounterPlusState) print('PlusState ${state.counter}');
          }

      ),

    );
  }
}
