import 'package:first_app/provider/TaskProvider.dart';
import 'package:first_app/view/AddTaskView.dart';
import 'package:first_app/view/ListTasksView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskModel()),
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "ListTasks" : (context)=>ListTasksView(),
        "addTasks" :(context)=>AddTaskView(),
      },
      home:ListTasksView()
    );
  }
}
