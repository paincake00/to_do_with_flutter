import 'package:flutter/material.dart';
import 'package:to_do/db/task_db.dart';
import 'package:to_do/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:to_do/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TaskDB.initialize();
  await TaskDB().saveThemeSettings();

  final status = await TaskDB().getThemeStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskDB()),
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider()..setThemeData(isDarkMode: status!)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MyHomePage(),
    );
  }
}
