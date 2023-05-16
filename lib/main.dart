import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'Notes');
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  TextEditingController textEditController = TextEditingController();
  late String notes;
  late List<String> notesList = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (buildContext, mode, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditController,
                    onChanged: (text) {
                      notes = text;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Notes", hintText: "Enter notes"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Create notes"),
                    onPressed: () {
                      setState(() {
                        notesList.add(notes);
                        textEditController.clear();
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(title: Text(notesList[index])),
                      );
                    },
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => setState(() {
                  _notifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                }),
                child: const Icon(Icons.color_lens_rounded)),
          ),
        );
      },
    );
  }
}
