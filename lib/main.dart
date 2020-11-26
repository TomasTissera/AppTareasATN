import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'Screens/todo_list.dart';
void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  
}
//funco

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;
  final TodoList _pageHome = TodoList();
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget _showPage = new TodoList();
  Widget _pageChooser(int page){
    switch(page){
      
      case 0:
      return _pageHome;
      break;
      default:
      return new Container(
        child: new Center(
          child : new Text(
            "No selecciono ninguna pag"
          )
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
    home : Scaffold(
      
        
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 50.0,
          items: <Widget>[
            Icon(
              Icons.home, size: 30,
              
            ),
          ],
          color: Colors.blueAccent,
          buttonBackgroundColor: Colors.blueAccent,
          backgroundColor: Colors.transparent,
          
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _showPage,
          ),
        )),);
  }
}