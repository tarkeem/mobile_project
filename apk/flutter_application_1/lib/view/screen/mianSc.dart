import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screen/search.dart';
import 'package:http/http.dart' as http;

class MainSc extends StatelessWidget {
  const MainSc({super.key});

  Future<List> getallRastaurant()async
  {
      var response =
        await http.get(Uri.http("10.0.2.2:4000", "api/restaurants/all"));

        print(response.body);

      return json.decode( response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('mata3em'),actions: [ElevatedButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder:(context) => SearchPage(), ));
      }, child: Text('Search'))],),
      body: FutureBuilder(future: getallRastaurant(), builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return CircularProgressIndicator();
        }
        List items=snapshot.data!;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                width: 200,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.red),
                child: Text(items[index]['name']))
              
            ],
          );
        },);
      },),
    );
  }
}