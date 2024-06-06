import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  final List<dynamic> todoItems;
  final Function(String) deleteTodo; // Accept delete function

  const ToDoList({Key? key, required this.todoItems, required this.deleteTodo})
      : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return widget.todoItems.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's Add Some Task Hooman!",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff61376b),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      'assets/images/error.png',
                      fit: BoxFit.cover,
                      height: 180,
                    ),
                  ],
                ),
              ),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.todoItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(widget.todoItems[index]['_id']),
                direction:
                    DismissDirection.endToStart, // Dismiss from end to start
                onDismissed: (direction) {
                  widget.deleteTodo(widget.todoItems[index]['_id']);
                  setState(() {
                    widget.todoItems.removeAt(index);
                  });
                },
                background: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.red,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    tileColor: widget.todoItems[index]['isDone']
                        ? const Color.fromARGB(255, 85, 203, 89)
                        : const Color.fromARGB(31, 255, 255, 255),
                    contentPadding: const EdgeInsets.all(8),
                    title: Text(
                      widget.todoItems[index]['title'],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    leading: Checkbox(
                        value: widget.todoItems[index]['isDone'],
                        onChanged: (bool? value) {
                          setState(() {
                            widget.todoItems[index]['isDone'] = value!;
                          });
                        }),
                  ),
                ),
              );
            });
  }
}
