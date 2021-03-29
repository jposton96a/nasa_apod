import 'package:nasa_apod/services/nasa/service.dart';
import 'package:test/test.dart';

APODService svc;

Future main() async {
  setUp(() async {
    // Initialize APOD service for test usage
    // defaults to demo api key. May be rate limited
    svc = APODService();
  });

  test('Integration Test: Query and parse single APOD details', () async {
    var apodResponse = await svc.fetchAPOD();
    print("Got APOD /w Title: '${apodResponse.title}'");

    // Validate all required fields were populated
    var isPopulated = allOf([isNotNull, isNotEmpty]);

    // Verify relevant fields are populated.
    // Not all fields are guaranteed to be
    expect(apodResponse.title, isPopulated);
    expect(apodResponse.explanation, isPopulated);
    expect(apodResponse.date, isPopulated);
    expect(apodResponse.mediaType, isPopulated);
    expect(apodResponse.url, isPopulated);
    expect(apodResponse.hdurl, isPopulated);
  });

  test('Integration Test: Query APOD results over date range', () async {
    var queryEndDate = DateTime.now();
    var queryStartDate = DateTime.now().subtract(Duration(days: 7));

    var apodResponse = await svc.fetchAPODRange(queryStartDate, queryEndDate);
    print("Retrieved ${apodResponse.length} results");
    expect(apodResponse.length, isNonZero);
  });
}
