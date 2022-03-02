import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_fluttter/shared/components/components.dart';
import 'package:udemy_fluttter/shared/network/local/cash_helper.dart';
import 'package:udemy_fluttter/styles/colors.dart';

import '../Login/ShopLoginScreen.dart';
class OnBoardingModel{
   final String image;
   final String title;
   final String body;
   OnBoardingModel( {
     required this.image,
     required this.title,
     required this.body,
    });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<OnBoardingModel> boardingList= [
    OnBoardingModel(
      image: 'assets/images/onBoard1.png',
      title: 'TitleOnBoarding 1',
      body: 'BodyOnBoarding 1',
    ),
    OnBoardingModel(
      image: 'assets/images/onBoard2.png',
      title: 'TitleOnBoarding 2',
      body: 'BodyOnBoarding 2',
    ),
    OnBoardingModel(
      image: 'assets/images/onBoard3.png',
      title: 'TitleOnBoarding 3',
      body: 'BodyOnBoarding 3',
    ),];

  bool isLast=false;
 void submit(){
   CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
     if(value)
       navigateAndFinish(context, ShopLoginScreen());
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(
            onPressed: (){
            submit();
              },
            child: Text('SKIP'
              ,)
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded (
              child: PageView.builder(itemBuilder:(context,index)=>buildBoardingItem(boardingList[index]),
                controller: boardController,
                onPageChanged:(int index)
                {
                if(index==boardingList.length-1)
                {
                 setState(() {
                   isLast=true;

                 });
                }
                else
                  {
                    setState(() {
                      isLast=false;
                    });
                }
                } ,
                physics: BouncingScrollPhysics(),
                itemCount: boardingList.length,
              ),
            ),
            SizedBox
              (
              height: 40,),
            Row(
              children: [
              SmoothPageIndicator(
                  controller: boardController,
                  count: boardingList.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 2,
                    dotWidth: 10,
                    spacing: 5,
                  ),
              ),
              Spacer(),
              FloatingActionButton(
                  onPressed: (){
                    if(isLast)
                    {
                      submit();
                    }
                    else
                      {
                        boardController.nextPage(
                            duration: Duration(
                                milliseconds: 750
                            ),
                            curve:Curves.fastLinearToSlowEaseIn );
                      }
                  },
                 child: Icon(Icons.arrow_forward_ios),
              )
            ],)
          ],
        ),
      )
    );
  }
}
Widget buildBoardingItem(OnBoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image:AssetImage('${model.image}'),
      ),
    ),
    SizedBox(height: 30
      ,),
    Text(
      '${model.title}',
      style: TextStyle(
        fontSize: 24,
      )
      ,),
    SizedBox(
      height: 15
      ,),
    Text (
      '${model.body}'
      ,style: TextStyle(
      fontSize: 14,

    ),),
    SizedBox(height: 30
      ,),
  ],
);