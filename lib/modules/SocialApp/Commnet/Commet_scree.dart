
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/styles/colors.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Comments'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
         body:ConditionalBuilder(
           condition:SocialCubit.get(context).commentModelList.length>0 ,
           builder:(context)=>ListView.separated(
               itemBuilder: (context,index)=>buildCommentList(SocialCubit.get(context).commentModelList[index], context,index),
               separatorBuilder:  (context,index)=>SizedBox(
                 height: 5,
               ),
               itemCount:  SocialCubit.get(context).commentModelList.length)
           ,
           fallback:(context)=>Center(child: CircularProgressIndicator(),) ,
         ) ,
        );
      },
    );
  }

  Widget buildCommentList(cmodel,context,index) {
    //print(SocialCubit.get(context).commentModelList.length);
    return Container(
     // height: MediaQuery.of(context).size.height/2,
      child: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [
                Container(
                  color: Colors.amber,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage:NetworkImage('${cmodel.image}'),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${cmodel.name}',
                            style: TextStyle(
                                height: 1.4
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                          '${cmodel.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4
                          )
                      ),
                      Text('${cmodel.text}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: (Icon(Icons.more_vert)),
                  onPressed: (){},
                ),
                // Text(model.text!,
                //   style: Theme.of(context).textTheme.subtitle1,
                // ),

              ],),
            ],
          ),
        ),
      ),
    );

  }
}
