/* Example response from NASA APOD API:
{
    "copyright": "Bernard Miller",
    "date": "2021-03-27",
    "explanation": "Some 60 million light-years away in the southerly constellation Corvus, two large galaxies are colliding. Stars in the two galaxies, cataloged as NGC 4038 and NGC 4039, very rarely collide in the course of the ponderous cataclysm that lasts for hundreds of millions of years. But the galaxies' large clouds of molecular gas and dust often do, triggering furious episodes of star formationi near the center of the cosmic wreckage. Spanning over 500 thousand light-years, this stunning view also reveals new star clusters and matter flung far from the scene of the accident by gravitational tidal forces. The remarkably sharp ground-based image includes narrowband data that highlights the characteristic red glow of atomic hydrogen gas in star-forming regions. The suggestive overall visual appearance of the extended arcing structures gives the galaxy pair its popular name - The Antennae.",
    "hdurl": "https://apod.nasa.gov/apod/image/2103/C60-61_PS2_CROP_FULL.jpg",
    "media_type": "image",
    "service_version": "v1",
    "title": "Exploring the Antennae",
    "url": "https://apod.nasa.gov/apod/image/2103/C60-61_PS2_CROP_FULL1024.jpg"
}
*/

const String ISO_8601_SHORT = "YYYY-MM-DD";

class APODResult {
  String title;
  String explanation;
  String date;
  String mediaType;
  String url;
  String hdurl;
  String copyright;
  String serviceVersion;

  APODResult.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        explanation = json['explanation'],
        date = json['date'],
        mediaType = json['media_type'],
        url = json['url'],
        hdurl = json['hdurl'],
        copyright = json['copyright'],
        serviceVersion = json['service_version'];
}

class APODQuery {
  final String apiKey;

  DateTime date;
  DateTime startDate;
  DateTime endDate;

  int count;
  bool thumbs;

  APODQuery(this.apiKey,
      {this.date, this.startDate, this.endDate, this.count, this.thumbs});

  toQueryParams() {
    var queryMap = Map<String, dynamic>();
    queryMap["api_key"] = apiKey;
    queryMap["date"] = _toISO8601Short(date);
    queryMap["start_date"] = _toISO8601Short(startDate);
    queryMap["end_date"] = _toISO8601Short(endDate);
    queryMap["count"] = count == null ? null : count.toString();
    queryMap["thumbs"] = thumbs.toString();

    // Remove null values to ensure they don't make it into the query
    queryMap.removeWhere((key, value) {
      return key == null || value == null;
    });
    return queryMap;
  }
}

_toISO8601Short(DateTime date) {
  if (date == null) {
    return null;
  }

  return date.toIso8601String().substring(0, ISO_8601_SHORT.length);
}
