import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/restaurants.dart';
import 'package:flutter_application_1/view/screen/description.dart';
import 'package:flutter_application_1/view/screen/restaurants_map.dart';
import 'package:http/http.dart' as http;

List<Restaurant> restaurants = [];
List<Restaurant> wantedRestaurants = [];

class RestaurantsForProduct extends StatefulWidget {
  const RestaurantsForProduct({super.key, required this.productID});
  static const String routeName = "restaurantsforproduct";
  final String productID;

  @override
  State<RestaurantsForProduct> createState() => _RestaurantsForProductState();
}

class _RestaurantsForProductState extends State<RestaurantsForProduct> {
  @override
  void initState() {
    super.initState();
    wantedRestaurants.clear();
    restaurants.clear();
  }

  Future<List> Restaurants() async {
    try {
      var response =
          await http.get(Uri.http("10.0.2.2:4000", "api/restaurants/all"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var eachRestaurant in jsonData) {
          Restaurant restaurant = Restaurant.fromJson(eachRestaurant);
          restaurants.add(restaurant);
        }
      } else {
        print("Error fetching restaurants: ${response.statusCode}");
      }
    } catch (error) {
      print("Error getting restaurants: $error");
    }
    for (int i = 0; i < restaurants.length; i++) {
      for (int j = 0; j < restaurants[i].products.length; j++) {
        if (restaurants[i].products[j] == widget.productID) {
          wantedRestaurants.add(restaurants[i]);
          break;
        }
      }
    }
    return wantedRestaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurants'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List>(
                  future: Restaurants(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DirectionPage(
                                              targetLatitude:
                                                  wantedRestaurants[index]
                                                      .coordinates
                                                      .latitude,
                                              targetLongitude:
                                                  wantedRestaurants[index]
                                                      .coordinates
                                                      .longitude,
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 196, 195, 195),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    width: 60,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        wantedRestaurants[index].name,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                    }
                  }),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestaurantsMap(
                            wantedrestaurants: wantedRestaurants,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 196, 195, 195),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  width: 60,
                  height: 40,
                  child: const Center(
                    child: Text(
                      "Map",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
