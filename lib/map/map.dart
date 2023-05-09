
// ignore_for_file: must_be_immutable

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';

class AppleMapPage extends StatelessWidget {
  late AppleMapController mapController;

  AppleMapPage({super.key});

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: const BackButton(),
          title: const Text("Weather App"),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: AppleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0.0, 0.0),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     Column(
            //       children: <Widget>[
            //         TextButton(
            //           onPressed: () {
            //             mapController.moveCamera(
            //               CameraUpdate.newCameraPosition(
            //                 const CameraPosition(
            //                   heading: 270.0,
            //                   target: LatLng(51.5160895, -0.1294527),
            //                   pitch: 30.0,
            //                   zoom: 17,
            //                 ),
            //               ),
            //             );
            //           },
            //           child: const Text('newCameraPosition'),
            //         ),
            //         TextButton(
            //           onPressed: () {
            //             mapController.moveCamera(
            //               CameraUpdate.newLatLngZoom(
            //                 const LatLng(37.4231613, -122.087159),
            //                 11.0,
            //               ),
            //             );
            //           },
            //           child: const Text('newLatLngZoom'),
            //         ),
            //       ],
            //     ),
            //     Column(
            //       children: <Widget>[
            //         TextButton(
            //           onPressed: () {
            //             mapController.moveCamera(
            //               CameraUpdate.zoomIn(),
            //             );
            //           },
            //           child: const Text('zoomIn'),
            //         ),
            //         TextButton(
            //           onPressed: () {
            //             mapController.moveCamera(
            //               CameraUpdate.zoomOut(),
            //             );
            //           },
            //           child: const Text('zoomOut'),
            //         ),
            //         TextButton(
            //           onPressed: () {
            //             mapController.moveCamera(
            //               CameraUpdate.zoomTo(16.0),
            //             );
            //           },
            //           child: const Text('zoomTo'),
            //         ),
            //       ],
            //     ),
            //   ],
            // )
          ],
        ));
  }
}
