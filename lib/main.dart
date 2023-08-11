// import 'package:chatapp_firebase/helper/helper_function.dart';
// import 'package:chatapp_firebase/pages/auth/login_page.dart';
// import 'package:chatapp_firebase/pages/home_page.dart';
// import 'package:chatapp_firebase/shared/constants.dart';
import 'package:chatapp/helper/helper_function.dart';
import 'package:chatapp/pages/auth/Login_page.dart';
import 'package:chatapp/pages/auth/home_page.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState(){
    getUserLoggedInStatus();
  }
  getUserLoggedInStatus()async{
    await HelperFunctions.getUserLoggedInStatus().then((value){
      if(value!=null)
        _isSignedIn = value;
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomePage(): const  Loginpage(),
    );
  }
}
