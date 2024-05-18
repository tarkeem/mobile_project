
import 'package:flutter/material.dart';

import 'view/screen/authSc.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  
  
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:MyHomePage()
         //EditScreen(email: 'email', geneder: 'geneder', id: 'id', name: 'name', level: 3, password: 'password', img: null),
      );
  }
}


