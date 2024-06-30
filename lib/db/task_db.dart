import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do/models/app_settings.dart';
import 'package:to_do/models/task.dart';

class TaskDB extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // save theme settings
  Future<void> saveThemeSettings() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..isDarkMode = false;
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // get theme settings
  Future<bool?> getThemeStatus() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings!.isDarkMode;
  }

  // set theme settings
  Future<void> setThemeSettings(bool value) async {
    final settings = await isar.appSettings.where().findFirst();
    if (settings == null) {
      saveThemeSettings();
    }
    settings!.isDarkMode = value;
    await isar.writeTxn(() => isar.appSettings.put(settings));
  }

  // current task
  final List<Task> currentTasks = [];

  // READ
  Future<void> readTasks() async {
    List<Task> fetchedTasks = await isar.tasks.where().findAll();

    currentTasks.clear();
    currentTasks.addAll(fetchedTasks);

    notifyListeners();
  }

  // CREATE
  Future<void> addTask(String taskName) async {
    final newTask = Task()..name = taskName;

    await isar.writeTxn(() async {
      await isar.tasks.put(newTask);
    });

    // re-read from db
    readTasks();
  }

  // UPDATE STATUS COMPLETION
  Future<void> updateCompletion(int id, bool isDone) async {
    final task = await isar.tasks.get(id);

    if (task != null) {
      task.isDone = isDone;

      await isar.writeTxn(() async {
        await isar.tasks.put(task);
      });
    }

    readTasks();
  }

  // UPDATE TASK NAME
  Future<void> updateName(int id, String name) async {
    final task = await isar.tasks.get(id);

    if (task != null) {
      task.name = name;

      await isar.writeTxn(() async {
        await isar.tasks.put(task);
      });
    }

    readTasks();
  }

  // DELETE
  Future<void> deleteTask(int id) async {
    await isar.writeTxn(() async {
      await isar.tasks.delete(id);
    });

    readTasks();
  }
}
