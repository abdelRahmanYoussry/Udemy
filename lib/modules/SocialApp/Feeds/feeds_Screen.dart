import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_fluttter/models/SocialAppModel/PostModel.dart';
import 'package:udemy_fluttter/modules/SocialApp/Commnet/Commet_scree.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/colors.dart';
import 'package:udemy_fluttter/styles/styles.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {

    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition: SocialCubit.get(context).postList.length>0&& SocialCubit.get(context).userModel!=null,
       fallback:(context)=>Center(child: CircularProgressIndicator()) ,
      builder:(context)=> SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
               Card(
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5.0,
                 margin: EdgeInsets.all(8),
                 child: Stack(
                   alignment:AlignmentDirectional.topStart,
                   children: [
                     Image(image: NetworkImage('https://img.freepik.com/free-vector/colorful-icons-collection_79603-1270.jpg?w=996'),
                       height: 250,
                       width: double.infinity,
                       fit: BoxFit.cover,
                     ),
                    Text(
                      'Communicate With Friends',
                    style: Theme.of(context).textTheme.subtitle1!.
                    copyWith(color: Colors.white),
                    ),
                   ],
                 ),
               ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index)=>buildPostItem(context,SocialCubit.get(context).postList[index],index,
                    // SocialCubit.get(context).commentModel!
                ),
                separatorBuilder: (context,index)=>SizedBox(
                  height: 5,
                ),
                itemCount: SocialCubit.get(context).postList.length
            ),
             SizedBox(
              height: 8,
            )
          ],
        ),
      ),

    );
  },
);
  }

  Widget buildPostItem(context,PostModel model,index,) {
    if(model.dateTime!=null){
      DateTime now = DateTime. now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm'). format(now);
    }
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
            horizontal:8 ),
        child:Padding(
          padding: const EdgeInsets.all(
              10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:NetworkImage('${model.image}'),
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
                            '${model.name}',
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
                      //   if(model.dateTime!=null){
                      // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm'). format(now);
                      //   }

                      Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4
                          )
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
                )
              ],),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
              ),
              Text('${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // //##
              // Container(
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsetsDirectional.only(
              //             end:6),
              //         child: Container(
              //           height: 25,
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1,
              //             onPressed:(){},
              //             child: Text(
              //                 '#Software',
              //                 style: Theme.of(context).textTheme.caption!.copyWith(
              //                     color: defaultColor
              //                 )
              //             ),
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsetsDirectional.only(
              //             end:6 ),
              //         child: Container(
              //           height: 25,
              //           child: MaterialButton(
              //             padding: EdgeInsets.zero,
              //             minWidth: 1,
              //             onPressed:(){},
              //             child: Text(
              //                 '#Software',
              //                 style: Theme.of(context).textTheme.caption!.copyWith(
              //                     color: defaultColor
              //                 )
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //     ],
              //   ),
              // ),
              if(model.postImage!="")
              Padding(
                  padding: const EdgeInsets.only(
                      top: 10),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            image:NetworkImage('${model.postImage}'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5.0),
                child: Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(IconBroken.Heart,
                              color: Colors.red,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likesCountList[index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        SocialCubit.get(context).getComments(
                            SocialCubit.get(context).postId[index]);
                        navigateTo(context, CommentScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(IconBroken.Chat,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              //'${SocialCubit.get(context).commentList[index]} '
                              '${SocialCubit.get(context).commentCountList[index]}',
                              // '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              IconBroken.Heart
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              'Like')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        SocialCubit.get(context).getComments(
                            SocialCubit.get(context).postId[index]);
                        navigateTo(context, CommentScreen());
                      },
                      child:  Row(
                        children: [
                          Icon(
                              IconBroken.Chat
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Comment')
                        ],

                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: (){},
                      child:  Row(
                        children: [
                          Icon(
                            IconBroken.Send,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Share')
                        ],

                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        )
    );
  }
  }



