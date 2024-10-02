import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(height: 8,),
      itemBuilder: (context, index) {
        return const TaskCard();
      },);
  }
}