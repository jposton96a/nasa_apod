import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../services/nasa/apod.dart';
import '../services/nasa/service.dart';
import '../widgets/image_card.dart';

const ENV_API_KEY = "NASA_API_KEY";

class APODFeedPage extends StatefulWidget {
  static const routeName = '/feed';

  APODFeedPage({Key key}) : super(key: key);

  final title = "Astronomy Picture of the Day";

  @override
  _APODFeedPageState createState() => _APODFeedPageState();
}

class _APODFeedPageState extends State<APODFeedPage> {
  Future<List<APODResult>> futureAPODList;

  @override
  void initState() {
    super.initState();
    APODService svc = APODService(apiKey: env[ENV_API_KEY]);
    futureAPODList = svc.fetchAPODRange(
        DateTime.now().subtract(Duration(days: 10)), DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Container(
                constraints: BoxConstraints(minWidth: 350, maxWidth: 650),
                child: FutureBuilder<List<APODResult>>(
                  future: this.futureAPODList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return APODCard(snapshot.data[index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("Failed to load space pix :(");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ))));
  }
}
