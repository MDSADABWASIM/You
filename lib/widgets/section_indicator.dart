// Small horizontal bar that indicates the selected section.
import 'package:flutter/material.dart';
import 'package:you/commons/constants.dart';

class SectionIndicator extends StatelessWidget {
  const SectionIndicator({Key? key, this.opacity = 1.0}) : super(key: key);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
      child: new Container(
        width: kSectionIndicatorWidth,
        height: 3.0,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}
