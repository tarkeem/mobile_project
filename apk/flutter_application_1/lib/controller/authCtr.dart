import 'dart:convert';

import 'package:http/http.dart'as http;

class authCtr
{
  

 

   Future<int> signin(email,pass)async
  {
         var res=await http.post(Uri.parse('http://10.0.2.2:4000/api/auth/login'),body:{
    "email": email,
    "password": pass
      });

      return res.statusCode;
  }

 Future<int> signup(name,email,pass,gender,level)async
  {

      var res=await http.post(Uri.parse('http://10.0.2.2:4000/api/auth/register'),body:{
    "username": 'name',
    "email": email,
    "password": pass,
    "gender":gender ,
    "level": level
      });

      print(res.body);

      return res.statusCode;
  }
}