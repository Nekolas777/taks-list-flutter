import 'package:flutter/material.dart';
import 'package:to_do_list_app/data/task_item.dart';
import 'package:to_do_list_app/presentation/widgets/profile_dialog.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [
    Task(id: 1, text: 'Buy groceries'),
    Task(id: 2, text: 'Walk the dog'),
    Task(id: 3, text: 'Complete Flutter project'),
  ];

  int counter = 3; // counter para simular id autoincremental :v
  final TextEditingController _taskController = TextEditingController();

  void onSubmit() {
    setState(() {
      tasks.add(
        Task(id: counter++, text: _taskController.text),
      );
      _taskController.text = "";
    });
  }

  void deleteTaskById(int id) {
    tasks.removeWhere((task) => task.id == id);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const profileUrl = "https://avatars.githubusercontent.com/u/129230632?v=4";

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Colors.purple[700], // Color morado oscuro
          title: const Row(
            children: [
              Text(
                'Tasks List',
                style: TextStyle(color: Colors.white), // Texto blanco
              ),
              SizedBox(width: 12),
              Icon(Icons.my_library_books_sharp, color: Colors.white),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    profileUrl,
                  ),
                ),
                onPressed: () {
                  showExpandedImage(context, profileUrl);
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Create a new task',
                          floatingLabelStyle: TextStyle(color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.cyan)),
                      onPressed: () {
                        onSubmit();
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 34.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 28.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final item = tasks[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              color: const Color.fromARGB(255, 231, 230, 230),
                              border:
                                  Border.all(width: 1.0, color: Colors.grey)),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    item.text,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      height: 1.5,
                                      letterSpacing: 0.65,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(Colors.red),
                                      ),
                                      onPressed: () {
                                        deleteTaskById(item.id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 28.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
