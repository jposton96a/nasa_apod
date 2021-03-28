import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'apod.dart';

const ENV_API_KEY = "NASA_API_KEY";
const APIBaseURL = "api.nasa.gov";
const APIQueryPath = "planetary/apod";
var apiKey = env[ENV_API_KEY];

Future<APODResult> fetchAPOD() async {
  final response = await http.get(
      Uri.https(APIBaseURL, APIQueryPath, APODQuery(apiKey).toQueryParams()));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return APODResult.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
