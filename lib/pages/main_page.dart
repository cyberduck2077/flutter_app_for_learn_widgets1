import 'package:flutter/material.dart';
import 'package:flutter_app_for_learn_widgets1/blocs/generated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GeneratedBloc>(
      create: (context) => GeneratedBloc(),
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
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 180,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black26,
                            border:
                                Border.all(width: 2, color: Colors.blueAccent)),
                        child: Text(
                          BlocProvider.of<GeneratedBloc>(context)
                              .state
                              .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // InputTextWidget(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () => BlocProvider.of<GeneratedBloc>(context)
                            .add(CounterIncEvent()),
                        child: Text(
                          "Increment value".toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

// class PageStateWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//           alignment: Alignment.center,
//           height: 180,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.black26,
//               border: Border.all(width: 2, color: Colors.blueAccent)),
//           child: Text(
//             "",
//             style: TextStyle(
//               fontSize: 24,
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w600,
//             ),
//           )),
//     );
//   }
// }

// class ButtonNextState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: TextButton(
//         onPressed: () {},
//         child: Text(
//           "Next state".toUpperCase(),
//           style: TextStyle(fontSize: 16, color: Colors.green),
//         ),
//       ),
//     );
//   }
// }
