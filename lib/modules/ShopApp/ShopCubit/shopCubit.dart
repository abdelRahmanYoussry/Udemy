import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/ShopAppModel/categoriesModel.dart';
import 'package:udemy_fluttter/models/ShopAppModel/changeFavouritesModel.dart';
import 'package:udemy_fluttter/models/ShopAppModel/favouritesModel.dart';
import 'package:udemy_fluttter/models/ShopAppModel/homeModel.dart';
import 'package:udemy_fluttter/models/ShopAppModel/loginModel.dart';
import 'package:udemy_fluttter/modules/SettingsScreen/Settings_screen.dart';
import 'package:udemy_fluttter/modules/ShopApp/Category/categoryScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/Favourite/favouriteScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/Product/productScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/Settings/settingsScreen.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopState.dart';
import 'package:udemy_fluttter/shared/components/constans.dart';
import 'package:udemy_fluttter/shared/network/EndPoints.dart';
import 'package:udemy_fluttter/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(ShopState initialState) : super(initialState);

  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
List<Widget> bottomScreens=[
  ProductScreen(),
  CategoryScreen(),
  FavouriteScreen(),
  SettingsScreen(),
];

void changeNavBar(int index){
currentIndex=index;
emit(ChangeNavBar());
}

HomeModel? homeModel;

Map<int,bool>favourite= {};
void getHomeData(){
  emit(ShopLoadingDataState());
  DioHelper.getData(
      path: Home,
      token: token).then((value) {
    homeModel=HomeModel.fromJson(value.data);
    homeModel!.data.products.forEach((element) {
      favourite.addAll({element.id:element.favorites});
    });
    // printFullText(homeModel!.data.banners.toString());
    // print(homeModel!.status);
    // print(favourite);

    emit(ShopSuccessHomeDataState());
  }).
  catchError((error)
  {
    emit(ShopErrorHomeDataState());
    print(error.toString());
  });
}


  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
        path: Get_Categories,
        token: token).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).
    catchError((error)
    {
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId)
  {
    favourite[productId] = !favourite[productId]!;
    emit( ShopChangeFavouritesState());
    DioHelper.postData(
        url: Favorites,
        data:{
          'product_id':productId
        } ,
        token: token
    ).then((value) {
      changeFavouritesModel=ChangeFavouritesModel.fromJason(value.data);
      if(!changeFavouritesModel!.status){
        favourite[productId] = !favourite[productId]!;
      }else{
        getFavouriteData();
      }
     emit( ShopSuccessFavouritesState(changeFavouritesModel!));
    }).catchError((error){
      favourite[productId] = !favourite[productId]!;
      ShopErrorFavouritesState();
    });
  }

  FavouritesModel? favouritesModel;
  void getFavouriteData(){
    DioHelper.getData(
        path: Favorites,
        token: token).then((value) {
        emit(ShopLoadingGetFavouritesState());
      favouritesModel=FavouritesModel.fromJson(value.data);
    //  printFullText(value.data.toString());
      emit(ShopSuccessGetFavouritesState());
    }).
    catchError((error)
    {
      emit(ShopErrorGetFavouritesState());
      print(error.toString());
    });
  }

   ShopLoginModel? userData;
  void getUserData(){
    DioHelper.getData(
        path: Profile,
        token: token).then((value) {
      emit(ShopLoadingUserDataState());
      userData=ShopLoginModel.formJson(value.data);
        printFullText((userData!.data!.name)!);
      emit(ShopSuccessUserDataState(userData!));
    }).
    catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());

    });
  }

  void updateUserData({
  required String name,
  required String phone,
  required String email,

}){
    DioHelper.putData(
        url: updateProfile,
        token: token,
        data: {
          'name':name,
          'phone':phone,
          'email':email
        }).then((value) {
      emit(ShopLoadingUpdateDataState());
      userData=ShopLoginModel.formJson(value.data);
      emit(ShopSuccessUpdateDataState(userData!));
      print('update is ok');
    }).
    catchError((error)
    {
      emit(ShopErrorUpdateDataState());
      print(error.toString());
    });
  }
}