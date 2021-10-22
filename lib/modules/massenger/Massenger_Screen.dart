import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0.00,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://scontent.fcai20-6.fna.fbcdn.net/v/t1.6435-9/64740059_10217163728877610_4626933787983347712_n.jpg?_nc_cat=110&ccb=1-4&_nc_sid=09cbfe&_nc_ohc=7-4_0KT3-E0AX9C23Kt&_nc_ht=scontent.fcai20-6.fna&oh=650773de55b780cdd93931729b738e43&oe=613B9112"),
              radius: 20.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "Chats",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              )),
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              ))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: EdgeInsetsDirectional.all(5.0),
                decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(5.0),
                color: Colors.grey[300]
              ) ,

                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10,),
                    Text("Search",style: TextStyle(fontSize: 16.0),),
                  ],
                ),
              ),//search
              SizedBox(height: 20,),
             Container(height: 100,
               child: ListView.separated(
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context,index)=> buildStoryItems(),
                 separatorBuilder: (context,index)=>SizedBox(width:
                 20,),itemCount: 8
               ),
             )
              ,SizedBox(height: 20,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:(context,index) =>buildChatItems()
                  , separatorBuilder: (context,index) =>SizedBox(height: 20,)
                  , itemCount:15 )
          ]),
        ),
      ),
    );
  }
  Widget buildChatItems()=>Row(children: [
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://scontent.fcai20-6.fna.fbcdn.net/v/t1.6435-9/64740059_10217163728877610_4626933787983347712_n.jpg?_nc_cat=110&ccb=1-4&_nc_sid=09cbfe&_nc_ohc=7-4_0KT3-E0AX9C23Kt&_nc_ht=scontent.fcai20-6.fna&oh=650773de55b780cdd93931729b738e43&oe=613B9112"),
          radius: 30.0,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 3.0,bottom: 3.0),
          child: CircleAvatar(radius: 7,backgroundColor: Colors.red,),
        )
      ],
    ),
    SizedBox(width: 10,),
    Expanded(

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Abdelrahman Youssry moahmmed elsaid morssy",maxLines: 1,overflow:
            TextOverflow.ellipsis,style: TextStyle(fontSize: 22,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(child: Text("Hello Abdo how are you now are you ok ?"
                  ,maxLines: 2,overflow: TextOverflow.ellipsis,)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(width: 7,height: 7,decoration: BoxDecoration(
                      color: Colors.blue,shape: BoxShape.circle)
                  ),
                ), Text("02:00 pm")],
            ),
          ]),
    ),

  ]);
  Widget buildStoryItems()=>Container(
    width:60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://scontent.fcai20-6.fna.fbcdn.net/v/t1.6435-9/64740059_10217163728877610_4626933787983347712_n.jpg?_nc_cat=110&ccb=1-4&_nc_sid=09cbfe&_nc_ohc=7-4_0KT3-E0AX9C23Kt&_nc_ht=scontent.fcai20-6.fna&oh=650773de55b780cdd93931729b738e43&oe=613B9112"),
              radius: 30.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 3.0,bottom: 3.0),
              child: CircleAvatar(radius: 7,backgroundColor: Colors.red,),
            )
          ],
        ),
        SizedBox(height: 6,),
        Text("Abdelrahman Youssry mohammed",
          maxLines: 2,overflow: TextOverflow.ellipsis,
         ),
      ],

    ),
  );

  }

