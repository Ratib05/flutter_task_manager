import 'package:flutter/material.dart';

// entry point of the app
void main() {
  runApp(const MyApp());
}

// main widget and it doesn't change
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // constructor with optional key

  // builds the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // root widget of the app
      title: 'Task Manager', // App title

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // App theme settings
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ), // primary colour
      ),

      home: const MyHomePage(title: 'Task Manager'), // sets the main screen
    );
  }
}

// this widget can be updated
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  }); // contructor with required title

  final String title; // title shown in the app bar

  // mutable state for this widget
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// This class holds the state (data and UI logic) for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  var tasks = <String>[]; // List of tasks

  int? _hoveredIndex; // Tracks which task is being hovered over (null if none)

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    return Scaffold(
      // basic layout structure
      appBar: AppBar(
        title: Text(widget.title), // uses the title from MyHomePage

        backgroundColor: Colors.blue,

        actions: [
          // buttons for the AppBar
          IconButton(
            icon: Icon(Icons.delete), // garbage bin icon
            // pressing the icon triggers 'onPressed' which triggers 'setState'
            onPressed: () {
              setState(() {
                // and clears the list
                tasks.clear();
              });
            },
          ),
        ],
      ),

      // if the task list is emtpy, show a message
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet'))
          : Column(
              children: [
                Expanded(
                  // take all available vertical space
                  child: ListView.builder(
                    // scrollable list
                    itemCount: tasks.length, // how many list tiles to display
                    itemBuilder: (context, index) {
                      // build each item

                      return MouseRegion(
                        // detects mouse movement

                        // when mouse enters a task
                        onEnter: (_) {
                          setState(() {
                            _hoveredIndex = index; // set the hovered index
                          });
                        },

                        // when mouse leaves a task
                        onExit: (_) {
                          setState(() {
                            _hoveredIndex = null; // reset the hovered index
                          });
                        },

                        child: ListTile(
                          tileColor:
                              _hoveredIndex ==
                                  index // Highlight if hovered
                              ? const Color.fromARGB(
                                  51,
                                  33,
                                  150,
                                  243,
                                ) //  light blue
                              : Colors.transparent, // no colour if not hovered

                          title: Text(tasks[index]), // show the text
                          // The checkbox always shows as unticked (false),
                          // tapping it triggers onChanged, which triggers setState,
                          trailing: Checkbox(
                            value: false,
                            onChanged: (value) {
                              setState(() {
                                tasks.removeAt(
                                  index,
                                ); // remove that task/ index
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
        // Button to add new task
        onPressed: () {
          TextEditingController textController =
              TextEditingController(); // get user/ text input

          // dialog box to enter new task
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add task"), // the title of the dialog box

              content: TextField(controller: textController), // input field

              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      tasks.add(
                        textController.text,
                      ); // add task to the task list
                    });

                    Navigator.pop(context); //  close the dialog box
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        },

        child: Icon(Icons.add), // icon for the button
      ),
    );
  }
}
