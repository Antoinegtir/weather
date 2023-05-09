// ignore_for_file: sort_child_properties_last, must_be_immutable
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:iconsax/iconsax.dart';
import 'package:meteo/animation/animation.dart';
import 'map/map.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int current = 0;
  String locationName = "";
  String temperature = "";
  String description = "";
  String humidity = "";
  String windSpeed = "";
  String image = "";
  String uv = "";
  String text = "";
  String pressure = "";
  String apikey = "API_KEY";

  Future getWeather(String city) async {
    Response response = await get(Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=$apikey&q=$city"));
    var results = jsonDecode(response.body);
    setState(() {
      locationName = results['location']['name'];
      temperature = results['current']['temp_c'].toString();
      description = results['current']['condition']['text'];
      image = results['current']['condition']['icon'];
      text = results['current']['condition']['text'];
      humidity = results['current']['humidity'].toString();
      pressure = results['current']['pressure_mb'].toString();
      uv = results['current']['uv'].toString();
      windSpeed = results['current']['wind_kph'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather("Nantes");
  }

  double opacity = 11;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            bottomNavigationBar: const BottomNavPage(),
            backgroundColor: Colors.blue,
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: NotificationListener(
                onNotification: (v) {
                  if (v is ScrollUpdateNotification) {
                    if (v.depth == 1) {
                      return false;
                    }
                    setState(() {
                      opacity += v.scrollDelta! / 1;
                    });
                  }
                  return true;
                },
                child: NestedScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                            elevation: 0,
                            leading: const SizedBox.shrink(),
                            pinned: true,
                            stretch: true,
                            onStretchTrigger: () {
                              return getWeather("Nantes");
                            },
                            expandedHeight: 400,
                            primary: true,
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                            title: opacity >= 229
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: FadeInDown(
                                        child: Text(locationName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "arial",
                                                fontSize: 20))))
                                : Container(),
                            flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.pin,
                                stretchModes: const <StretchMode>[
                                  StretchMode.zoomBackground,
                                  StretchMode.blurBackground,
                                  StretchMode.fadeTitle,
                                ],
                                centerTitle: true,
                                expandedTitleScale: 3,
                                title: SizedBox(
                                    height: 310 / 3,
                                    width: 300 / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 10,
                                        ),
                                        Text(locationName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "arial",
                                                fontSize: 60 / 3)),
                                        Text(
                                            "${temperature.split(".0").first}°",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 140 / 3)),
                                        AnimatedOpacity(
                                            opacity: opacity <= 229 ? 1 : 0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: Text(description,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 20 / 2.1)))
                                      ],
                                    )),
                                background: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                            "https://www.trecobat.fr/wp-content/uploads/2021/06/vivre-a-nantes-trecobat.jpg",
                                            fit: BoxFit.cover,
                                          )),
                                      Container(
                                          height: 1000,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topRight,
                                                  colors: [
                                                Colors.blue.withOpacity(1),
                                                Colors.blue.withOpacity(0.9),
                                                Colors.blue.withOpacity(0.8),
                                                Colors.blue.withOpacity(0.7),
                                                Colors.blue.withOpacity(0.6),
                                                Colors.blue.withOpacity(0.5),
                                                Colors.blue.withOpacity(0.4),
                                                Colors.blue.withOpacity(0.3),
                                                Colors.blue.withOpacity(0.2),
                                                Colors.blue.withOpacity(0.1),
                                                Colors.blue.withOpacity(0.05),
                                                Colors.blue.withOpacity(0.025),
                                                Colors.blue.withOpacity(0.0),
                                                Colors.blue.withOpacity(0.0),
                                              ]))),
                                    ]))),
                      ];
                    },
                    body: Container(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      color: const Color.fromARGB(
                                          154, 255, 255, 255),
                                      width: 320,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("$pressure hpa",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 25)),
                                            Text("uv: $uv",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 25)),
                                            Text(text,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 25)),
                                          ]),
                                    )),
                              ],
                            ),
                            Container(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      color: const Color.fromARGB(
                                          154, 255, 255, 255),
                                      width: 150,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Iconsax.wind,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: 10,
                                            ),
                                            Text("$windSpeed km/h",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 25)),
                                            Container(
                                              height: 10,
                                            ),
                                          ]),
                                    )),
                                Container(
                                  width: 20,
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      color: const Color.fromARGB(
                                          154, 255, 255, 255),
                                      width: 150,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.water_drop,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: 10,
                                            ),
                                            Text("$humidity%",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 25)),
                                            Container(
                                              height: 10,
                                            ),
                                          ]),
                                    ))
                              ],
                            )
                          ],
                        ))))));
  }
}

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int current = 0;
  Widget dottedIndex(int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: current == index
                  ? Colors.white
                  : const Color.fromARGB(82, 221, 221, 221),
              height: 7,
              width: 7,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
                height: 100,
                width: 200,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            AwesomePageRoute(
                              transitionDuration:
                                  const Duration(milliseconds: 600),
                              exitPage: widget,
                              enterPage: AppleMapPage(),
                              transition: BackgroundToForegroundTransition(),
                            ),
                          );
                        },
                        child: const Icon(
                          Iconsax.map,
                          color: Colors.white,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Stack(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 500, sigmaY: 500),
                                        child: Container(
                                            width: 70,
                                            height: 20,
                                            color: Colors.transparent))))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            dottedIndex(0),
                            const SizedBox(
                              width: 10,
                            ),
                            dottedIndex(1),
                            const SizedBox(
                              width: 10,
                            ),
                            dottedIndex(2),
                          ],
                        ),
                      ],
                      alignment: Alignment.center,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text("Delete"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: TextField(
                                      onSubmitted: (value) {
                                        Navigator.of(context).pop();
                                      },
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Type something here...'),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        child: const Icon(
                          Iconsax.note,
                          color: Colors.white,
                        )),
                    Container(
                      width: 40,
                    )
                  ],
                ))));
  }
}
