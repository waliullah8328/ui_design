import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(taskItem, {
    super.key,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title of the task",style: Theme.of(context).textTheme.titleSmall,),
            const Text("Description of the task"),
            const Text("12-12-2002"),
            const SizedBox(height: 8,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(onPressed:_onTapEditButton, icon: const Icon(Icons.edit)),
                    IconButton(onPressed: _onTapDeleteButton, icon: const Icon(Icons.delete)),

                  ],
                )
              ],
            )
          ],
        ),
      ),);


  }

  void _onTapEditButton(){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Edit Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ["New","Completed","Cancelled","Progressed"].map((e) {
            return ListTile(
              onTap: (){

              },
              title: Text(e),
            );

          }).toList(),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Cancel")),
          TextButton(onPressed: (){}, child: const Text("OK")),
        ],
      );
    },);

  }

  void _onTapDeleteButton(){

  }

  Widget _buildTaskStatusChip() {
    return Chip(
                label:const Text("New",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: const BorderSide(color: AppColors.themeColor),
              );
  }
}