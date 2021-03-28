import 'dart:io';

import 'package:flutter/material.dart';

import '../services/nasa/apod.dart';
import '../services/nasa/service.dart';
import '../widgets/image_card.dart';

class APODFeedPage extends StatefulWidget {
  static const routeName = '/feed';

  APODFeedPage({Key key}) : super(key: key);

  final title = "Astronomy Picture of the Day";

  @override
  _APODFeedPageState createState() => _APODFeedPageState();
}

class _APODFeedPageState extends State<APODFeedPage> {
  Future<APODResult> futureAPOD;

  @override
  void initState() {
    super.initState();
    futureAPOD = fetchAPOD();
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
                child: FutureBuilder<APODResult>(
                  future: this.futureAPOD,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return APODCard(snapshot.data);
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
