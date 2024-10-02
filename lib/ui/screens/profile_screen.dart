import 'package:flutter/material.dart';
import 'package:ui_design/ui/widgets/task_manager_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: TaskManagerAppBar(isProfileOpen: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48,),
              Text(
                "Update Profile",
                style:Theme.of(context).textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32,),
              _buildPhotoPicker(),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Phone Number",

                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",

                ),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
              const SizedBox(height: 16,),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() => Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white

    ),
    child: Row(
      children: [
        Container(
          width: 100,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8)
            ),
          ),
          alignment: Alignment.center,
          child: const Text("Photos",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
        ),
        const SizedBox(width: 8,),
        const Text("Selected photo"),
      ],
    ),
  );
}
