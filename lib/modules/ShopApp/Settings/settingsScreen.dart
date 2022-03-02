import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopCubit.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopState.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocConsumer<ShopCubit,ShopState>(
      listener:(context,state){
        if(state is ShopSuccessUpdateDataState){
          showToast(text: 'User Information Updated Successfully ',
              state: ToastState.Success
          );
        }
        if(state is ShopErrorUpdateDataState){
          showToast(text: 'User Information don\'t Updated',
              state: ToastState.Success
          );
        }
      } ,
      builder:(context,state){
        var model=ShopCubit.get(context).userData;
        if(model !=null){
          nameController.text=model.data!.name !;
          phoneController.text=model.data!.phone!;
          emailController.text=model.data!.email!;
         print(nameController.text+' new one 2');
        }
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData !=null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateDataState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20,),
                  defaultFormText(
                      onTap: (){},
                      onChanged: (value){print(value);},
                      onSubmit: (){},
                      control: nameController,
                      type: TextInputType.name,
                      validator: ( value){
                        if(value.isEmpty)
                        {
                          return 'Name Cant be Empty';
                        }else return null;

                      },
                      label: 'Name',
                      prefix: Icons.person
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormText(
                      onTap: (){},
                      onChanged: (){},
                      control: emailController,
                      type: TextInputType.emailAddress,
                      validator: ( value){
                        if(value.isEmpty)
                        {
                          return 'emailAddress Cant be Empty';
                        }else return null;

                      },
                      label: 'Email',
                      prefix: Icons.email
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormText(
                      onTap: (){},
                      onChanged: (){},
                      control: phoneController,
                      type: TextInputType.phone,
                      validator: ( value){
                        if(value.isEmpty)
                        {
                          return 'phone Cant be Empty';
                        }else return null;

                      },
                      label: 'phone',
                      prefix: Icons.phone
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(onTap: ()
                  {
                    if(formKey.currentState!.validate())
                    {
                      ShopCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                      );
                      print(nameController.text+' new one');
                    }
                  },
                  text: 'Update'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(onTap: (){
                    signOut(context);
                  }, text: 'Logout'),

                ],
              ),
            ),
          ),
         fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }
}
 