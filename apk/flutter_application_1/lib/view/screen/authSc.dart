import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controller/authCtr.dart';
import 'package:flutter_application_1/view/screen/mianSc.dart';
import 'package:flutter_application_1/view/screen/search.dart';
import 'package:flutter_application_1/view/widget/dialog.dart';
import 'package:flutter_application_1/view/widget/editField.dart';
import 'package:flutter_application_1/view/widget/signin_button.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _SignInKey = GlobalKey();
  GlobalKey<FormState> _SignupKey = GlobalKey();

  String? name, password, email, geneder, id, confirm_password, level;

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  // Box decoration takes a gradient
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.0, 1.0],
                    colors: [
                      Color.fromARGB(255, 242, 250, 249),
                      Color(0xff64FFDA),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SizedBox(
                child: CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1,
                        aspectRatio: 1,
                        height: double.infinity,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.5),
                    items: [
                      signin(devicePadding),
                      signUp(devicePadding),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView signin(EdgeInsets devicePadding) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "FCAI",
            style:
                TextStyle(fontFamily: 'ice', fontSize: 70, letterSpacing: 20),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _SignInKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    EditField(
                      icon: Icon(Icons.email),
                      validator: (val) {
                        if (val == null ||
                            val.isEmpty ||
                            val.contains("@stud.fci-cu.edu.eg)")) {
                          return "email should be as form studentID@stud.fci-cu.edu.eg)";
                        }
                      },
                      onTextChanged: (text) {
                        email = text;
                      },
                      label: "email",
                      hint: "Enter Your email",
                    ),
                    EditField(
                      
                      icon: Icon(Icons.lock),
                      label: "Password",
                      hint: "I'm not watching",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "please enter the password";
                        }
                        if (!(val.length >= 8)) {
                          return "too short password";
                        }
                      },
                      isObscured: true,
                      onTextChanged: (String value) {
                        password = value;
                      },
                    ),
                    SigninButton(
                      child: Text("Sign In",
                          style: TextStyle(
                              fontFamily: "RobotoMedium",
                              fontSize: 16,
                              color: Colors.white)),
                      onPressed: () async {
                          print(email);
                          print(password);
                        int res=await authCtr().signin(email, password);

                        if(res>=400)
                        {
                          MyDialog('signin failed', context, Colors.red);
                        }
                        else
                        {
                           MyDialog('signin successfully', context, Colors.green);

                           Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainSc() ,));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView signUp(EdgeInsets devicePadding) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "FCAI",
            style:
                TextStyle(fontFamily: 'ice', fontSize: 70, letterSpacing: 20),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _SignupKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    EditField(
                      label: "Name",
                      hint: "What's your Name?",
                      onTextChanged: (text) {
                        print(text);
                        name = text;
                      },
                      validator: (val) {
                        if (val == '' || val == null) {
                          return "please enter your name";
                        }
                      },
                    ),
                    EditField(
                      label: "Email",
                      hint: "What's your Email?",
                      onTextChanged: (text) {
                        email = text;
                      },
                      validator: (val) {
                        if (val == '' || val == null) {
                          return "please enter your email";
                        }

                        final reg = RegExp(r'^[0-9]+@stud\.fci-cu\.edu\.eg$');
                        if (!reg.hasMatch(val)) {
                          return "the email should be as form studentID@stud.fci-cu.edu.eg)";
                        }
                      },
                    ),
                    EditField(
                      label: "Password",
                      hint: "Type Password",
                      isObscured: true,
                      onTextChanged: (String value) {
                        if (value != '') {
                          password = value;
                        }
                      },
                      validator: (val) {
                        if (val == '' || val == null) {
                          return "please enter your password";
                        }
                        if (!(val.length >= 8)) {
                          return "Password is too short";
                        }
                      },
                    ),
                    EditField(
                      label: "Confirm Password",
                      hint: "Type Password Again",
                      isObscured: true,
                      onTextChanged: (String value) {
                        if (value != '') {
                          confirm_password = value;
                        }
                      },
                      validator: (val) {
                        if (val == '' || val == null) {
                          return "please enter your password";
                        }
                        if (!(val.length >= 8)) {
                          return "Password is too short";
                        }
                        if (confirm_password != password) {
                          return "password does not math";
                        }
                      },
                    ),
                    RadioListTile(
                      value: 'female',
                      groupValue: geneder,
                      onChanged: (value) {
                        setState(() {
                          geneder = value!;
                        });
                      },
                      title: Text('female'),
                    ),
                    RadioListTile(
                      value: 'male',
                      groupValue: geneder,
                      onChanged: (value) {
                        setState(() {
                          geneder = value!;
                        });
                      },
                      title: Text('male'),
                    ),
                    EditField(
                        label: "Level",
                        hint: "Enter Your Level",
                        onTextChanged: (val) {
                          if (val != null || val != '') {
                            level = val;
                          }
                        },
                        validator: (val) {
                          print(val);
                          if (!(val == '1' ||
                              val == '2' ||
                              val == '3' ||
                              val == '4' ||
                              val == '' ||
                              val == null)) {
                            return "wrong format";
                          }
                        }),
                    SigninButton(
                      child: Text("Sign Up",
                          style: TextStyle(
                              fontFamily: "RobotoMedium",
                              fontSize: 16,
                              color: Colors.white)),
                      onPressed: () async {
                       bool isvalid=_SignupKey.currentState!.validate();
                        if(isvalid)
                        {
                           var res= await authCtr().signup(name, email, password, geneder, level);


                        if(res>=400)
                        {
                          MyDialog('signup failed', context, Colors.red);
                        }
                        else
                        {
                           MyDialog('signup successfully', context, Colors.green);
                        }
                        }

                        
                        




                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
