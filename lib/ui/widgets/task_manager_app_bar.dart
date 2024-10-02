import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/profile_screen.dart';
import 'package:ui_design/ui/screens/signin_screen.dart';
import 'package:ui_design/ui/utils/utils.dart';

import '../utils/app_colors.dart';

class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({
    super.key,  this.isProfileOpen = false,
  });
  final bool isProfileOpen;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isProfileOpen){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,

        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16,),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Wali Ullah Ripon",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("waliullah8328@gmai.com",style: TextStyle(fontSize: 12,color: Colors.white),),
                ],
              ),
            ),
            IconButton(onPressed: () async {
              bool response = await removeUserData();
              if(response == true){
                debugPrint("User data delete");
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false);
            }, icon: const Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}