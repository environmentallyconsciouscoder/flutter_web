import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_visualization.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'dashboard_view.form.dart';

import 'package:sales_engine/app/app.locator.dart';
import 'package:sales_engine/enums/dialog_type.dart';
import 'package:sales_engine/models/coordinates.dart';
import 'package:sales_engine/models/hospitality_business.dart';
import 'package:sales_engine/services/graphql_service.dart';
import 'package:sales_engine/services/api_service.dart';

class DashboardViewModel extends FormViewModel {
  final apiService = locator<ApiService>();
  final graphqlService = locator<GraphqlService>();
  final dialogService = locator<DialogService>();

  final List<HospitalityBusiness> companies = [];
  final List<Marker> allMarkersData = [];
  final List<Marker> topTenMarkersData = [];
  final List<Marker> pointOfInterest = [];
  final List<LatLng> pointsForHeatMap = [];
  final List<dynamic> sameCoordinates = [];

  final String orangeIcon = 'http://maps.google.com/mapfiles/ms/icons/orange-dot.png';
  final String greenIcon = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
  final LatLng center = LatLng(51.5072, 0.1276);
  final String htmlId = "7";

  late GMap _map;
  late InfoWindow infoWindow = InfoWindow(InfoWindowOptions());
  HeatmapLayer? heatmap;

  late Coordinates _startCoordinate;
  Coordinates get getStartCoordinate => _startCoordinate;
  dynamic get address => hasSearchInput ? searchInputValue! : '';

  late bool areThereSameCoordinates = false;
  late bool showAndHide = false;

  late dynamic hospitalityBusinesses;
  late dynamic top10ClosestCompanies;
  late dynamic sortedCompanies = null;

  final bool sortAscending = true;
  late int sortColumnIndex = 0;
  late int rowsPerPage = 10;

  String label = 'Top Markers';

