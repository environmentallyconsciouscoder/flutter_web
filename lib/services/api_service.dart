import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_engine/models/coordinates.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  Future geocoding(String address) async {
    final api = dotenv.env['GOOGLE_API'];

    final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$api'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['results'].length > 0) {
        return Coordinates.fromJson(data['results'][0]['geometry']['location']);
      }
    } else {
      throw Exception('Failed to load');
    }
  }
}
