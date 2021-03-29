import 'dart:html';

import 'package:flutter/material.dart';

import 'package:nasa_apod/pages/details.dart';
import 'package:nasa_apod/services/nasa/apod.dart';

class APODCard extends StatelessWidget {
  final APODResult apodData;

  APODCard(this.apodData);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Card(elevation: 1, child: cardContents(context)));
  }

  Widget cardContents(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text(this.apodData.title),
            subtitle: Text(this.apodData.date)),
        Image.network(this.apodData.url),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => {
                      Navigator.pushNamed(context, APODDetailsPage.routeName,
                          arguments: this.apodData)
                    },
                child: Text("Read More"))
          ],
        ),
      ],
    );
  }
}
