// Support snapping scrolls to the midScrollOffset: the point at which the
// app bar's height is _kAppBarMidHeight and only one section heading is
// visible.
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SnappingScrollPhysics extends ClampingScrollPhysics {
  const SnappingScrollPhysics({
    ScrollPhysics? parent,
    required this.midScrollOffset,
  }) : super(parent: parent);

  final double midScrollOffset;

  @override
  SnappingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnappingScrollPhysics(
        parent: buildParent(ancestor) ?? ScrollPhysics(),
        midScrollOffset: midScrollOffset);
  }

  Simulation _toMidScrollOffsetSimulation(double offset, double dragVelocity) {
    final double velocity = math.max(dragVelocity, minFlingVelocity);
    return ScrollSpringSimulation(spring, offset, midScrollOffset, velocity,
        tolerance: tolerance);
  }

  Simulation _toZeroScrollOffsetSimulation(double offset, double dragVelocity) {
    final double velocity = math.max(dragVelocity, minFlingVelocity);
    return ScrollSpringSimulation(spring, offset, 0.0, velocity,
        tolerance: tolerance);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double dragVelocity) {
    final Simulation? simulation =
        super.createBallisticSimulation(position, dragVelocity);
    final double offset = position.pixels;

    if (simulation != null) {
      // The drag ended with sufficient velocity to trigger creating a simulation.
      // If the simulation is headed up towards midScrollOffset but will not reach it,
      // then snap it there. Similarly if the simulation is headed down past
      // midScrollOffset but will not reach zero, then snap it to zero.
      final double simulationEnd = simulation.x(double.infinity);
      if (simulationEnd >= midScrollOffset) return simulation;
      if (dragVelocity > 0.0)
        return _toMidScrollOffsetSimulation(offset, dragVelocity);
      if (dragVelocity < 0.0)
        return _toZeroScrollOffsetSimulation(offset, dragVelocity);
    } else {
      // The user ended the drag with little or no velocity. If they
      // didn't leave the offset above midScrollOffset, then
      // snap to midScrollOffset if they're more than halfway there,
      // otherwise snap to zero.
      final double snapThreshold = midScrollOffset / 2.0;
      if (offset >= snapThreshold && offset < midScrollOffset)
        return _toMidScrollOffsetSimulation(offset, dragVelocity);
      if (offset > 0.0 && offset < snapThreshold)
        return _toZeroScrollOffsetSimulation(offset, dragVelocity);
    }
    if (dragVelocity.abs() < .0003) {
      return null;
    }
    return simulation!;
  }
}
