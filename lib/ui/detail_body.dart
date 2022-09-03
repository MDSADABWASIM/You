
import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/material.dart';
import 'package:you/widgets/wave_clipper.dart';

class DetailBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color? color;
  final String image;

  DetailBody(
      {Key? key,
      required this.image,
      required this.size,
      required this.xOffset,
      required this.yOffset,
      this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailBodyState();
  }
}

class _DetailBodyState extends State<DetailBody> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => ClipPath(
          child: widget.color == null
              ? Image.asset(
                  widget.image,
                  width: widget.size.width,
                  height: widget.size.height,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: widget.size.width,
                  height: widget.size.height,
                  color: widget.color,
                ),
          clipper: WaveClipper(animationController.value, animList1),
        ),
      ),
    );
  }
}
