import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/canceled_task_screen.dart';
import 'package:ui_design/ui/screens/completed_task_screen.dart';
import 'package:ui_design/ui/screens/new_task_screen.dart';
import 'package:ui_design/ui/screens/progress_task_screen.dart';
import 'package:ui_design/ui/utils/app_colors.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0; // Move it here, so it's part of the widget's state

  static const List<Widget> _screens = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,

        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Wali Ullah Ripon",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("waliullah8328@gmai.com",style: TextStyle(fontSize: 12,color: Colors.white),),
                ],
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.logout)),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index; // Update selected index
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: "New"),
          NavigationDestination(icon: Icon(Icons.check_box), label: "Completed"),
          NavigationDestination(icon: Icon(Icons.close), label: "Cancel"),
          NavigationDestination(icon: Icon(Icons.access_time_filled_outlined), label: "Progress"),
        ],
      ),
    );
  }
}
