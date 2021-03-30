import 'package:flutter/material.dart';

import 'package:nasa_apod/services/nasa/apod.dart';

class APODDetailsPage extends StatelessWidget {
  static const routeName = '/details';

  APODDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final APODResult details = ModalRoute.of(context).settings.arguments;
    double screenHeight = MediaQuery.of(context).size.height;

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
              margin: EdgeInsets.fromLTRB(0, screenHeight, 0, 30),
              height: screenHeight * 0.85, // Kinda works but unreliable
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: APODDetailsOverlay(details: details),
            ),
          ),
        ));
  }
}

class APODDetailsOverlay extends StatelessWidget {
  static const double TitleFontSize = 30;
  static const double ExplanationFontSize = 15;

  const APODDetailsOverlay({
    Key key,
    @required this.details,
  }) : super(key: key);

  final APODResult details;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          children: <Widget>[
            Text(details.title, style: TextStyle(fontSize: TitleFontSize)),
            ListTile(
              title: Text(
                  details.copyright != null
                      ? details.copyright
                      : "copyright unknown",
                  style: TextStyle(fontStyle: FontStyle.italic)),
              subtitle: Text(
                  details.date != null ? details.date : "date unknown",
                  style: TextStyle(fontStyle: FontStyle.italic)),
              trailing: ButtonBar(
                alignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.cloud_download_outlined),
                      onPressed: () => {}),
                  IconButton(icon: Icon(Icons.fullscreen), onPressed: () => {})
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(details.explanation,
                  style: TextStyle(fontSize: ExplanationFontSize)),
            )
          ],
        ),
      ),
    );
  }
}
