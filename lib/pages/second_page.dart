import 'package:flutter/material.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final jobState = state.job;
              return Column(
                children: [
                  if (state.isLoading) CircularProgressIndicator(),
                  if (jobState.isNotEmpty) ...jobState.map((e) => Text(e.name)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
