import 'package:first_app/widget/ListAllTaskWidget.dart';
import 'package:first_app/widget/ListTaskByTabWidget.dart';
import 'package:flutter/material.dart';
import 'package:first_app/libary/globals.dart' as globals;

class ListTasksView extends StatefulWidget {
  const ListTasksView({super.key});

  @override
  State<ListTasksView> createState() => _ListTasksViewState();
}

class _ListTasksViewState extends State<ListTasksView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "List Tasks",
            style: TextStyle(color: Colors.white), // Set the title color to white
          ),
          backgroundColor: Theme.of(context).primaryColor, // Use responsive color
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white, // Set the selected tab text color to white
            unselectedLabelColor: Colors.white60, // Set the unselected tab text color to a lighter white
            tabs: [
              Tab(text: "All"),
              Tab(text: "Today"),
              Tab(text: "Tomorrow"),
              Tab(text: "This Week"),
              Tab(text: "Next Week"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListAllTaskWidget(),
            ListTaskByTabWidget(tabKey: globals.today),
            ListTaskByTabWidget(tabKey: globals.tomorrow),
            ListTaskByTabWidget(tabKey: globals.thisWeek),
            ListTaskByTabWidget(tabKey: globals.nextWeek),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white), // Set the icon color to white
          backgroundColor: Theme.of(context).primaryColor, // Use responsive color for button background
          onPressed: () {
            Navigator.pushNamed(context, 'addTasks');
          },
        ),
      ),
    );
  }
}
