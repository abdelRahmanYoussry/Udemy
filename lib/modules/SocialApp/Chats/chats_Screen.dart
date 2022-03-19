import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/SocialAppModel/socialUserModel.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';

import '../../../shared/components/components.dart';
import '../ChatDetails/chatDetailsScreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).socialUserModel.length>0 ,
          builder:(context)=>ListView.separated(
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).socialUserModel[index],context),
              separatorBuilder: (context,index)=>dividerWidget(),
              itemCount: SocialCubit.get(context).socialUserModel.length),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('${model.image}'),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
              height: 1.4
          ),
        ),
      ],),
    ),
  );
}
