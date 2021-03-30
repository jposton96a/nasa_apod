import 'dart:io';
import 'dart:convert';

import 'package:nasa_apod/services/nasa/apod.dart';
import 'package:nasa_apod/services/nasa/service.dart';
import 'package:test/test.dart';

APODService svc;

Future main() async {
  jsonResource(String filePath) async {
    var sampleSingleEntry = File(filePath);
    var jsonResponse = await sampleSingleEntry.readAsString();
    return json.decode(jsonResponse);
  }

  assertValidResult(APODResult actual) {
    // Validate all required fields were populated
    var isPopulated = allOf([isNotNull, isNotEmpty]);

    // Verify relevant fields are populated.
    // Not all fields are guaranteed to be
    expect(actual.title, isPopulated);
    expect(actual.explanation, isPopulated);
    expect(actual.date, isPopulated);
    expect(actual.mediaType, isPopulated);
    expect(actual.url, isPopulated);
    expect(actual.hdurl, isPopulated);
  }

  test('Parse single APOD result', () async {
    var res = await jsonResource("test/res/apod/single_entry.json");
    APODResult actual = APODResult.fromJson(res);
    assertValidResult(actual);
  });

  test('Parse range of APOD results', () async {
    List<dynamic> res = await jsonResource("test/res/apod/range_entries.json");
    List<APODResult> actualList =
        res.map((result) => APODResult.fromJson(result)).toList();

    expect(actualList.length, equals(11));
    actualList.map((actual) => assertValidResult(actual));
  });
}
