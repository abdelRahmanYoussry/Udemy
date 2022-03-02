
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/models/ShopAppModel/categoriesModel.dart';
import 'package:udemy_fluttter/models/ShopAppModel/homeModel.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopCubit.dart';
import 'package:udemy_fluttter/modules/ShopApp/ShopCubit/shopState.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state)
      {
        if(state is ShopSuccessFavouritesState)
        {
          if(!state.model.status)
          {
          showToast(text: state.model.message, state: ToastState.Error);

          }
          else{
            showToast(text: state.model.message, state: ToastState.Success);
          }
        }
      },
        builder:  (context,state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel !=null&&ShopCubit.get(context).categoriesModel !=null,
            builder: (context)=>productBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
            fallback:(context)=> Center(child: CircularProgressIndicator())
        );
        }, );

  }

  Widget productBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics:BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           CarouselSlider(
               items:model.data.banners.map((e) => Image(image: NetworkImage('${e.image}'),
                 width: double.infinity,
                 fit: BoxFit.cover,
               )).toList() ,
               options: CarouselOptions(
                 height: 250,
                 autoPlay: true,
                 autoPlayAnimationDuration: (Duration(seconds: 2)),
                 reverse: false,
                 initialPage: 0,
                 autoPlayCurve: Curves.fastOutSlowIn,
                 scrollDirection: Axis.horizontal,
                 autoPlayInterval: Duration(seconds: 5),
                 viewportFraction: 1,
               ),
           ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>categoriesList(categoriesModel.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10,),
                    itemCount: categoriesModel.data.data.length),
              ),
              SizedBox(
                height: 10,
              ),
              Text('New Product',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
             crossAxisSpacing: 1,
             mainAxisSpacing: 1,
            childAspectRatio: 1/1.6,
            children: List.generate(model.data.products.length, (index) =>productGridView(model.data.products[index],context), ),

            ),
        ),
      ],
    ),
  );

  Widget categoriesList(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(
        '${model.image}',
      ),
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          model.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      )
    ],
  );

  Widget productGridView(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration:BoxDecoration(image:model.image!=null?
          DecorationImage(image: NetworkImage('${model.image}'),
          )
              : DecorationImage(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
          )
          )
          ),
            if(model.discount !=0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: Text('Discount',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white
              ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
              maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text('${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount !=0)
                  Text('${model.oldPrice}',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      decoration:TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),

                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavourites(model.id);
                     // print(model.id);
                    },
                      icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favourite[model.id]! ?defaultColor:Colors.grey,
                        radius: 15,
                          child: Icon(Icons.favorite_border,
                            color: Colors.white,
                            size: 14,
                          )
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
