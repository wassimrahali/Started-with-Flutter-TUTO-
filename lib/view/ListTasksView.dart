import 'package:first_app/widget/ListTaskWidget.dart';
import 'package:flutter/material.dart';


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
            title: const Text("List Tasks"),
            backgroundColor: Colors.teal,
            bottom: const TabBar(
              isScrollable: true,
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
              ListTaskWidget(),
              ListTaskWidget(),
              ListTaskWidget(),
              ListTaskWidget(),
              ListTaskWidget(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
             onPressed: () {
            Navigator.pushNamed(context, 'addTasks');
             }),
      ),
    );
  }
}
