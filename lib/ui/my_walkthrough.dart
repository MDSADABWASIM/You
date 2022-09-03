import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:you/commons/colors.dart';
import 'package:you/ui/home.dart';

class MyWalkthrough extends StatelessWidget {
  final List<OnbordingData> list = [
    OnbordingData(
      titleText: Text("What internet knows about you?",style:TextStyle(fontSize:20)),
      descText: Text("see your private data",style:TextStyle(fontSize:16)),
      image: AssetImage('assets/image/fwatch.jpg'),
    ),
    OnbordingData(
      titleText: Text("How they gather your data, for ads",style:TextStyle(fontSize:20)),
      descText: Text("You can stop them.",style:TextStyle(fontSize:16)),
      image: AssetImage('assets/image/iwatch.jpg'),
    ),
    OnbordingData(
      titleText: Text("Prevent them from keeping your data",style:TextStyle(fontSize:20)),
      descText:
          Text("You can delete the data and can turn off personalization",style:TextStyle(fontSize:16)),
      image: AssetImage('assets/image/mob.jpg'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      onbordingDataList: list,
      colors: [
        //list of colors for per pages
        Colors.white,
        Colors.red,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => AnimationDemoHome(),
      ),
      nextButton: Text(
        "NEXT",
        style: TextStyle(
          color: purple,
        ),
      ),
      lastButton: Text(
        "GOT IT",
        style: TextStyle(
          color: purple,
        ),
      ),
      skipButton: Text(
        "SKIP",
        style: TextStyle(
          color: purple,
        ),
      ),
      selectedDotColor: purple,
      unSelectdDotColor: Colors.grey,
    );
  }
}
