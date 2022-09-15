import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_flutter/bloc/activity/activit_bloc.dart';
import 'package:todolist_flutter/bloc/todo/todo_bloc.dart';

import 'package:todolist_flutter/models/activity_model.dart';
import 'package:todolist_flutter/screens/activity_screen.dart';
import 'package:todolist_flutter/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityBloc>(
          create: (BuildContext context) => ActivityBloc(),
        ),
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ActivityScreen.routeName,
        routes: {
          ActivityScreen.routeName: (context) => const ActivityScreen(),
          TodoScreen.routeName: (context) => TodoScreen(
                data:
                    ModalRoute.of(context)?.settings.arguments as ActivityModel,
              )
        },
      ),
    );
  }
}
