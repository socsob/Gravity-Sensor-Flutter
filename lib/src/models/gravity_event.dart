/// {@template GravityEvent}
/// A model that represents a gravity event with its vectors.
/// The values of all of the vectors are in SI units and representing the force of gravity along their axis.
/// The unit for the gravity force is m/s<sup>2</sup>
/// {@endtemplate}
class GravityEvent {
  /// Constructs a [GravityEvent].
  ///
  /// {@macro GravityEvent}
  const GravityEvent(
    this.x,
    this.y,
    this.z,
  );

  /// Force of gravity along the x axis. m/s2
  final double x;

  /// Force of gravity along the y axis. m/s2

  final double y;

  /// Force of gravity along the z axis. m/s2
  final double z;

  @override
  String toString() => 'GravityEvent {x: $x, y: $y, z: $z}';
}
