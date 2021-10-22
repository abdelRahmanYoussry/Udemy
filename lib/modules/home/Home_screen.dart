import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.list), title: Text("Hello"), actions: [
        IconButton(
            onPressed: () {
              print("search");
            },
            icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              print("menu");
            },
            icon: Icon(Icons.menu))
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20.0))),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        "https://www.zyadda.com/wp-content/uploads/2020/10/maxresdefault-5-2-1130x580.jpg"),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    width: 200,
                    color: Colors.amber.withOpacity(0.4),
                    child: Text(
                      "basBosa",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
