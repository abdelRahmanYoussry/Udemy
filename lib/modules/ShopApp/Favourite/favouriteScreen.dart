import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/ShopAppModel/favouritesModel.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopCubit.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopState.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/colors.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavouritesState,
             builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildProductItems(ShopCubit.get(context).favouritesModel!.data!.data[index].product, context),
                    separatorBuilder: (context, index) => dividerWidget(),
                    itemCount: ShopCubit.get(context).favouritesModel!.data!.data.length),
                   fallback: (context) => Center(child: CircularProgressIndicator()
                ),
          );
        });
  }



}