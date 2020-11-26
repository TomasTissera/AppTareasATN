import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyect/Models/todo.dart';
import 'package:proyect/Utils/database_helper.dart';
import 'package:proyect/Screens/todo_detail.dart';
import 'package:sqflite/sqflite.dart';
class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: getTodoListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('FAB clicked');
            navigateToDetail(Todo('', '', '', ''  ), ' ');
          },
          tooltip: 'Add Todo',
          child: Icon(Icons.add,color: Colors.black,),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: Column(
              children: [
                new ListTile(
                  
                  title: Text(
                    this.todoList[position].title,
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  subtitle: Text(
                    this.todoList[position].prueba,
                    
                  ),
                  

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          _delete(context, todoList[position]);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail(this.todoList[position], 'Edit Todo');
                  },
                ),
                
                new Container(
                margin: EdgeInsets.all(15),
                  child: Text(
                    (this.todoList[position].description),
                    softWrap: true,
                  ),
                ),
                new ListTile(
                  subtitle: Text(
                    this.todoList[position].date
                  ),
                ),
              ],
            ));
      },
    );
  }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}
