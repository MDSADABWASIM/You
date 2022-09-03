// The card for a single section. Displays the section's gradient and background image.
import 'package:flutter/material.dart';
import 'package:you/widgets/sections.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return new Semantics(
      label: section.title,
      button: true,
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              section.leftColor,
              section.rightColor,
            ],
          ),
        ),
        child: new Image.asset(
          section.backgroundAsset,
          color: const Color.fromRGBO(255, 255, 255, 0.075),
          colorBlendMode: BlendMode.modulate,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
