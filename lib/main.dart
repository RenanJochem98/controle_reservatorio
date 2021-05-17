// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:watercontrol/reservatory.dart';
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
            body:  Card(
              child: Column(
                children: [
                  Divider(),
                  ListTile(
                    title: Text('Volume Reservatório: 50%',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.data_usage,
                      color: Colors.blue[500],
                    ),
                  ),
                  ListTile(
                    title: Text('Última atualização: 202020' ),
                    leading: Icon(
                      Icons.access_time_rounded,
                      color: Colors.blue[500],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
