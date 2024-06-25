import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/components/my_drawer.dart';
import 'package:to_do/components/my_task_tile.dart';
import 'package:to_do/db/task_db.dart';
import 'package:to_do/models/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Provider.of<TaskDB>(context, listen: false).readTasks();

    super.initState();
  }

  final TextEditingController _taskController = TextEditingController();

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(
            hintText: 'Введите задачу',
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newTaskName = _taskController.text;

              context.read<TaskDB>().addTask(newTaskName);

              Navigator.pop(context);

              _taskController.clear();
            },
            child: const Text('Добавить'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              _taskController.clear();
            },
            child: const Text('Отменить'),
          ),
        ],
      ),
    );
  }

  void editTask(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(hintText: 'Измените задачу'),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newTaskName = _taskController.text;

              context.read<TaskDB>().updateName(task.id, newTaskName);

              Navigator.pop(context);

              _taskController.clear();
            },
            child: const Text('Обновить'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              _taskController.clear();
            },
            child: const Text('Отменить'),
          ),
        ],
      ),
    );
  }

  void deleteTask(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить задачу?'),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<TaskDB>().deleteTask(task.id);

              Navigator.pop(context);
            },
            child: const Text('Удалить'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отменить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        elevation: 5,
        // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: _buildTaskList(),
      ),
    );
  }

  Widget _buildTaskList() {
    final taskDB = context.watch<TaskDB>();

    List<Task> currentTasks = taskDB.currentTasks;

    return ListView.builder(
      itemCount: currentTasks.length,
      itemBuilder: (context, index) {
        final task = currentTasks[index];

        return MyTaskTile(
          text: task.name,
          isDone: task.isDone,
          onChanged: (value) {
            context.read<TaskDB>().updateCompletion(task.id, value!);
          },
          editTask: (context) => editTask(task),
          deleteTask: (context) => deleteTask(task),
        );
      },
    );
  }
}
