import 'package:flutter/material.dart';

import '../../api/apiClient.dart';
import '../widgets/list_of_task.dart';
import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {

  List taskItems = [];
  bool isLoading = true;
  String status = "Canceled";



  callData() async {
    var data = await taskListRequest("Canceled");
    setState(() {
      isLoading = false;
      taskItems = data;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    callData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?const Center(child: CircularProgressIndicator()):RefreshIndicator(child:  ListOfTask(taskItems: taskItems,deleteItems: deleteId,statusChange: statusChangeId,), onRefresh: () async {
      await callData();
    });
  }

  deleteId(id){
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          title: Text("Delete!"),
          content: Text("Once you delete it, you can't get back!"),
          actions: [
            OutlinedButton(onPressed: ()async{
              Navigator.pop(context);
              setState(() {
                isLoading = true;
              });
              await taskDeleteRequest(id);
              await callData();

            }, child: Text("Yes")),
            OutlinedButton(onPressed: ()async{
              Navigator.pop(context);


            }, child: Text("No")),
          ],
        );
      },);
  }
  statusChangeId(id){
    showModalBottomSheet(context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(30),
            height: 370,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RadioListTile(value: "New", groupValue: status, title: Text("New"),onChanged:(value){
                  setState((){
                    status = value.toString();

                  });


                }),
                RadioListTile(value: "Progress", groupValue: status, title: const Text("Progress"),onChanged:(value){
                  setState((){
                    status = value.toString();

                  });


                }),
                RadioListTile(value: "Completed", groupValue: status, title: const Text("Completed"),onChanged:(value){
                  setState((){
                    status = value.toString();

                  });


                }),

                RadioListTile(value: "Canceled", groupValue: status, title: const Text("Canceled"),onChanged:(value){
                  setState((){
                    status = value.toString();

                  });


                }),
                const SizedBox(height: 20,),

                Container(child: SizedBox(
                  width: 200, // Set the desired width
                  height: 45,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                    setState(() {
                      isLoading = true;
                    });

                    taskUpdateRequest(id,status);
                    callData();
                    setState((){
                      status = "Canceled";

                    });

                  }, child: Text("Confirm"),
                    style: ElevatedButton.styleFrom(


                    ),
                  ),
                ),)

              ],
            ),
          );
        },);
      },);
  }
}