
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        var commentController=TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: Text('Comments'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pop(context);
                SocialCubit.get(context).getPost();
              },
            ),
          ),
         body:Column(
           // mainAxisSize: MainAxisSize.min,
           children: [
             Expanded(
               child: ConditionalBuilder(
                 condition:SocialCubit.get(context).commentModelList.length>0 ,
                 builder:(context)=>ListView.separated(
                     shrinkWrap: true,
                     scrollDirection: Axis.vertical,
                     physics: BouncingScrollPhysics(),
                     itemBuilder: (context,index)=>buildCommentList(SocialCubit.get(context).commentModelList[index], context,index),
                     separatorBuilder:  (context,index)=>SizedBox(
                       height: 5,
                     ),
                     itemCount:  SocialCubit.get(context).commentModelList.length),
                 fallback:(context)=>Center(child: CircularProgressIndicator(),) ,
               ),
             ),
             Expanded(
               child: Container(
                 padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                 child: TextFormField(
                   autofocus: true,
                   controller: commentController,
                   decoration:InputDecoration(
                       focusedBorder:OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                           borderSide: BorderSide(
                               color: Colors.blue,
                               width: 2
                           )
                       ) ,
                       hintText: 'Write a Comment',
                       hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                       )
                   ) ,
                   onFieldSubmitted: (value){
                     DateTime now = DateTime. now();
                     String formattedDate = DateFormat('yyyy-MM-dd – kk:mm'). format(now);
                     // SocialGetCommentPostsSuccessState(SocialCubit.get(context).newPostId.toString());
                     print( SocialCubit.get(context).newPostId.toString()+' nnew  post id  ');
                     SocialCubit.get(context).createComment(
                         comment: commentController.text,
                         dataTime:formattedDate.toString(),
                         postId: SocialCubit.get(context).newPostId.toString());
                     print(commentController.text+'this is value');
                     FocusScope.of(context).unfocus();
                      commentController.clear();
                   },
                 ),
               ),
             ),
           ],
         )
        );
      },
    );
  }

  Widget buildCommentList(cmodel,context,index) {
    //print(SocialCubit.get(context).commentModelList.length);
    return Container(
     // height: MediaQuery.of(context).size.height/2,
      child: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [
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
            ],
          ),

  ]),
      ),
    ));

  }
}
