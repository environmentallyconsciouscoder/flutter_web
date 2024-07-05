import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sales_engine/models/coordinates.dart';

class GraphqlService {
  String getCompany = """query  getCompanies(\$latitude: Float!, \$longitude: Float!){
    companies(
    where: {
    location_LT: {
    distance: 500
    point: { latitude: \$latitude, longitude: \$longitude }
    }
    }
    ) {
    name
    id
    location {
      latitude
      longitude
    }
    name
    ratingValue
    structuralScore {
      low
    }
    hygieneScore {
      low
    }
    confidenceInManagementScore {
      low
    }
    id
    addressLineOne
    addressLineTwo
    addressLineThree
    addressLineFour
    postCode
    businessType
    localAuthority
    }
}""";

  String getDistance = """
query Query(\$startLat: Float, \$startLng: Float, \$endLat: Float, \$endLng: Float) {
  getDistances(startLat: \$startLat, startLng: \$startLng, endLat: \$endLat, endLng: \$endLng)
}
""";

  String updateLocation = '''
  mutation updateCompanies(\$id: Int!, \$latitude: Float!, \$longitude: Float!) {
    updateCompanies(id: \$id, latitude: \$latitude, longitude: \$longitude) {
      id
    }
  }
''';

  Future findNearbyHospitalityBusinesses(Coordinates coordinates) async {
    double latitude = coordinates.latitude;
    double longitude = coordinates.longitude;
    await initHiveForFlutter();
    GraphQLClient qlClient = await createGraphQLClient();
    QueryResult queryResult =
        await qlClient.query(QueryOptions(document: gql(getCompany), variables: {'latitude': latitude, 'longitude': longitude}));
    if (queryResult.hasException) {
      print(queryResult.exception.toString());
    }
    return queryResult.data!['companies'] as List<dynamic>;
  }

  Future calculateDistances(double businessLatitude, double businessLongitude, double startLatitude, double startLongitude) async {
    await initHiveForFlutter();
    GraphQLClient qlClient = await createGraphQLClient();
    QueryResult queryResult = await qlClient.query(QueryOptions(
        document: gql(getDistance),
        variables: {'startLat': startLatitude, 'startLng': startLongitude, 'endLat': businessLatitude, 'endLng': businessLongitude}));
    if (queryResult.hasException) {
      print(queryResult.exception.toString());
    }
    return queryResult.data!['getDistances'];
  }

  Future updateHospitalityBusinessesLocations(int id, double lat, double lng) async {
    try {
      await initHiveForFlutter();
      GraphQLClient qlClient = await createGraphQLClient();

      final MutationOptions options = MutationOptions(
        document: gql(updateLocation),
        variables: {'id': id, 'latitude': lat, 'longitude': lng},
      );

      final QueryResult result = await qlClient.mutate(options);

      if (result.hasException) {
        throw result.exception!;
      }

      // handle the result of the mutation
      return result.data;
    } catch (e) {
      // handle any errors that occur
      print(e.toString());
    }
  }

  Future createGraphQLClient() async {
    final url = dotenv.env['URL_SERVER']!;
    Link link = HttpLink(url);

    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
    return qlClient;
  }
}
