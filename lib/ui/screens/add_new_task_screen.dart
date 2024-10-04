import 'package:flutter/material.dart';


import '../widgets/task_manager_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const TaskManagerAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42,),

              Text("Add New Task",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),),
              const SizedBox(height: 24,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Title"
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Decription"
                ),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
            ],
          ),
        ),
      ),

    );
  }
}
