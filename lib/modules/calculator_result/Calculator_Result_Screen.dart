import 'package:flutter/material.dart';

class CalculateResult extends StatelessWidget {
  final int result;
  final bool isMale;
  final int age;

  CalculateResult({ required this.result,required this.isMale,required this.age}) ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){Navigator.pop(context);},
        color: Colors.white,
      ),
        title: Text("BMI Calculate Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gender:${isMale ? "Male" : "Female"}",
              style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold),),
            Text('Age: $age',
              style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold),),
            Text("Result: $result",
              style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
