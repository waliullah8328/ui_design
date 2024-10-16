import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:ui_design/ui/screens/new_task_screen.dart';


import '../../api/apiClient.dart';
import '../utils/utils.dart';
import '../widgets/task_manager_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  Map<String,String> formValues ={"title":"", "description": "", "status":"New"};
  bool isLoading = false;

  inputOnChange(mapKey, textValue){
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });

  }

  formOnSubmit()async{


    setState(() {
      isLoading = true;
    });

    bool response = await taskCreateRequest(formValues);
    if(response == true){
      setState(() {
        isLoading = false;
      });
      // Navigate to dashboard screen

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen(),), (route) => false);


    }
    else{
      setState(() {
        isLoading = false;
      });

    }






  }
  final _addNewFormKey = GlobalKey<FormState>();

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TaskManagerAppBar(profileData: profileData,),
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
              Form(
                key: _addNewFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Title is required";

                        }
                        return null;
                      },
                      onChanged: (textValue){
                        inputOnChange("title", textValue);
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Title"
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      maxLines: 5,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Description is required";

                        }
                        return null;
                      },
                      onChanged: (textValue){
                        inputOnChange("description", textValue);
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: "Decription"
                      ),
                    ),
                    const SizedBox(height: 16,),
                    ElevatedButton(onPressed: _addButton, child: const Icon(Icons.arrow_circle_right_outlined)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  void _addButton() {

    if(!_addNewFormKey.currentState!.validate()){
      return;
    }
    formOnSubmit();
  }
}
