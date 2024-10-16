import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_design/api/apiClient.dart';
import 'package:ui_design/ui/screens/add_new_task_screen.dart';
import '../widgets/list_of_task.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List taskItems = [];
  List taskCountList = [];
  bool isLoading = true;
  String status = "New";

  // Call to fetch both task list and task count
  callData() async {
    setState(() {
      isLoading = true; // Start loading indicator
    });

    var data = await taskListRequest("New");
    var data2 = await taskCountRequest();

    setState(() {
      taskItems = data;
      taskCountList = data2;
      isLoading = false; // Stop loading indicator after data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    callData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader when loading
          : RefreshIndicator(
        onRefresh: () async {
          await callData(); // Refresh data when pulled down
        },
        child: Column(
          children: [
            _buildSummarySection(taskCountList), // Task summary section
            Expanded(
              child: ListOfTask(
                taskItems: taskItems,
                deleteItems: deleteId,
                statusChange: statusChangeId,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton, // Handle add new task button
        child: const Icon(Icons.add),
      ),
    );
  }

  // Build the summary section dynamically based on taskCountList
  Widget _buildSummarySection(List taskCountList) {
    // Define the desired order for the task statuses
    final List<String> order = ["New", "Completed", "Progress", "Canceled"];

    // Sort the taskCountList according to the predefined order
    List sortedTaskCountList = taskCountList
        .where((task) => order.contains(task["_id"])) // Filter only relevant tasks
        .toList()
      ..sort((a, b) => order.indexOf(a["_id"]).compareTo(order.indexOf(b["_id"])));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: sortedTaskCountList.map((task) {
            return TaskSummaryCard(
              title: task["_id"] ?? "Unknown", // Dynamic title
              count: task["sum"] ?? 0, // Dynamic count
            );
          }).toList(),
        ),
      ),
    );
  }



  // Function to handle adding new tasks
  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  // Handle task deletion with confirmation dialog
  deleteId(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete!"),
          content: const Text("Once you delete it, you can't get it back!"),
          actions: [
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                setState(() {
                  isLoading = true; // Set loading state
                });
                await taskDeleteRequest(id); // Delete the task
                await callData(); // Refresh the data
              },
              child: const Text("Yes"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  // Handle status change with modal bottom sheet
  statusChangeId(id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(30),
              height: 370,
              child: Column(
                children: [
                  // Radio buttons for status selection
                  RadioListTile(
                    value: "New",
                    groupValue: status,
                    title: const Text("New"),
                    onChanged: (value) {
                      setModalState(() {
                        status = value.toString(); // Update local status
                      });
                    },
                  ),
                  RadioListTile(
                    value: "Progress",
                    groupValue: status,
                    title: const Text("Progress"),
                    onChanged: (value) {
                      setModalState(() {
                        status = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    value: "Completed",
                    groupValue: status,
                    title: const Text("Completed"),
                    onChanged: (value) {
                      setModalState(() {
                        status = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    value: "Canceled",
                    groupValue: status,
                    title: const Text("Canceled"),
                    onChanged: (value) {
                      setModalState(() {
                        status = value.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Confirm button
                  SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context); // Close modal
                        setState(() {
                          isLoading = true; // Set loading state
                        });
                        await taskUpdateRequest(id, status); // Update task status
                        await callData(); // Refresh the data
                        setState(() {
                          status = "New"; // Reset status
                        });
                      },
                      child: const Text("Confirm"),
                      style: ElevatedButton.styleFrom(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
