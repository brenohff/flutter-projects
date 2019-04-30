import 'package:flutter/material.dart';
import 'package:planets/models/Planet.dart';
import 'package:planets/widgets/PlanetRow.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xFF736AB7),
        child: ListView.builder(
          itemBuilder: (context, index) => PlanetRow(planets[index]),
          itemCount: planets.length,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  /*
  CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 24),
              sliver: SliverFixedExtentList(
                itemExtent: 165,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => new PlanetRow(planets[index]),
                  childCount: planets.length,
                ),
              ),
            )
          ],
        ),
   */

  final List<Planet> planets = [
    const Planet(
      id: "1",
      name: "Mars",
      location: "Milkyway Galaxy",
      distance: "227.9m Km",
      gravity: "3.711 m/s ",
      description: "Lorem ipsum...",
      image: "assets/images/mars.png",
    ),
    const Planet(
      id: "2",
      name: "Neptune",
      location: "Milkyway Galaxy",
      distance: "54.6m Km",
      gravity: "11.15 m/s ",
      description: "Lorem ipsum...",
      image: "assets/images/neptune.png",
    ),
    const Planet(
      id: "3",
      name: "Moon",
      location: "Milkyway Galaxy",
      distance: "54.6m Km",
      gravity: "1.622 m/s ",
      description: "Lorem ipsum...",
      image: "assets/images/moon.png",
    ),
    const Planet(
      id: "4",
      name: "Earth",
      location: "Milkyway Galaxy",
      distance: "54.6m Km",
      gravity: "9.807 m/s ",
      description: "Lorem ipsum...",
      image: "assets/images/earth.png",
    ),
    const Planet(
      id: "5",
      name: "Mercury",
      location: "Milkyway Galaxy",
      distance: "54.6m Km",
      gravity: "3.7 m/s ",
      description: "Lorem ipsum...",
      image: "assets/images/mercury.png",
    ),
  ];
}
