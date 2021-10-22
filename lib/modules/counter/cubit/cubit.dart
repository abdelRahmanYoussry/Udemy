import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/counter/cubit/states.dart';

class CubitCounter extends Cubit<CounterStates>{
  CubitCounter(initialState) : super(CounterInitialState());
  static CubitCounter get(context)=>BlocProvider.of(context);
  int counter = 0;
  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }
  void plus(){
    counter++;
    emit(CounterPlusState(counter));
  }

}