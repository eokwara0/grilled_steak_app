import 'dart:convert';
import 'dart:io';

import 'package:service_locator/service_locator.dart';

import 'domain/table_model.dart';
import 'package:http/http.dart' as http;

class ReservationRepository {
  final SecureStorage _ss = sl<SecureStorage>();

  Future<List<TableReservation>?> getAllTable() async {
    List<TableReservation> tables = [];
    final response = await http.get(
      Uri.parse('http://localhost:3000/table'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> listOfTable = List.of(jsonDecode(response.body));

      listOfTable.forEach(
        (table) {
          tables.add(
            TableReservation.fromJson(table),
          );
        },
      );

      if (tables.isEmpty) {
        return null;
      }
      return tables;
    }

    return null;
  }

  Future<List<TableReservation>?> getAvailableTables() async {
    List<TableReservation> tables = [];

    final response = await http.get(
      Uri.parse('http://localhost:3000/table/available'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> listOfTable = List.of(jsonDecode(response.body));

      listOfTable.forEach(
        (table) {
          tables.add(
            TableReservation.fromJson(table),
          );
        },
      );

      if (tables.isEmpty) {
        return [];
      }
      return tables;
    }

    return null;
  }

  Future<List<TableReservation>?> getReservedTables() async {
    List<TableReservation> tables = [];

    final response = await http.get(
      Uri.parse('http://localhost:3000/table/reserved'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> listOfTable = List.of(jsonDecode(response.body));

      listOfTable.forEach(
        (table) {
          tables.add(
            TableReservation.fromJson(table),
          );
        },
      );

      if (tables.isEmpty) {
        return [];
      }
      return tables;
    }

    return null;
  }

  Future<bool> updateReservation(String id, TableReservation table) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/table/reservation/${id}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
      body: jsonEncode(
        table.toJson(),
      ),
    );

    if (response.statusCode == HttpStatus.accepted) {
      return true;
    }
    return false;
  }
}
