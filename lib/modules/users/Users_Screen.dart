import 'package:flutter/material.dart';
import 'package:udemy_fluttter/models/users%20model.dart';
class UsersScreen extends StatelessWidget {
  List<UserModel>model=[
    UserModel(id: 1,name:
    "Abdelrahman Youssry",phone: "01282088582"),
    UserModel(id: 2,
        name: "Yunes Abdelrahman Youssry",phone: "035636639"),
    UserModel(id: 3
        ,name: "Ftama Abdelfatha",phone: "01026333941"),
    UserModel(id: 4,
        name: "Abdelrahman Youssry",phone: "01282088582"),
    UserModel(id: 5
        ,name: "Yunes Abdelrahman Youssry",phone: "035636639"),
    UserModel(id: 6
        ,name: "Ftama Abdelfatha",phone: "01026333941"),
    UserModel(id: 1,name:
    "Abdelrahman Youssry",phone: "01282088582"),
    UserModel(id: 2,
        name: "Yunes Abdelrahman Youssry",phone: "035636639"),
    UserModel(id: 3
        ,name: "Ftama Abdelfatha",phone: "01026333941"),
    UserModel(id: 4,
        name: "Abdelrahman Youssry",phone: "01282088582"),
    UserModel(id: 5
        ,name: "Yunes Abdelrahman Youssry",phone: "035636639"),
    UserModel(id: 6
        ,name: "Ftama Abdelfatha",phone: "01026333941"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.separated(
          itemBuilder:(context,index)=>buildList(model[index])
          , separatorBuilder:(context,index)=>Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],),
        itemCount: model.length)
    );
  }
  Widget buildList(UserModel user)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
  children: [
  CircleAvatar(
  radius: 25.0,
  child: Text('${user.id}',
  style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
  ),
  ),
  SizedBox(width: 25,),
  Expanded(
    child: Column(mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('${user.name}',
      overflow: TextOverflow.ellipsis,maxLines: 1,
    style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
    ),
    Text( '${user.phone}',
    style: TextStyle(fontSize: 25.0,color: Colors.grey),
    ),],
    ),
  )
  ],
  ),
  );
}
