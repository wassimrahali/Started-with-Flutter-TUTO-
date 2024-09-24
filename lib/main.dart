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
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "listTasks" : (context)=>ListTasksView(),
        "addTasks" :(context)=>AddTaskView(),
      },
      home:ListTasksView()
    );
  }
}
