import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/SocialAppModel/chatModel.dart';
import 'package:udemy_fluttter/models/SocialAppModel/socialUserModel.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/styles/styles.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  var  chatControl=TextEditingController();
   ChatDetailsScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uid!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '${userModel.image}'       ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${userModel.name}')
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messageModelList.length>0,
                fallback: (context)=>Center(child: CircularProgressIndicator()),
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context,index){
                                var messages=SocialCubit.get(context).messageModelList[index];
                                if(SocialCubit.get(context).userModel!.uid==messages.senderID)
                                  return sendMessageItemBuilder(context,messages);
                                return receivedMessageItemBuilder(context,messages);
                              },
                              separatorBuilder: (context,index)=>SizedBox(height: 10,),
                              itemCount: SocialCubit.get(context).messageModelList.length),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if(SocialCubit.get(context).messageImageFile!=null)
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(SocialCubit.get(context).messageImageFile!) ,

                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                        radius: 20,
                                        child: IconButton(
                                            onPressed: (){
                                              SocialCubit.get(context).removeMessageImage();
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
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: chatControl,
                              onFieldSubmitted: (value){
                                if(SocialCubit.get(context).messageImageFile!=null)
                                  SocialCubit.get(context).uploadMessageImage(
                                      dateTime: DateTime.now().toLocal().toString(),
                                      text: chatControl.text,
                                      receiverId: userModel.uid!);
                                else
                                SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uid!,
                                    chatText: chatControl.text,
                                    dataTime: DateTime.now().toLocal().toString());
                                chatControl.clear();
                              },
                              decoration:InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: (){
                                     SocialCubit.get(context).getMessageImage();
                                  },
                                  icon: Icon(IconBroken.Image,),

                                ),
                                  hintText: 'Type your message here...',
                                  hintStyle: Theme.of(context).textTheme.caption,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(20),
                                        left: Radius.circular(20),
                                      )
                                  )
                              ) ,
                              style:TextStyle(
                              ) ,
                            ),

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: IconButton(
                                color: Colors.white,
                                icon: Icon(IconBroken.Send),
                                iconSize: 30,
                                onPressed: () {
                                  if(SocialCubit.get(context).messageImageFile!=null)
                                    {
                                      SocialCubit.get(context).uploadMessageImage(
                                          dateTime: DateTime.now().toLocal().toString(),
                                          text: chatControl.text,
                                          receiverId: userModel.uid!);
                                    }

                                  else{
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: userModel.uid!,
                                        chatText: chatControl.text,
                                        dataTime: DateTime.now().toLocal().toString());
                                  }
                                  SocialCubit.get(context).messageImageFile=null;
                                  },

                          ),
                          )],
                      )

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget sendMessageItemBuilder(context,MessagesChatModel model)=>Align(
    alignment: AlignmentDirectional.topEnd,
    child: Column(
      children: [
        if(model.text!='')
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5
            ),
            decoration: BoxDecoration(
                color: Colors.lightBlue[200],
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                )
            ),
            child: Text(model.text!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20),
            )),
        if(model.image!=null&&model.image!='')
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            image:DecorationImage(
              image: NetworkImage(model.image!),
              fit: BoxFit.cover
            )
          ),
        ),

      ],
    ),
  );
  
  Widget receivedMessageItemBuilder(context,MessagesChatModel model)=>Align(
    alignment: AlignmentDirectional.topStart,
    child: Column(
      children: [
        if(model.text!='')
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                )
            ),
            child: Text(model.text!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20),
            )),
        if(model.image!=null&&model.image!='')
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              image:DecorationImage(
                  image: NetworkImage(model.image!),
                  fit: BoxFit.cover
              )
          ),
        ),
      ],
    ),
  );
}
