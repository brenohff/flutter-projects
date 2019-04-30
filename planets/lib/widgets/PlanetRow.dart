import 'package:flutter/material.dart';
import 'package:planets/contants/TextStyles.dart';
import 'package:planets/models/Planet.dart';
import 'package:planets/pages/DetailPage.dart';

class PlanetRow extends StatelessWidget {
  final Planet planet;

  PlanetRow(this.planet);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => DetailPage(planet),
            ),
          ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Stack(
          children: <Widget>[
            planetCard(),
            planetThumbnail(),
          ],
        ),
      ),
    );
  }

  Widget planetCard() {
    return Container(
      height: 125,
      margin: EdgeInsets.only(left: 46),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: planetCardContent(),
    );
  }

  Widget planetThumbnail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      alignment: FractionalOffset.centerLeft,
      child: Hero(
        tag: "planet-hero-${planet.id}",
        child: Image(
          image: AssetImage(planet.image),
          width: 92,
          height: 92,
        ),
      ),
    );
  }

  Widget planetCardContent() {
    return Container(
      margin: EdgeInsets.fromLTRB(76, 16, 16, 16),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 4),
          Text(
            planet.name,
            style: TextStyles.headerTextStyle,
          ),
          SizedBox(height: 10),
          Text(
            planet.location,
            style: TextStyles.subHeaderTextStyle,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            width: 18,
            height: 2,
            color: Color(0xff00c6ff),
          ),
          Row(
            children: <Widget>[
              _planetValue(planet.distance, "ic_distance"),
              _planetValue(planet.gravity, "ic_gravity"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _planetValue(String value, String image) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/$image.png",
            height: 12,
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyles.regularTextStyle,
          ),
        ],
      ),
    );
  }
}
