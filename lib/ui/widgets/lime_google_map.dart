import 'package:flutter/material.dart';

class GoogleMapView extends StatelessWidget {
  final dynamic getMap;

  const GoogleMapView({Key? key, this.getMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        height: 800,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: getMap());
  }
}
