import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:udemy_fluttter/modules/ShopApp/Layout/ShopLayout.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopLoginCubit/cubit.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopLoginCubit/state.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';

import '../Register/ShopRegisterScreen.dart';

class ShopLoginScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var emailControl=TextEditingController();
var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(ShopLoginInitialState),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state){
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status==true)
              {
                print(state.loginModel.message);
                print(state.loginModel.data!.token);
               CashHelper.saveData(
                   key: 'token',
                   value:state.loginModel.data!.token
               ).then((value) {
                  token=state.loginModel.data!.token!;
                 showToast(text:(state.loginModel.message)! , state: ToastState.Success);
                 navigateAndFinish(context, ShopLayoutScreen());
               });
              }
             else
                {
                  showToast(text: (state.loginModel.message)!,
                      state: ToastState.Error);
                  print(state.loginModel.message.toString()+'this is login error');

                }
            }

        } ,
        builder:(context,state){
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
                            Text('Login now to Browse to Our Cool App',
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
                                    ShopLoginCubit.get(context).userLogin(
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
                                isPassword: ShopLoginCubit.get(context).isPassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: ShopLoginCubit.get(context).suffix,
                                suffixClicked: (){
                                  ShopLoginCubit.get(context).changePasswordVisibility();
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder:(context)=>defaultButton(
                                onTap: (){
                                   if(formKey.currentState!.validate())
                                   {
                                     ShopLoginCubit.get(context).userLogin(
                                         email: emailControl.text,
                                         password: passwordControl.text);
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
                                    onTap: (){navigateTo(context, ShopRegisterScreen());},
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
