import 'package:chatapp/pages/auth/register_page.dart';
import 'package:chatapp/serives/auth_services.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../../serives/database_service.dart';
import 'home_page.dart';
class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor ,
      // ),
      body: _isLoading ? Center(child:
      CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text("groupie ",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),
                  const Text("login now that they are talking !",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),),

                  Image.asset("assets/login.png"),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        )),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (val) {
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!)
                          ? null
                          : "Please enter a valid email";
                    },),

                  const SizedBox(height: 15,),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                        labelText: "password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme
                              .of(context)
                              .primaryColor,
                        )),
                    validator: (val) {
                      if (val!.length < 6) {
                        return "password must have atleast 6 characters";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme
                              .of(context)
                              .primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text("Sing In",
                        style: TextStyle(color: Colors.white, fontSize: 16),),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                        color: Colors.black, fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Register here",
                          style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                            nextScreen(context, const RegisterPage());
                            }),
                    ],
                  )),
                ],
              )),
        ),
      ),
    );
  }
    login ()async{
      if(formKey.currentState!.validate()){
        setState(() {
          _isLoading = true;
        });
        await authService.loginWithUserNameandPassword(email, password)
         .then((value)async{
          if(value==true) {
            QuerySnapshot snapshot =
            await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettinguserdata(email);
            await HelperFunctions.saveUserLoggedInStatus( true);
            await HelperFunctions.saveUserEmailSF( email);
            await HelperFunctions.saveUserNameSF(
              snapshot.docs[0]['fullName']
            );

            nextScreenReplace(context, const HomePage());
          }else{
            showSnackbar(context, Colors.red, value);
            setState(() {
              _isLoading =false;
            });
          }
        });
      }
    }
}


