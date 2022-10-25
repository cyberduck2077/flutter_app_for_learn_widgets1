import 'package:flutter/material.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/main_page_bloc.dart';
import 'package:flutter_app_for_learn_widgets1/widgets/input_text.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainPageBloc bloc = MainPageBloc();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>bloc.resetState(),
          child: Icon(Icons.refresh),
        ),
          backgroundColor: Colors.white,
          body: SafeArea(
            minimum: const EdgeInsets.all(8),
            child: Stack(
              children: [
                PageStateWidget(),
                InputTextWidget(),
                ButtonNextState(),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
  }
}

class PageStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainPageBloc bloc = Provider.of(context, listen: false);
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 180,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black26,
            border: Border.all(width: 2, color: Colors.blueAccent)),
        child: StreamBuilder<String>(
            stream: bloc.observeStatePage(),
            builder: (context, snapshot) {
              if (snapshot.data == null || !snapshot.hasData) {
                return Text("no data");
              }
              String text = snapshot.data!;
              return Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
      ),
    );
  }
}

class ButtonNextState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainPageBloc bloc = Provider.of(context, listen: false);
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {
          bloc.changeState();
        },
        child: Text(
          "Next state".toUpperCase(),
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
      ),
    );
  }
}
