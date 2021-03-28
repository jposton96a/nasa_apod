import 'package:test/test.dart';
import '../../lib/services/nasa/query.dart';

void main() {
  test('Integration Test: Query APOD Demo API and parse json', () async {
    var apodResponse = await fetchAPOD();
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
}
