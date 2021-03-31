import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:nasa_apod/pages/details.dart';
import 'package:nasa_apod/services/nasa/apod.dart';

const double _cardImageHeight = 250;
const double _blurStrength = 2;
const double _blurOpacity = .3;
const Color _blurColor = Colors.black;

class APODCard extends StatelessWidget {
  final APODResult apodData;

  APODCard(this.apodData);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Card(
            elevation: 1,
            shadowColor: Colors.white,
            color: Colors.black,
            child: cardContents(context)));
  }

  Widget cardContents(BuildContext context) {
    return Container(
      height: _cardImageHeight,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(this.apodData.url),
        ),
      ),
      // ClipRect prevents blur from applying to entire card
      child: ClipRect(
        child: BackdropFilter(
          // List tile blur strength
          filter:
              ImageFilter.blur(sigmaX: _blurStrength, sigmaY: _blurStrength),
          child: ListTile(
            // List tile blur color
            tileColor: _blurColor.withOpacity(_blurOpacity),
            title: Text(this.apodData.title),
            subtitle: Text(this.apodData.date),
            trailing: IconButton(
              color: Colors.white,
              icon: Icon(Icons.play_circle_outline),
              onPressed: () => {
                Navigator.pushNamed(context, APODDetailsPage.routeName,
                    arguments: this.apodData)
              },
            ),
          ),
        ),
      ),
    );
  }
}
