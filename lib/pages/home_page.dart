import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);
  AnimationController? _starIconAnimationControler;

  @override
  void initState() {
    super.initState();
    _starIconAnimationControler = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );
    _starIconAnimationControler!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _pageBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _circularAnimationButton(),
              _starIcon(),
            ],
          )
        ],
      ),
    ));
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      curve: Curves.easeInOutCubicEmphasized,
      duration: Duration(seconds: 1),
      builder: (_context, _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
          onTap: () {
            setState(() {
              _buttonRadius += _buttonRadius == 200 ? -100 : 100;
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 2), //time animation takes to complete
            curve: Curves.bounceOut,
            height: _buttonRadius, //size of object
            width: _buttonRadius, //size of object
            decoration: BoxDecoration(
              color: Colors.purple, //colour
              borderRadius:
                  BorderRadius.circular(_buttonRadius), //makes it a circle
            ),
            child: const Center(
              child: Text(
                "Basic",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starIconAnimationControler!.view,
      builder: (_buildContext, _child){
        return Transform.rotate(
          angle: _starIconAnimationControler!.value * 2 * pi,
          child: _child,
          );
      },
      child: const Icon(
      Icons.star,
      size: 100,
      color: Colors.white,
    ),
    );
  }
}
