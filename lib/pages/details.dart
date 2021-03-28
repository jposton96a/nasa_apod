import 'package:flutter/material.dart';

import '../services/nasa/apod.dart';

class APODDetailsPage extends StatelessWidget {
  static const routeName = '/details';

  APODDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final APODResult details = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("APOD for ${details.date}"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          // Set APOD as background image (standard definition)
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(details.url),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              // TODO: update positioning to snap title to bottom of screen
              // Margin works as a placeholder for this feature
              margin: EdgeInsets.only(top: 500),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: APODDetailsCard(details: details),
            ),
          ),
        ));
  }
}

class APODDetailsCard extends StatelessWidget {
  static const double TitleFontSize = 30;
  static const double ExplanationFontSize = 15;
  static const TitleFont = 10;

  const APODDetailsCard({
    Key key,
    @required this.details,
  }) : super(key: key);

  final APODResult details;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          children: <Widget>[
            Text(details.title, style: TextStyle(fontSize: TitleFontSize)),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.cloud_download_outlined),
                    onPressed: () => {}),
                IconButton(icon: Icon(Icons.fullscreen), onPressed: () => {})
              ],
            ),
            Text(details.explanation,
                style: TextStyle(fontSize: ExplanationFontSize)),
          ],
        ),
      ),
    );
  }
}
