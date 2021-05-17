import 'dart:convert';

import 'package:watercontrol/reservatory.dart';
import 'package:watercontrol/webservice.dart';

class ReservatoryLevelLog {
  final String readingTime;
  final double level;
  // Reservatory reservatory;

  ReservatoryLevelLog({
    this.readingTime,
    this.level,
    // this.reservatory
  });

  factory ReservatoryLevelLog.fromJson(Map<String, dynamic> json) {
    return ReservatoryLevelLog(
      readingTime: json['readingTime'],
      level: json['level'],
      // reservatory: json['reservatory']
    );
  }

  static Resource<ReservatoryLevelLog> get one {
    return Resource(
        url: "http://flavio/watercontrol/api/reservatorylevellog/currentreservatory/1",
        parse: (response) {
          final result = jsonDecode(response.body);
          return ReservatoryLevelLog.fromJson(result);
        });
  }
}
