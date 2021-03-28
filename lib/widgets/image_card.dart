import 'package:flutter/material.dart';

import '../services/nasa/apod.dart';

class APODCard extends StatelessWidget {
  final APODResult apodData;

  APODCard(this.apodData);

  readMoreAction() {
    print("The user wants to know more!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Card(elevation: 1, child: cardContents()));
  }

  Widget cardContents() {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text(this.apodData.title),
            subtitle: Text(this.apodData.date)),
        Image.network(this.apodData.url),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: readMoreAction, child: Text("Read More"))
          ],
        ),
      ],
    );
  }
}
