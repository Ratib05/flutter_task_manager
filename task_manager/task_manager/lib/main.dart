import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Task Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tasks = <String>[];
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                tasks.clear();
              });
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredIndex = index;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredIndex = null;
                          });
                        },
                        child: ListTile(
                          tileColor: _hoveredIndex == index
                              ? const Color.fromARGB(51, 33, 150, 243)
                              : Colors.transparent,

                          title: Text(tasks[index]),

                          // The checkbox always shows as unticked (false),
                          // tapping it triggers onChanged, which triggers setState,
                          // no need to track checkbox state at all.
                          trailing: Checkbox(
                            value: false,
                            onChanged: (value) {
                              setState(() {
                                tasks.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController textController = TextEditingController();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add task"),
              content: TextField(controller: textController),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      tasks.add(textController.text);
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
