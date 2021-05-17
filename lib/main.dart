// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:watercontrol/reservatory.dart';
import 'package:watercontrol/reservatoryLevelLog.dart';
import 'package:watercontrol/webservice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de reservatórios',
      home: Scaffold(
        body: Center(
          child: ReservatoriesList(),
        ),
      ),
    );
  }
}

class ReservatoriesList extends StatefulWidget {
  @override
  _ReservatoriesListState createState() => _ReservatoriesListState();
}

class _ReservatoriesListState extends State<ReservatoriesList> {
  var _reservatories = <Reservatory>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _populateReservatories();
  }

  void _populateReservatories() {
    Webservice().load(Reservatory.all).then((reservatories) => {
          setState(() => {_reservatories = reservatories})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de reservatórios'),
      ),
      body: _buildReservatories(),
    );
  }

  Widget _buildReservatories() {
    return ListView.builder(
      itemCount: _reservatories.length,
      itemBuilder: _buildItemsForListView,
    );
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    Reservatory reservatory = _reservatories[index];
    return ListTile(
        title: Text(reservatory.name, style: _biggerFont),
        onTap: () {
          _pushReservatoryDetails(reservatory);
        });
  }

  void _pushReservatoryDetails(Reservatory reservatory) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Detalhes do reservatório'),
              ),
              body: ReservatoryDetail(reservatory: reservatory));
        },
      ),
    );
  }
}

class ReservatoryDetail extends StatefulWidget {
  final Reservatory reservatory;

  const ReservatoryDetail({Key key, this.reservatory}) : super(key: key);

  @override
  _ReservatoryDetailState createState() =>
      _ReservatoryDetailState(this.reservatory);
}

class _ReservatoryDetailState extends State<ReservatoryDetail> {
  final Reservatory _reservatory;
  ReservatoryLevelLog _reservatoryLevelLog = ReservatoryLevelLog();

  _ReservatoryDetailState(this._reservatory);

  @override
  void initState() {
    super.initState();
    _populateCurrentReservatoryLevel();
  }

  void _populateCurrentReservatoryLevel() {
    Webservice()
        .load(ReservatoryLevelLog.current(_reservatory.id))
        .then((reservatoryLevelLog) => {
              setState(() => {_reservatoryLevelLog = reservatoryLevelLog})
            });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(title: Center(child: Text(_reservatory.name))),
          ListTile(
            title: Text('Volume Reservatório: ${_reservatoryLevelLog.level}%',
                style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(
              Icons.data_usage,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text(
                'Última atualização: ${_reservatoryLevelLog.formattedReadingTime}'),
            leading: Icon(
              Icons.access_time_rounded,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    );
  }
}
