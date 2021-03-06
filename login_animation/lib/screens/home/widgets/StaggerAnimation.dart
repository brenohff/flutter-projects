import 'package:flutter/material.dart';
import 'package:login_animation/screens/home/widgets/AnimatedListView.dart';
import 'package:login_animation/screens/home/widgets/FadeContainer.dart';
import 'package:login_animation/screens/home/widgets/HomeTop.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;

  StaggerAnimation({@required this.controller})
      : containerGrow = CurvedAnimation(
          parent: controller,
          curve: Curves.ease,
        ),
        listSlidePosition = EdgeInsetsTween(
                begin: EdgeInsets.only(bottom: 0),
                end: EdgeInsets.only(bottom: 80))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.325,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        fadeAnimation = ColorTween(
          begin: Color.fromRGBO(247, 64, 106, 1),
          end: Color.fromRGBO(247, 64, 106, 0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.decelerate,
          ),
        );

  final Animation<double> containerGrow;
  final Animation<EdgeInsets> listSlidePosition;
  final Animation<Color> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          animation: controller,
          builder: _buildAnimation,
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            HomeTop(
              containerGrow: containerGrow,
            ),
            AnimatedListView(
              listSlidePosition: listSlidePosition,
            ),
          ],
        ),
        IgnorePointer(child: FadeContainer(fadeAnimation: fadeAnimation)),
      ],
    );
  }
}
