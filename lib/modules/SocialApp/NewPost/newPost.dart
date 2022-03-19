import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/styles.dart';

class NewPostScreen extends StatelessWidget {
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: defaultAppBar(
                context: context,
                title: 'Create Post',
                actions: [
                  defaultTextButton(
                      onTap: () {
                        var now=DateTime.now();
                        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm'). format(now);

                        if(SocialCubit.get(context).postImageFile==null)
                        {
                          SocialCubit.get(context).createPost(
                              dateTime: formattedDate,
                              text: textController.text);

                        }else{
                          SocialCubit.get(context).uploadPostImage(
                              dateTime: now.toString(),
                              text: textController.text);
                        }
                      },
                      text: 'Post')
                ]
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/cheerful-attractive-dark-skinned-young-girlfriend-points-you-has-joyful-look-camera_273609-18411.jpg'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      'Abdelrahman Youssry',
                      style: TextStyle(
                          height: 1.4
                      ),
                    ),
                  ),
                ],),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'What is in Your Mind...........',
                        border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImageFile!=null)
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                                  ),
                                  image: DecorationImage(
                                      image: FileImage(SocialCubit.get(context).postImageFile!) ,

                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                      onPressed: (){
                                        SocialCubit.get(context).removePostImage();
                                      },
                                      icon:Icon(Icons.close)
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Icon(
                            IconBroken.Image
                          ),
                           SizedBox(
                             width: 5,
                           ),
                           Text('Add Photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:  Text('# Tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
