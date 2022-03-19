import 'package:udemy_fluttter/models/ShopAppModel/changeFavouritesModel.dart';
import 'package:udemy_fluttter/models/ShopAppModel/loginModel.dart';

abstract class ShopState{}

class ShopInitialState extends ShopState{}

class ChangeNavBar extends ShopState{}

class ShopLoadingDataState extends ShopState{}

class ShopSuccessHomeDataState extends ShopState{}

class ShopErrorHomeDataState extends ShopState{}

class ShopSuccessCategoriesState extends ShopState{}

class ShopErrorCategoriesState extends ShopState{}

class ShopSuccessGetFavouritesState extends ShopState{}

class ShopLoadingGetFavouritesState extends ShopState{}

class ShopErrorGetFavouritesState extends ShopState{}


class ShopChangeFavouritesState extends ShopState{}

class ShopSuccessFavouritesState extends ShopState
{
  final ChangeFavoritesModel model;
  ShopSuccessFavouritesState(this.model);
}

class ShopErrorFavouritesState extends ShopState{}

class ShopSuccessUserDataState extends ShopState{
  ShopLoginModel model;
  ShopSuccessUserDataState(this.model);
}

class ShopLoadingUserDataState extends ShopState{}

class ShopErrorUserDataState extends ShopState{}

class ShopSuccessUpdateDataState extends ShopState{
  ShopLoginModel model;
  ShopSuccessUpdateDataState(this.model);
}

class ShopLoadingUpdateDataState extends ShopState{}

class ShopErrorUpdateDataState extends ShopState{}