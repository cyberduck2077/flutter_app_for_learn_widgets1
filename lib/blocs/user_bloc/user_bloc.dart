import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/generated_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final GeneratedBloc generatedBloc;
  late final StreamSubscription generatedBlocSubscription;//подписка на изменение состояния (state)


  UserBloc(this.generatedBloc) : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetUsersJobEvent>(_onGetUserJob);

    generatedBlocSubscription = generatedBloc.stream.listen((state) {//реаширует на изменение состояния
      if(state<=0){
        add(UserGetUsersEvent(0));
        add(UserGetUsersJobEvent(0));
      }
    });
  }

  @override
  Future<void> close()async{
    generatedBlocSubscription.cancel();
    return super.close();
  }



  //обработка события (UserGetUsersEvent) и изменение состояния (UserState)
  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    //Emitter - позволяет изменять состояние
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(milliseconds: 500));
    final users = List.generate(event.count,
        (index) => User(name: "user name ${index + 1}", id: index.toString()));
    emit(state.copyWith(users: users));// isLoading по умолчанию false
  }

  _onGetUserJob(UserGetUsersJobEvent event, Emitter <UserState> emit) async{
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(milliseconds: 500));
    final job = List.generate(event.count,
            (index) => Job(name: "Job ${index + 1}", id: index.toString()));
    emit(state.copyWith(job: job));// isLoading по умолчанию false
  }
}
