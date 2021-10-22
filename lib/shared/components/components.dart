import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:udemy_fluttter/modules/webview/web_view.dart';
import 'package:udemy_fluttter/shared/todo_cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() function,
  required String text,
}) => Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function()? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (value) {
        onChanged!(value);
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixClicked!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          border: OutlineInputBorder()),
    );
Widget buildTasksItems(Map model,context) => Dismissible(
  key: Key(model['id'].toString())  ,
  child:Padding(padding: const EdgeInsets.all(20.0),
        child: Row(

          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: (){
                  TodoCubit.get(context).updateData(status: 'done', id:model['id'] );
                },
                icon:Icon(Icons.check_box,color: Colors.green,) ),
            IconButton(
                onPressed: (){
                  TodoCubit.get(context).updateData(status: 'archive', id:model['id'] );
                },
                icon:Icon(Icons.archive,color: Colors.black45,) ),
          ],
        ),
      ),
  onDismissed:(direction) {
  TodoCubit.get(context).deleteData(id: model['id']);
  },
);
Widget tasksEmptyBuilder({required List<Map>tasks})=>ConditionalBuilder(
    condition:tasks.length>0,
    builder: (context)=>ListView.separated(
        itemBuilder: (context,index)=>buildTasksItems(tasks[index],context),
        separatorBuilder: (context,index)=>dividerWidget(),
        itemCount:tasks.length),
    fallback: (context)=>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet Please add Some Tasks',
            style:TextStyle(
                fontSize:16,
                fontWeight: FontWeight.bold) ,)
        ],
      ),
    )
);
Widget buildArticleItems(article,context)=>InkWell (
  onTap: (){
    navigateTo(context, WebViewScreen(url: article['url'],));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: article['urlToImage'] !=null
              ?DecorationImage(
                image:NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover)
                  : DecorationImage(image:
              NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
          )
          )
        ),
          SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget articleBuilder(businessList,context,{required int itemCount,isSearch=false})=>
    ConditionalBuilder(
  condition: businessList.length>0,
  builder: (context)=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItems(businessList[index],context),
      separatorBuilder:(context ,index)=>dividerWidget() ,
      itemCount:itemCount),
  fallback: (context)=>isSearch?Container():Center(child: CircularProgressIndicator()),
);
Widget dividerWidget()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);
void navigateTo(context,Widget){
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=> Widget
      ));
}