import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'pages/pageHome.dart';
import 'pages/pageSearch.dart';
import 'pages/pagelist.dart';
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
  final PageSearch _pageSearch = PageSearch();
  final PageList _pageList = PageList();
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget _showPage = new TodoList();
  Widget _pageChooser(int page){
    switch(page){
      
      case 0:
      return _pageHome;
      break;
      case 1:
      return _pageSearch;
      break;
      case 2:
      return _pageList;
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
      
        //debugShowCheckedModeBanner: false,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.list_alt_outlined, size: 30),
          ],
          color: Colors.grey,
          buttonBackgroundColor: Colors.grey,
          backgroundColor: Colors.white,
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