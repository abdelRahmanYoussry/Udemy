
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_cubit.dart';
import 'package:udemy_fluttter/shared/news_cubit/news_state.dart';
class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
         var list=NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormText(
                    control: searchController,
                    type: TextInputType.text,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return "Search Can't be Empty";
                      }
                      else{
                        return null;
                      }
                    },
                    onTap: (){
                      print(searchController.toString());
                    },
                    onChanged: (value)
                    {

                      NewsCubit.get(context).getSearch(value);
                    },
                     onSubmit: (s){print(s);},
                    label: 'Search',
                    prefix: Icons.search),
              ),
              Expanded(child: articleBuilder(list, context,itemCount:list.length,isSearch: true )),
            ],
          )
      );},

    );
  }
}
