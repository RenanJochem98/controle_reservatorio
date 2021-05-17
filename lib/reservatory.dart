import 'dart:convert';

import 'package:watercontrol/webservice.dart';

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

  static Resource<List<Reservatory>> get all {
    return Resource(
        url: "http://flavio/watercontrol/api/reservatory",
        parse: (response) {
          final result = jsonDecode(response.body);
          Iterable list = result['reservatories'];
          return list.map((model) => Reservatory.fromJson(model)).toList();
        });
  }
}
