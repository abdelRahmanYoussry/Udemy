
import 'package:udemy_fluttter/models/ShopAppModel/loginModel.dart';

abstract class ShopRegisterStates{
}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterPasswordVisibility extends ShopRegisterStates{}