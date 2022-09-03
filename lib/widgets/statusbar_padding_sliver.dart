// Initially occupies the same space as the status bar and gets smaller as
// the primary scrollable scrolls upwards.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class _RenderStatusBarPaddingSliver extends RenderSliver {
  _RenderStatusBarPaddingSliver({
    required double maxHeight,
    required double scrollFactor,
  })  : assert(scrollFactor >= 1.0 && maxHeight >= 0.0),
        _maxHeight = maxHeight,
        _scrollFactor = scrollFactor;

  // The height of the status bar
  double get maxHeight => _maxHeight;
  double _maxHeight;
  set maxHeight(double value) {
    assert(maxHeight >= 0.0);
    if (_maxHeight == value) return;
    _maxHeight = value;
    markNeedsLayout();
  }

  // That rate at which this renderer's height shrinks when the scroll
  // offset changes.
  double get scrollFactor => _scrollFactor;
  double _scrollFactor;
  set scrollFactor(double value) {
    assert(scrollFactor >= 1.0);
    if (_scrollFactor == value) return;
    _scrollFactor = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final double height = (maxHeight - constraints.scrollOffset / scrollFactor)
        .clamp(0.0, maxHeight);
    geometry = SliverGeometry(
      paintExtent: math.min(height, constraints.remainingPaintExtent),
      scrollExtent: maxHeight,
      maxPaintExtent: maxHeight,
    );
  }
}

class StatusBarPaddingSliver extends SingleChildRenderObjectWidget {
  const StatusBarPaddingSliver({
    Key? key,
    required this.maxHeight,
    this.scrollFactor = 5.0,
  })  : assert(scrollFactor >= 1.0 && maxHeight >= 0.0),
        super(key: key);

  final double maxHeight;
  final double scrollFactor;

  @override
  _RenderStatusBarPaddingSliver createRenderObject(BuildContext context) {
    return _RenderStatusBarPaddingSliver(
      maxHeight: maxHeight,
      scrollFactor: scrollFactor,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderStatusBarPaddingSliver renderObject) {
    renderObject
      ..maxHeight = maxHeight
      ..scrollFactor = scrollFactor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DoubleProperty('maxHeight', maxHeight));
    description.add(DoubleProperty('scrollFactor', scrollFactor));
  }
}
