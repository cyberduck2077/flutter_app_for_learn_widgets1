import 'package:flutter/material.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/generated_bloc.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/main_page_bloc.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainPageBloc blocMainPage = MainPageBloc();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: blocMainPage,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GeneratedBloc>(
            create: (context) => GeneratedBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
        ],
        child: BlocBuilder<GeneratedBloc, int>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => BlocProvider.of<GeneratedBloc>(context)
                    .add(CounterDecEvent()),
                child: Icon(Icons.exposure_minus_1),
              ),
              backgroundColor: Colors.white,
              body: SafeArea(
                minimum: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataFromServerWidget(),
                        SizedBox(
                          height: 40,
                        ),
                        PageStateWidget(),
                        SizedBox(
                          height: 40,
                        ),
                        UserBlocWidget(),
                      ],
                    ),
                    // InputTextWidget(),
                    ButtonNextState(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    blocMainPage.dispose();
  }
}

class DataFromServerWidget extends StatelessWidget {
  const DataFromServerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainPageBloc mainPageBloc = Provider.of(context, listen: false);
    return Container(
      child: StreamBuilder<String>(
          stream: mainPageBloc.observeDataFromServer(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Text(
                "No data from server",
                style:
                    TextStyle(fontSize: 16, color: Colors.greenAccent.shade200),
                textAlign: TextAlign.center,
              );
            }
            String text = snapshot.data!;
            return Text(
              text,
              style:
                  TextStyle(fontSize: 16, color: Colors.greenAccent.shade200),
              textAlign: TextAlign.center,
            );
          }),
    );
  }
}

class PageStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 180,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black26,
            border: Border.all(width: 2, color: Colors.blueAccent)),
        child: BlocBuilder<GeneratedBloc, int>(
          builder: (context, state) {
            return Text(
              BlocProvider.of<GeneratedBloc>(context).state.toString(),
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ));
  }
}

class UserBlocWidget extends StatelessWidget {
  const UserBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      // bloc: UserBloc(),
      builder: (context, state) {
        return Column(
          children: [
            if (state is UserLoadingState) CircularProgressIndicator(),
            if (state is UserLoadedState)
              ...state.users.map(
                  (e) => Text(e.name, style: TextStyle(color: Colors.green))),
          ],
        );
      },
    );
  }
}

class ButtonNextState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainPageBloc mainPageBloc =
        Provider.of<MainPageBloc>(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              mainPageBloc.getTextFromServer();
            },
            child: Text(
              "Get Data From Server".toUpperCase(),
              style:
                  TextStyle(fontSize: 16, color: Colors.greenAccent.shade200),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<GeneratedBloc>(context).add(CounterIncEvent());
            },
            child: Text(
              "Next Generated State".toUpperCase(),
              style: TextStyle(fontSize: 16, color: Colors.blueAccent.shade400),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(UserGetUsersEvent(
                  BlocProvider.of<GeneratedBloc>(context).state));
            },
            child: Text(
              "Next User State".toUpperCase(),
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
