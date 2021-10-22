import 'dart:math';
import 'package:flutter/material.dart';
import 'package:udemy_fluttter/modules/BmiCalculatorApp/calculator_result/Calculator_Result_Screen.dart';
import 'package:udemy_fluttter/shared/components/components.dart';

class CalculatorBmi extends StatefulWidget {
  const CalculatorBmi({Key? key}) : super(key: key);

  @override
  _CalculatorBmiState createState() => _CalculatorBmiState();
}

class _CalculatorBmiState extends State<CalculatorBmi> {
  bool isMale=true;
  double height=120.0;
  int age=16;
  int weight=40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
    body: Column(
      children: [
        Expanded(
               child:
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Row(
                   children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale=true;
                          });
                          },
                        child: Container(
                          child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/male.png",
                                width: 90.0,height: 90.0,),
                              SizedBox(height: 15,),
                              Text(
                                "Male",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: isMale? Colors.blue:Colors.grey[400],

                          ),
                        ),
                      ),
                    ),
                     SizedBox(width: 20,),
                     Expanded(
                       child: GestureDetector(
                         onTap: (){
                           setState(() {
                             isMale=false;
                           });
                           },
                         child: Container(
                           child: Column(

                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image.asset("assets/images/female.png",
                                 width: 90.0,height: 90.0,),
                               SizedBox(height: 15,),
                               Text(
                                 "Female",
                                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                               ),

                             ],
                           ),
                           height: 180,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10.0),
                             color:isMale?Colors.grey[400]:Colors.blue,

                           ),
                         ),
                       ),
                     ),
                   ],
       ),
               ),
             ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[400],

            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  "Height",
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 5,),
                Row(children: [
                  Text(
                    '${height.round()}',
                    style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "CM",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                   textBaseline: TextBaseline.alphabetic ,
                ),
                SizedBox(height: 10,),
                Slider(value: height,
                    max: 220.0,
                    min: 80.0,
                    onChanged: (value){
                  setState(() {
                    height=value;
                  });
                }
                    ),




              ],

              //
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[400],

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Age",
                          style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '$age',
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          FloatingActionButton(onPressed: (){
                            setState(() {
                              age--;
                            });
                          },
                          child: Icon(Icons.remove),
                          mini: true,
                          heroTag: "age--",),
                          FloatingActionButton(onPressed: (){
                            setState(() {
                              age++;
                            });
                          },
                            child: Icon(Icons.add),
                            mini: true,
                          heroTag: "age++",),
                        ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[400],

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Weight",
                          style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "$weight",
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(onPressed: (){
                              setState(() {
                                weight--;
                              });
                            },
                              child: Icon(Icons.remove),
                              mini: true,
                            heroTag: "weight--",),
                            FloatingActionButton(onPressed: (){setState(() {
                              weight++;
                            });},
                              child: Icon(Icons.add),
                              mini: true,
                            heroTag: "weight++",),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
        Container(
          width: double.infinity,
          child: MaterialButton(color: Colors.blue,
              onPressed: (){
            double result=weight/ pow(height / 100, 2);
             navigateTo(context,  CalculateResult(
               age: age,isMale: isMale,result: result.round(),
             ));
              },
            height: 50,
            child: Text("Calculate",style: TextStyle(color: Colors.white,fontSize: 25,),),

              ),
        )
      ],
    ),
    );
  }
}
