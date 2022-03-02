import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_fluttter/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  var emailControl = TextEditingController();
  var passwordControl = TextEditingController();
  var formKey = GlobalKey<FormState>();
   bool _isPassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormText(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email can't be Empty";
                      }
                      return null;
                    },
                    onSubmit: () {
                      print(emailControl.text);
                    },
                    onChanged: ( value){print(value);},
                    control: emailControl,
                    type: TextInputType.emailAddress,
                    label: "Email Address",
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormText(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password can't be Empty";
                      }
                      return null;
                    },
                    isPassword: _isPassword,
                    suffix: _isPassword? Icons.visibility_off:Icons.visibility,
                    suffixClicked: (){
                      setState(() {
                        _isPassword= !_isPassword;
                      });
                    },
                    onSubmit: (s) {
                      print(s);
                    },
                     onChanged: (value) {print(value);},
                    control: passwordControl,
                    type: TextInputType.visiblePassword,
                    label: "Password",
                    prefix: Icons.lock,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          print(emailControl.text);
                          print(passwordControl.text);
                        }
                      },
                      text: "login"),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      radius: 20,
                      backGroundColor: Colors.red,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          print(emailControl.text);
                          print(passwordControl.text);
                        }
                      },
                      text: "login",
                      isUpperCase: false),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account? "),
                      TextButton(onPressed: () {}, child: Text("Register Now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// TextFormField(
//   controller: passwordControl,
//   keyboardType: TextInputType.visiblePassword,
//   validator: (value) {
//     if (value!.isEmpty) {
//       return "Password can't be Empty";
//     }
//     return null;
//   },
//   onFieldSubmitted: (value) {
//     print(value);
//   },
//   onChanged: (value) {
//     print(value);
//   },
//   obscureText: true,
//   decoration: InputDecoration(
//       labelText: "Password",
//       prefixIcon: Icon(Icons.lock),
//       suffixIcon: Icon(Icons.remove_red_eye),
//       border: OutlineInputBorder()),
// ),
