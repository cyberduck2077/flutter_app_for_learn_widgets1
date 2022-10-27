import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetUsersJobEvent>(_onGetUserJob);
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
