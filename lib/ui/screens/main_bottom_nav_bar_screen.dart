
import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/canceled_task_screen.dart';
import 'package:ui_design/ui/screens/completed_task_screen.dart';
import 'package:ui_design/ui/screens/new_task_screen.dart';
import 'package:ui_design/ui/screens/progress_task_screen.dart';
import 'package:ui_design/ui/utils/utils.dart';
import '../widgets/task_manager_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0; // Move it here, so it's part of the widget's state

  Map<String,String> profileData= {"email":"","firstName":"","lastName":"",};

  readAppBarData() async {
    String? email = await readUserData("email");
    String? firstName = await readUserData("firstName");
    String? lastName = await readUserData("lastName");
    setState(() {
      profileData= {"email":"$email","firstName":"$firstName","lastName":"$lastName",};

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readAppBarData();
    super.initState();
  }

  static const List<Widget> _screens = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar( profileData: profileData,),
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


