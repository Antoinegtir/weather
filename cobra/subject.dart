// ignore_for_file: library_private_types_in_public_api
// package in order to dispose loading widget from apple
import 'package:flutter/cupertino.dart';
// package in order to dispose all basic flutter widget
import 'package:flutter/material.dart';
// package in order to interact with external url
import 'package:http/http.dart';
// package in order to parse json
import 'dart:convert';

// function main in order to run the app
void main() => runApp(const WeatherApp());

// class in which we will create our graphical interface & background process
class WeatherApp extends StatefulWidget {
  // key param in order to refresh widgets on the app correctly
  const WeatherApp({super.key});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  // String == char* | var necessary in which we will stock data from api and print them in Text widget
  String locationName = "";
  String temperature = "";
  String description = "";
  String humidity = "";
  String windSpeed = "";
  String image = "";
  String apikey = "API_KEY";

  // Future == Promesses in JS & TS | function in order to fill the String of data from API
  Future getWeather() async {
    // Class response that retrive value from the url such as header, body ...
    Response response = await get(Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=$apikey&q=Nantes"));
    // Extract body from url
    var results = jsonDecode(response.body);
    // Special Flutter Function that insert data value in the String declares previously
    setState(() {
      locationName = results['location']['name'];
      temperature = results['current']['temp_c'].toString();
      description = results['current']['condition']['text'];
      image = results['current']['condition']['icon'];
      humidity = results['current']['humidity'].toString();
      windSpeed = results['current']['wind_kph'].toString();
    });
  }

  // Special Flutter Function that allow to declare the getWeather and work in background
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  // All flutter graphical interface
  @override
  Widget build(BuildContext context) {
    // before url was like that: img = file//cdn.weatherapi.com/weather/64x64/day/116.png
    // after url like that : img = http//cdn.weatherapi.com/weather/64x64/day/116.png in order to be displayable in Image widget
    // split == to_word_array, last == img[1]
    String img = "http:${image.split("file").last}";
    // return All stack of widget that build graphical interface
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          // blue upper of app
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            title: const Text('Weather App'),
          ),
          // body of app with all data info
          body: Center(
            // Column is a widget that allow to contain a lot of widget in column.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // widget that display the image of the url correctly
                Image.network(
                  height: 50,
                  img,
                  errorBuilder: (context, error, stackTrace) {
                    // if url don't work display loading indicator
                    return const SizedBox(
                        height: 50,
                        // if iOS : Cupertino Loader, else other loader...
                        child: CupertinoActivityIndicator());
                  },
                ),
                // display all String info in a Text Widget, with possibility to modify style.
                Text(
                  'Currently in $locationName',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "$temperature°C",
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  "Humidity: $humidity%",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  "Wind Speed: $windSpeed km/h",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
