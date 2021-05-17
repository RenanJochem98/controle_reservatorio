class Reservatory {
  final int id;
  final String name;
  final bool active;
  final double maxLevelValue;


  Reservatory({
    this.id,
    this.name,
    this.active,
    this.maxLevelValue,
  });

  factory Reservatory.fromJson(Map<String, dynamic> json) {
    return Reservatory(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      maxLevelValue: json['maxLevelValue'],
    );
  }
}