
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meteo/animation/animation.dart';
import 'package:meteo/map/map.dart';

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
