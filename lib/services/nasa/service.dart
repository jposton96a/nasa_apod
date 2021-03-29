import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apod.dart';

const APIBaseURL = "api.nasa.gov";
const APIQueryPath = "planetary/apod";

class APODService {
  final String apiKey;
  APODService({this.apiKey = "DEMO_KEY"});

  Future<APODResult> fetchAPOD(
      {DateTime date, bool requestThumbs = false}) async {
    // Generate query to API service
    var query = APODQuery(apiKey, date: date, thumbs: requestThumbs);

    // Throws http failure
    final response = await http
        .get(Uri.https(APIBaseURL, APIQueryPath, query.toQueryParams()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return APODResult.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load pic of the day');
    }
  }

  Future<List<APODResult>> fetchAPODRange(DateTime start, DateTime end,
      {bool requestThumbs = true}) async {
    // Generate query to API service
    var query = APODQuery(apiKey,
        startDate: start, endDate: end, thumbs: requestThumbs);

    var queryUrl = Uri.https(APIBaseURL, APIQueryPath, query.toQueryParams());
    print(queryUrl.toString());
    final response = await http.get(queryUrl);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> rawJsonArray = json.decode(response.body);
      return rawJsonArray
          .map((jsonElem) => APODResult.fromJson(jsonElem))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load APOD over provided date range');
    }
  }
}
