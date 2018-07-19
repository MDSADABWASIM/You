import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/walkthrough.dart';
import 'package:flutter_walkthrough/flutter_walkthrough.dart';
import 'package:you/home.dart';


class MyWalkthrough extends StatelessWidget {

 final  List<Walkthrough> list=[
 new Walkthrough(
  title:"What internet knows about you?",
  content: "see your private data",
  imageIcon: Icons.public,
  imagecolor:new Color(0xFF59007a),
),
new Walkthrough(
  title: "How they gather your data, for ads",
  content: "You can stop them.",
  imageIcon: Icons.all_inclusive,
   imagecolor:new Color(0xFF59007a),
),
new Walkthrough(
  title: "Prevent them from keeping your data",
  content: "You can delete the data and can turn off personalization",
  imageIcon: Icons.close,
   imagecolor:new Color(0xFF59007a),
),

  ];
  @override
  Widget build(BuildContext context) {
    return new IntroScreen(
      list,
      new MaterialPageRoute(builder: (context) => new AnimationDemoHome()),
    );
  }
}