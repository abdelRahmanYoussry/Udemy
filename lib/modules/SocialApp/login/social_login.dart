import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/SocialAppModel/socialUserModel.dart';
import 'package:udemy_fluttter/modules/SocialApp/Layout/SocialLayout.dart';
import 'package:udemy_fluttter/modules/SocialApp/Register/SocialRegisterScreen.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialLoginCubit/cubit.dart';
import 'package:udemy_fluttter/modules/SocialApp/SocialLoginCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';

class SocialLogin extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControl=TextEditingController();
  var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialLoginCubit(SocialLoginInitialState),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if (state is SocialLoginErrorState)
          showToast(text: state.error, state: ToastState.Error);
          if (state is SocialLoginSuccessState)
          {
            CashHelper.saveData(
                key: 'uid',
                value:state.uid
            ).then((value) {
              print(state.uid+' this is uid');
              uid=state.uid;
              SocialCubit.get(context).getUserData();
              navigateAndFinish(context, SocialLayout());
            });
            print(uid!+' this is uid2');
          }
        },
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Login',
                              style: Theme.of(context).textTheme.headline2!.
                              copyWith(color: Colors.black
                              ),
                            ),
                            Text('Login now to Communicate with the World',
                              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.grey
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormText(
                                control: emailControl,
                                onTap: (){},
                                onChanged: (value){print(value);},
                                onSubmit: (){},
                                type: TextInputType.emailAddress,
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Email Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'Email',
                                prefix: Icons.email),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: passwordControl,
                                type: TextInputType.visiblePassword,
                                onTap: (){},
                                onChanged: (value){print(value);},
                                onSubmit: (value)
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailControl.text,
                                        password: passwordControl.text);
                                  }

                                },
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Password is to Short';
                                  else
                                    return null;
                                },
                                isPassword: SocialLoginCubit.get(context).isPassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: SocialLoginCubit.get(context).suffix,
                                suffixClicked: (){
                                  SocialLoginCubit.get(context).changePasswordVisibility();
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder:(context)=>defaultButton(
                                onTap: (){
                                  if(formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailControl.text,
                                        password: passwordControl.text);

                                    // if(uid!=SocialCubit.get(context).userModel!.uid){
                                    //   SocialLoginCubit.get(context).userLogin(
                                    //       email: emailControl.text,
                                    //       password: passwordControl.text);
                                    //
                                    // }
                                    // else
                                    //   SocialCubit.get(context).getUserData();
                                    // // SocialCubit.get(context).getPost();

                                  }
                                },
                                text: 'Login',),
                              fallback:(context)=>Center(child: CircularProgressIndicator()) ,

                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't Have an Account?",style: TextStyle(fontSize:15 ),),
                                defaultTextButton(
                                    onTap: (){navigateTo(context, SocialRegisterScreen());},
                                    text: 'Register')
                              ],),
                          ]),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
