import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/colors.dart';
import 'package:udemy_fluttter/styles/styles.dart';

class EditProfileScreen extends StatelessWidget {
var nameController=TextEditingController();
var bioController=TextEditingController();
var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var editProfileModel=SocialCubit.get(context).userModel;
        var editProfileImage=SocialCubit.get(context).profileImageFile;
        var editCoverImage=SocialCubit.get(context).coverImageFile;
        nameController.text=editProfileModel!.name!;
        bioController.text=editProfileModel.bio!;
        phoneController.text=editProfileModel.phone!;

        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: defaultAppBar(context: context,
                  title: 'Edit Profile',
                  actions:[
                    defaultTextButton(
                        onTap: (){
                          SocialCubit.get(context).updateUser(
                              name: nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text);
                        }, text: 'Update'),
                    SizedBox(
                      width: 15,
                    )
                  ]
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   if(state is SocialUpdateLoadingState)
                     LinearProgressIndicator(),
                   if(state is SocialUpdateLoadingState)
                   SizedBox(
                     height: 10,
                   ),
                 Container(
                 height: 200,
                 child: Stack(
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
                                 borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(5),
                                   topLeft: Radius.circular(5),
                                 ),
                                 image: DecorationImage(
                                     image:editCoverImage ==null ? NetworkImage(
                                         '${editProfileModel.coverImage}'
                                             ):FileImage(editCoverImage) as ImageProvider ,
                                     fit: BoxFit.cover
                                 )
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: CircleAvatar(
                                 radius: 20,
                                 child: IconButton(
                                 onPressed: (){
                                   SocialCubit.get(context).getCoverImage();
                                 },
                                 icon:Icon(IconBroken.Camera)
                             )
                             ),
                           )
                         ],
                       ),
                     ),
                     Stack(
                       alignment: AlignmentDirectional.bottomEnd,
                       children: [
                         CircleAvatar(
                           radius: 64,
                           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                           child: CircleAvatar(
                             radius: 60,
                             backgroundImage:editProfileImage == null ? NetworkImage(
                                 '${editProfileModel.image}'):FileImage(editProfileImage) as ImageProvider,
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: CircleAvatar(
                               radius: 16,
                               child: IconButton(
                               onPressed: (){
                                 SocialCubit.get(context).getProfileImage();
                               },
                               icon:Icon(IconBroken.Camera),
                                 iconSize: 16,
                           )

                           ),
                         )
                       ],
                     ),
                   ],
                 ),
               ),
                   if(SocialCubit.get(context).profileImageFile !=null ||SocialCubit.get(context).coverImageFile !=null)
                 Row(
                   children: [
                     if(SocialCubit.get(context).profileImageFile !=null)
                     Expanded(
                       child: InkWell(
                         onTap: (){
                           SocialCubit.get(context).uploadProfileImage(
                               name: nameController.text,
                               phone: phoneController.text,
                               bio: bioController.text);
                         },
                         child: Container(
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(IconBroken.Profile,
                                   color: Colors.white,
                                     size: 24,
                                   ),
                                   SizedBox(
                                     width: 5,
                                   ),
                                   Text('Upload Profile ',
                                   style: TextStyle(color: Colors.white,fontSize: 20),
                                   ),
                                 ],
                               ),
                               if(state is SocialUpdateLoadingState)
                               LinearProgressIndicator(),
                             ],
                           ),
                           decoration: BoxDecoration(
                               color: Colors.blue[400],
                             borderRadius: BorderRadius.all(Radius.circular(10))
                           ),
                         ),
                       ),
                     ),
                     SizedBox(
                       width: 8,
                     ),
                     if(SocialCubit.get(context).coverImageFile !=null)
                     Expanded(
                       child: InkWell(
                         onTap: (){
                           SocialCubit.get(context).uploadCoverImage(
                               name: nameController.text,
                               phone: phoneController.text,
                               bio: bioController.text
                           );
                         },
                         child: Container(
                           child: Column(
                             children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconBroken.Image,color: Colors.white,size: 24,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                   Text('Upload Cover',
                                     style: TextStyle(color: Colors.white,fontSize: 20),),
                                ],
                              ),
                               if(state is SocialUpdateLoadingState)
                               LinearProgressIndicator(),
                             ],
                           ),
                           decoration: BoxDecoration(
                               color: Colors.blue[400],
                               borderRadius: BorderRadius.all(Radius.circular(10))
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                   SizedBox(
                     height: 20,
                   ),
                   // if(SocialCubit.get(context).profileImageFile!=null||SocialCubit.get(context).coverImageFile!=null)
                   // Row(children: [
                   //     if(SocialCubit.get(context).profileImageFile!=null)
                   //   Expanded(
                   //     child: Column(
                   //       children: [
                   //         defaultButton(
                   //           isUpperCase: false,
                   //             onTap: (){},
                   //             text: 'Upload Profile',
                   //         ),
                   //         SizedBox(
                   //           height: 5,
                   //         ),
                   //         LinearProgressIndicator(),
                   //       ],
                   //     ),
                   //   ),
                   //   SizedBox(
                   //     width: 5,
                   //   ),
                   //   if(SocialCubit.get(context).coverImageFile!=null)
                   //   Expanded(
                   //     child: Column(
                   //       children: [
                   //         defaultButton(
                   //           isUpperCase: false,
                   //             onTap: (){},
                   //             text: 'Upload Cover',),
                   //         SizedBox(
                   //           height: 5,
                   //         ),
                   //         LinearProgressIndicator(),
                   //       ],
                   //     ),
                   //   ),
                   // ],),
                   // SizedBox(
                   //   height: 10,
                   // ),
                 defaultFormText(
                     control: nameController,
                     type: TextInputType.name,
                     validator: ( value)
                     {
                       if(value.isEmpty)
                         return 'Name Can\nt be Empty' ;
                       return null;
                     },
                     label: 'Edit Name',
                     prefix: IconBroken.User),
                   SizedBox(
                     height: 10,
                   ),
                   defaultFormText(
                       control: bioController,
                       type: TextInputType.text,
                       validator: ( value)
                       {
                         if(value.isEmpty)
                           return 'Bio Can\nt be Empty' ;
                         return null;

                       },
                       label: 'Edit Bio',
                       prefix: IconBroken.Info_Square),
                   SizedBox(
                     height: 10,
                   ),
                   defaultFormText(
                       control: phoneController,
                       type: TextInputType.phone,
                       validator: ( value)
                       {
                         if(value.isEmpty)
                           return 'Phone Number Can\nt be Empty' ;
                         return null;

                       },
                       label: 'Edit Phone',
                       prefix: IconBroken.Call),
                 ],
               ),
           ),
            )
        );
      },
    );
  }
}
