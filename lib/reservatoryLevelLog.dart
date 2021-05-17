import 'dart:convert';

import 'package:watercontrol/reservatory.dart';
import 'package:watercontrol/webservice.dart';
import 'package:intl/intl.dart';

class ReservatoryLevelLog {
  final DateTime readingTime;
  final double level;
  Reservatory reservatory;

  ReservatoryLevelLog({
    this.readingTime,
    this.level,
    this.reservatory
  });

  String get formattedReadingTime {
    return this.readingTime != null ? DateFormat('dd/MM/yyyy H:m').format(this.readingTime) : "";
  }
  
  String get formattedLevel {
    return this.level != null ? NumberFormat("##0").format(this.level * 100) + "%" : "(indisponível)";
  }

  factory ReservatoryLevelLog.fromJson(Map<String, dynamic> json) {
    return ReservatoryLevelLog(
      readingTime: json['readingTime'] == null ? null : DateTime.parse(json['readingTime']),
      level: json['level'],
      reservatory: Reservatory.fromJson(json['reservatory'])
    );
  }

  static Resource<ReservatoryLevelLog> current(int id) {
    return Resource(
        url: 'http://10.0.2.2:80/watercontrol/api/reservatorylevellog/currentreservatorylevel/$id',
        parse: (response) {
          final result = jsonDecode(response.body);
          return ReservatoryLevelLog.fromJson(result);
        });
  }
}
