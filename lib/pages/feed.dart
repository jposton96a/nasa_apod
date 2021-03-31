import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:nasa_apod/services/nasa/apod.dart';
import 'package:nasa_apod/services/nasa/service.dart';
import 'package:nasa_apod/widgets/image_card.dart';

// Enable text-only mode on feed page
// TODO: Move to flutter configuration
const DEBUG_FEED_TEXT = false;

// API Key required to access api.nasa.gov
// Can be provided through environment variables by setting this key
const ENV_API_KEY = "NASA_API_KEY";

class APODFeedPage extends StatefulWidget {
  static const routeName = '/feed';
  final title = "Astronomy Picture of the Day";

  APODFeedPage({Key key}) : super(key: key);

  @override
  _APODFeedPageState createState() => _APODFeedPageState();
}

class _APODFeedPageState extends State<APODFeedPage> {
  // # of days to load for each page
  static const int pageSize = 10;

  /// Pre-Load next page when rendering within the [pageBuffer] range of page end.
  /// Inclusive days
  static const int pageBuffer = 3;

  DateTime rangeStart;
  DateTime rangeEnd;

  List<APODResult> _apodList;
  APODService _svc;

  bool _loading;
  Exception _exception;

  @override
  void initState() {
    super.initState();
    _apodList = [];
    _svc = APODService(apiKey: env[ENV_API_KEY]);
    _loadPage();
  }

  Future<void> _loadPage() {
    _loading = true;
    _exception = null;

    if (this._apodList.length == 0) {
      this.rangeStart = DateTime.now();
      this.rangeEnd = rangeStart.subtract(Duration(days: pageSize - 1));
      return _loadAPODRange(rangeEnd, rangeStart);
    } else {
      // Effectively rangeEnd, but actual value extracted from end of list.
      var lastDate = DateTime.parse(_apodList.last.date);
      this.rangeEnd = lastDate.subtract(Duration(days: pageSize));

      // Exclude entry from end of last page
      return _loadAPODRange(
          this.rangeEnd, lastDate.subtract(Duration(days: 1)));
    }
  }

  Future<void> _loadAPODRange(DateTime start, DateTime end) async {
    print("Fetching entries within range " +
        "[${start.toString()}, ${end.toString()}]");

    // Update state when fetch completes/fails
    _svc.fetchAPODRange(start, end).then((results) {
      print("Got ${results.length} results within range " +
          "[${start.toString()}, ${end.toString()}]");
      setState(() {
        _loading = false;
        // Sort by date (first element == newest)
        results.sort((a, b) => b.date.compareTo(a.date));
        _apodList.addAll(results);
      });
    }).catchError((err) {
      print("Fetch Failed!");
      print(err);
      setState(() {
        _loading = false;
        _exception = err;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
            child: Container(
                color: Colors.black,
                constraints: BoxConstraints(minWidth: 350, maxWidth: 650),
                child: ListView.builder(
                  itemCount: _apodList.length + 1,
                  itemBuilder: buildListItem,
                ))));
  }

  Widget buildListItem(context, index) {
    // If we're at the end of the list, return a loading icon.
    if (index >= _apodList.length) {
      print("Rendering item (i=$index) past loaded list length" +
          "(${_apodList.length}). Inserting placeholder");

      return Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: this._loading
                  ? CircularProgressIndicator()
                  : IconButton(
                      icon: const Icon(Icons.error_outline),
                      onPressed: () {
                        setState(() {
                          _loadPage();
                        });
                      })));

      // If we're rendering within buffer range, start pre-loading next elements.
    } else if (!this._loading && index >= (_apodList.length - 1) - pageBuffer) {
      print("List index $index within item buffer ($pageBuffer) range " +
          "of ${_apodList.length}. Loading next page");

      _loadPage();
    }

    return !DEBUG_FEED_TEXT
        ? APODCard(_apodList[index])
        : Text("$index: ${_apodList[index].date} - ${_apodList[index].title}");
  }
}
