import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/themes/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Icon(
              Icons.palette_outlined,
              size: 50,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120, bottom: 5),
            child: Text(
              'Переключить тему',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: FittedBox(
                child: Switch(
                    value: Provider.of<ThemeProvider>(context).isDarkMode,
                    activeColor: Colors.yellow,
                    onChanged: (_) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    })),
          ),
        ],
      ),
    );
  }
}
