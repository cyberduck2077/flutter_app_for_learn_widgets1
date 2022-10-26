import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratedBloc extends Bloc<CounterEvent, int>{
  GeneratedBloc():super(0){
    on<CounterIncEvent>(_onIncrement);
    on<CounterDecEvent>(_onDecrement);
  }

  _onIncrement(CounterIncEvent event, Emitter<int> emit){
    emit(state+1);
    print(state);
  }
  _onDecrement(CounterDecEvent event, Emitter<int> emit){
    emit(state-1);
  }

}

abstract class CounterEvent{}
class CounterIncEvent extends CounterEvent{}
class CounterDecEvent extends CounterEvent{}