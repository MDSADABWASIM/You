// The title is rendered with two overlapping text widgets that are vertically
// offset a little. It's supposed to look sort-of 3D.
import 'package:flutter/material.dart';
import 'package:you/widgets/sections.dart';

class SectionTitle extends StatelessWidget {
  static const TextStyle sectionTitleStyle = const TextStyle(
    // fontFamily: 'Raleway',
    inherit: false,
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );

  static final TextStyle sectionTitleShadowStyle = sectionTitleStyle.copyWith(
    color: const Color(0x19000000),
  );

  const SectionTitle({
    Key? key,
    required this.section,
    required this.scale,
    required this.opacity,
  })  : assert(opacity >= 0.0 && opacity <= 1.0),
        super(key: key);

  final Section section;
  final double scale;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
      child: new Opacity(
        opacity: opacity,
        child: new Transform(
          transform: new Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: new Stack(
            children: <Widget>[
              new Positioned(
                top: 4.0,
                child: new Text(section.title, style: sectionTitleShadowStyle),
              ),
              new Text(section.title, style: sectionTitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
