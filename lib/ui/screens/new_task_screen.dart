

import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/add_new_task_screen.dart';
import 'package:ui_design/ui/utils/app_colors.dart';

import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 8,),
            itemBuilder: (context, index) {
            return const TaskCard();
          },))

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        child: const Icon(Icons.add),
      ),
    );



  }

  Widget _buildSummarySection() {
    return const Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TaskSummaryCard(title: "New",count: 09,),
                TaskSummaryCard(title: "Completed",count: 09,),
                TaskSummaryCard(title: "Cancelled",count: 09,),
                TaskSummaryCard(title: "Progress",count: 09,),

              ],
            ),
          ),
        );
  }

  void _onTapAddButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen(),));

  }
}




