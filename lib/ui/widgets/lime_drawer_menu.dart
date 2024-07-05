import 'package:flutter/material.dart';
import 'package:sales_engine/app/app.router.dart';
import 'package:sales_engine/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:sales_engine/app/app.locator.dart';
import 'package:sales_engine/ui/common/app_colors.dart';
import 'package:sales_engine/ui/widgets/lime_drawer_list_tile.dart';

class DrawerMenu extends StatelessWidget {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final dynamic selector;

  DrawerMenu({Key? key, this.selector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kcPrimaryDarkColor,
      child: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 30, 30),
            child: Image.asset("assets/images/limetrack_logo_white_horizontal.webp"),
          ),
          DrawerListTile(
              title: 'Heatmap',
              tap: () {
                selector("showHeatmap");
              }),
          DrawerListTile(
              title: 'All Markers',
              tap: () {
                selector("showAllMarkers");
              }),
          DrawerListTile(
              title: 'Top Markers',
              tap: () {
                selector("showTopMarkers");
              }),
          DrawerListTile(
              title: 'View Table',
              tap: () {
                selector("showTable");
              }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2 * 2),
            child: Divider(
              color: kcPrimaryUltraLightColor,
              thickness: 0.5,
            ),
          ),
          DrawerListTile(
              title: 'Logout',
              tap: () {
                _authenticationService.logout();
                _navigationService.replaceWith(Routes.loginView);
              }),
        ],
      ),
    );
  }
}
