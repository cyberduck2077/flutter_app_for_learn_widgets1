part of 'user_bloc.dart';

//те состояния, к которым можем обращаться в UI при помощи state. :

@immutable
class UserState {
  final List<User> users;
  final List<Job> job;
  final bool isLoading;

  UserState({
    this.users = const [],
    this.job = const [],
    this.isLoading = false,
  });

  UserState copyWith({
    List<User>? users,
    List<Job>? job,
    bool isLoading = false,
  }) {
    return UserState(
      users: users ?? this.users,
      job: job ?? this.job,
      isLoading: isLoading,
    );
  }
}

//User - можно вынести в отдельный класс
class User {
  final String name;
  final String id;

  User({
    required this.name,
    required this.id,
  });
}

class Job {
  final String name;
  final String id;

  Job({
    required this.name,
    required this.id,
  });
}
