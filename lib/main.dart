import 'package:flutter/material.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/generated_bloc.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_app_for_learn_widgets1/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final generatedBloc = GeneratedBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<GeneratedBloc>(
          create: (context) => generatedBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(generatedBloc),
        ),
      ],
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}

