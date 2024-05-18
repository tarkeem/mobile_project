import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/product.dart';
import 'package:flutter_application_1/components/restaurants.dart';
import 'package:flutter_application_1/view/screen/restaurantsforproduct.dart';
import 'package:http/http.dart' as http;

List<Restaurant> restaurants = [];
List<Product> products = [];

Future<void> getRestaurants() async {
  try {
    var response =
        await http.get(Uri.http("10.0.2.2:4000", "api/restaurants/all"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var eachRestaurant in jsonData) {
        print("yes");
        Restaurant restaurant = Restaurant.fromJson(eachRestaurant);
        restaurants.add(restaurant);
      }
    } else {
      print("Error fetching restaurants: ${response.statusCode}");
    }
  } catch (error) {
    print("Error getting restaurants: $error");
  }
}

Future<List> Products() async {
  try {
    var response2 =
        await http.get(Uri.http("10.0.2.2:4000", "api/products/all"));
    if (response2.statusCode == 200) {
      var jsonData = jsonDecode(response2.body);
      for (var eachProduct in jsonData) {
        Product product = Product.fromJson(eachProduct);
        products.add(product);
      }
    } else {
      print("Error fetching products: ${response2.statusCode}");
    }
  } catch (error) {
    print("Error getting products: $error");
  }
  return products;
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String routeName = "searchPage";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Page'),
        ),
        body: FutureBuilder<List>(
            future: Products(),
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
                                  builder: (context) => RestaurantsForProduct(
                                        productID: products[index].id,
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
                              child: Center(
                                child: Text(
                                  products[index].name,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
              }
            }));
  }
}
