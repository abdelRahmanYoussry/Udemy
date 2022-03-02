import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/SocialApp/EditProfile/edit_Profile_Screen.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var profileModel=SocialCubit.get(context).userModel;
        return  Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                            ),
                            image: DecorationImage(
                                image:NetworkImage('${profileModel!.coverImage}'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:NetworkImage('${profileModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${profileModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text('${profileModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20     ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('100',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text('Post',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('265',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text('Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('10k',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text('Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('53',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text('Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: OutlinedButton(
                     onPressed: () {  },
                    child: Text('Add Photos'),)),
                  OutlinedButton(
                      onPressed: (){
                        navigateTo(context,EditProfileScreen() );
                      },
                      child: Icon(IconBroken.Edit,size: 16,))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