  initMap() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = center;

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);
      _map = map;

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }

  void onRowsPerPageChanged(int value) {
    rowsPerPage = value;
    notifyListeners();
  }

  void closeInfoWindow() {
    infoWindow.close();
  }

  closeTopTenMarkers() async {
    for (var marker in topTenMarkersData) {
      marker.map = null;
    }
    topTenMarkersData.clear();
  }

  closeAllMarkers() async {
    for (var marker in allMarkersData) {
      marker.map = null;
    }
    allMarkersData.clear();
  }

  closePointOfInterest() async {
    for (var marker in pointOfInterest) {
      marker.map = null;
    }
    pointOfInterest.clear();
  }

  void addTopTenMarkersAndInfoWindow() {
    top10ClosestCompanies = getTop10ClosestCompanies(companies);

    for (var company in top10ClosestCompanies) {
      final id = company.id;
      final name = company.name;
      final latitude = company.latitude;
      final longitude = company.longitude;
      final structuralScore = company.structuralScore;
      final hygieneScore = company.hygieneScore;
      final confidenceInManagementScore = company.confidenceInManagementScore;
      final ratingValue = company.ratingValue;
      final addressLineFour = company.addressLineFour;
      final addressLineThree = company.addressLineThree;
      final addressLineTwo = company.addressLineTwo;
      final addressLineOne = company.addressLineOne;
      final postCode = company.postCode;
      final businessType = company.businessType;
      final localAuthority = company.localAuthority;
      final distance = company.distance.toStringAsFixed(2);

      final myLatlng = LatLng(latitude, longitude);
      final marker = Marker(MarkerOptions()
        ..position = myLatlng
        ..icon = orangeIcon
        ..map = _map);
      topTenMarkersData.add(marker);

      marker.onClick.listen((mapsMouseEvent) {
        closeInfoWindow();

        infoWindow = InfoWindow(InfoWindowOptions()
          ..content =
              '<div style="color: black">Id: $id <br> Name: $name <br> Address Line One: $addressLineOne <br> Address Line Two: $addressLineTwo <br> Address Line Three: $addressLineThree <br> Address Line Four: $addressLineFour <br> Post Code: $postCode <br> Distance: $distance m <br> Local Authority: $localAuthority <br> Business Type: $businessType <br> Rating Value: $ratingValue <br> Structural Score: $structuralScore <br> Hygiene Score: $hygieneScore <br> Confidence in Management Score: $confidenceInManagementScore</div>'
          ..position = myLatlng
          ..pixelOffset = Size(0, -30))
          ..open(_map);
      });
    }
  }

  void addPointOfInterestMarker(num latitude, num longitude, String icon) {
    final myLatlng = LatLng(latitude, longitude);
    final marker = Marker(MarkerOptions()
      ..position = myLatlng
      ..icon = icon
      ..map = _map);
    pointOfInterest.add(marker);
  }

  void addAllMarkersAndInfoWindow(
      double latitude,
      double longitude,
      String icon,
      num id,
      String name,
      String structuralScore,
      String hygieneScore,
      String confidenceInManagementScore,
      String ratingValue,
      String addressLineFour,
      String addressLineThree,
      String addressLineTwo,
      String addressLineOne,
      String postCode,
      String businessType,
      String localAuthority,
      String distance) {
    final myLatlng = LatLng(latitude, longitude);
    final marker = Marker(MarkerOptions()
      ..position = myLatlng
      ..icon = icon
      ..visible = false
      ..map = _map);
    allMarkersData.add(marker);

    marker.onClick.listen((mapsMouseEvent) {
      closeInfoWindow();

      infoWindow = InfoWindow(InfoWindowOptions()
        ..content =
            '<div style="color: black">Id: $id <br> Name: $name <br> Address Line One: $addressLineOne <br> Address Line Two: $addressLineTwo <br> Address Line Three: $addressLineThree <br> Address Line Four: $addressLineFour <br> Post Code: $postCode <br> Distance: $distance m <br> Local Authority: $localAuthority <br> Business Type: $businessType <br> Rating Value: $ratingValue <br> Structural Score: $structuralScore <br> Hygiene Score: $hygieneScore <br> Confidence in Management Score: $confidenceInManagementScore</div>'
        ..position = myLatlng
        ..pixelOffset = Size(0, -30))
        ..open(_map);
    });
  }

  hideTopTenMarkers() {
    for (var marker in topTenMarkersData) {
      marker.visible = false;
    }
  }

  hideAllMarkers() {
    for (var marker in allMarkersData) {
      marker.visible = false;
    }
  }

  showTopTenMarkers() {
    for (var marker in topTenMarkersData) {
      marker.visible = true;
    }
  }

  showAllMarkers() {
    for (var marker in allMarkersData) {
      marker.visible = true;
    }
  }

  void showHeatMap() {
    if (heatmap != null) {
      heatmap!.map = _map;
    }
  }

  void hideHeatMap() {
    if (heatmap != null) {
      heatmap!.map = null;
    }
  }

  addDataToMap() async {
    addTopTenMarkersAndInfoWindow();
    addPointOfInterestMarker(getStartCoordinate.latitude, getStartCoordinate.longitude, greenIcon);
    createAllMarkers();
    addHeatMap();
  }

  getBounds(List<Marker> markersData) {
    final bounds = LatLngBounds();

    for (var marker in markersData) {
      bounds.extend(marker.position);
    }
    _map.fitBounds(bounds);
  }

  createAllMarkers() {
    for (var company in companies) {
      final id = company.id;
      final name = company.name;
      final latitude = company.latitude;
      final longitude = company.longitude;
      final structuralScore = company.structuralScore;
      final hygieneScore = company.hygieneScore;
      final confidenceInManagementScore = company.confidenceInManagementScore;
      final ratingValue = company.ratingValue;
      final addressLineFour = company.addressLineFour;
      final addressLineThree = company.addressLineThree;
      final addressLineTwo = company.addressLineTwo;
      final addressLineOne = company.addressLineOne;
      final postCode = company.postCode;
      final businessType = company.businessType;
      final localAuthority = company.localAuthority;
      final distance = company.distance;

      addAllMarkersAndInfoWindow(latitude, longitude, orangeIcon, id, name, structuralScore, hygieneScore, confidenceInManagementScore, ratingValue,
          addressLineFour, addressLineThree, addressLineTwo, addressLineOne, postCode, businessType, localAuthority, distance.toStringAsFixed(2));
    }
    getBounds(allMarkersData);
  }

  addHeatMap() {
    for (var company in companies) {
      final latLng = LatLng(company.latitude, company.longitude);
      pointsForHeatMap.add(latLng);
    }

    final data = MVCArray<LatLng>();
    for (final point in pointsForHeatMap) {
      data.push(point);
    }

    heatmap = HeatmapLayer(HeatmapLayerOptions()
      ..map = _map
      ..data = data
      ..radius = 50 // increase the radius to make the heatmap more visible
      ..opacity = 0.6);

    heatmap!.map = null;
  }

  List<HospitalityBusiness> getTop10ClosestCompanies(List<HospitalityBusiness> companies) {
    sortedCompanies = List<HospitalityBusiness>.from(companies)..sort((a, b) => a.distance.compareTo(b.distance));
    return sortedCompanies.take(10).toList();
  }

  selector(String display) {
    closeInfoWindow();

    switch (display) {
      case 'showTopMarkers':
        showAndHide = false;
        hideAllMarkers();
        hideHeatMap();
        showTopTenMarkers();
        label = 'Top Markers';
        notifyListeners();
        break;
      case 'showAllMarkers':
        showAndHide = false;
        hideTopTenMarkers();
        hideHeatMap();
        label = 'All Markers';
        showAllMarkers();
        notifyListeners();
        break;
      case 'showHeatmap':
        showAndHide = false;
        hideTopTenMarkers();
        hideAllMarkers();
        label = 'Heat Map';
        showHeatMap();
        notifyListeners();
        break;
      case 'showTable':
        if (sortedCompanies != null) {
          showAndHideTable();
          break;
        }
    }
  }

  void showAndHideTable() {
    showAndHide = !showAndHide;
    notifyListeners();
  }

  Future submitSearch() async {
    // Show loading spinner
    dialogService.showCustomDialog(
      variant: DialogType.loading,
      barrierDismissible: false,
    );

    try {
      if (address.isEmpty) {
        return;
      } else {
        resetMap();
        final Coordinates coordinates = await apiService.geocoding(address);

        _startCoordinate = coordinates;
        hospitalityBusinesses = await graphqlService.findNearbyHospitalityBusinesses(coordinates);

        await formatData(hospitalityBusinesses);
        await addDataToMap();
      }
    } finally {
      // Hide loading spinner
      dialogService.completeDialog(DialogResponse());
    }
  }

  void resetMap() {
    companies.clear();
    closeTopTenMarkers();
    closeAllMarkers();
    closeInfoWindow();
    closePointOfInterest();
    showAndHide = false;
    pointsForHeatMap.clear();
    if (heatmap != null) {
      heatmap!.map = null;
      heatmap = null;
    }
    label = 'Top Markers';
    notifyListeners();
  }

  Future formatData(List hospitalityBusinesses) async {
    for (var business in hospitalityBusinesses) {
      final startLatitude = getStartCoordinate.latitude;
      final startLongitude = getStartCoordinate.longitude;
      final businessLatitude = business['location']['latitude'];
      final businessLongitude = business['location']['longitude'];

      final distance = await graphqlService.calculateDistances(businessLatitude, businessLongitude, startLatitude, startLongitude);

      final name = business['name'];
      final id = business['id'];
      final ratingValue = business['ratingValue'];
      final structuralScore = business['structuralScore']['low'];
      final hygieneScore = business['hygieneScore']['low'];
      final confidenceInManagementScore = business['confidenceInManagementScore']['low'];
      final addressLineOne = business['addressLineOne'];
      final addressLineTwo = business['addressLineTwo'];
      final addressLineThree = business['addressLineThree'];
      final addressLineFour = business['addressLineFour'];
      final postCode = business['postCode'];
      final businessType = business['businessType'];
      final localAuthority = business['localAuthority'];

      final company = HospitalityBusiness(
          id: id,
          name: name,
          latitude: businessLatitude,
          longitude: businessLongitude,
          structuralScore: structuralScore.toString(),
          hygieneScore: hygieneScore.toString(),
          confidenceInManagementScore: confidenceInManagementScore.toString(),
          ratingValue: ratingValue.toString(),
          addressLineOne: addressLineOne,
          addressLineTwo: addressLineTwo,
          addressLineThree: addressLineThree,
          addressLineFour: addressLineFour,
          postCode: postCode,
          businessType: businessType,
          localAuthority: localAuthority,
          distance: distance);

      companies.add(company);
    }
  }
}
