import 'dart:convert';
import 'dart:io';

import 'package:service_locator/service_locator.dart';

import 'package:http/http.dart' as http;

import 'model/order_model.dart';

class OrderRepository {
  final SecureStorage _ss = sl<SecureStorage>();

  Future<bool> placeOrder(Order order) async {
    final response = await http.post(Uri.parse('http://localhost:3000/order'),
        headers: {
          "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
          "Content-Type": 'application/json',
        },
        body: jsonEncode(order.toJson()));

    if (response.statusCode == HttpStatus.created) return true;
    return false;
  }

  Future<List<Order>?> getOrdersByUserId(String id) async {
    List<Order> orders = [];

    final response = await http.get(
      Uri.parse('http://localhost:3000/order/orders/$id'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> dynamicOrders = jsonDecode(response.body);
      dynamicOrders.forEach((order) {
        orders.add(Order.fromJson(order));
      });
      return orders;
    }
    return null;
  }

  Future<Order?> getOrderById(String id) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/order/$id'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return Order.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> readyOrder(String id) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/order/ready/$id'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.accepted) {
      return true;
    }
    return false;
  }

  Future<bool> cancelId(String id) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/order/cancel/$id'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.accepted) {
      return true;
    }
    return false;
  }

  Future<List<Order>?> getUnprepared() async {
    List<Order> orders = [];

    final response = await http.get(
      Uri.parse('http://localhost:3000/order/unprepared'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> dynamicOrders = jsonDecode(response.body);
      dynamicOrders.forEach((order) {
        orders.add(Order.fromJson(order));
      });
      return orders;
    }
    return null;
  }
  // Future<List<TableReservation>?> getAllTable() async {
  //   List<TableReservation> tables = [];
  //   final response = await http.get(
  //     Uri.parse('http://localhost:3000/table'),
  //     headers: {
  //       "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
  //       "Content-Type": 'application/json',
  //     },
  //   );

  //   if (response.statusCode == HttpStatus.ok) {
  //     List<dynamic> listOfTable = List.of(jsonDecode(response.body));

  //     listOfTable.forEach(
  //       (table) {
  //         tables.add(
  //           TableReservation.fromJson(table),
  //         );
  //       },
  //     );

  //     // print tables
  //     print(tables);

  //     if (tables.isEmpty) {
  //       return null;
  //     }
  //     return tables;
  //   }

  //   return null;
  // }

  // Future<List<TableReservation>?> getAvailableTables() async {
  //   List<TableReservation> tables = [];

  //   final response = await http.get(
  //     Uri.parse('http://localhost:3000/table/available'),
  //     headers: {
  //       "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
  //       "Content-Type": 'application/json',
  //     },
  //   );

  //   if (response.statusCode == HttpStatus.ok) {
  //     List<dynamic> listOfTable = List.of(jsonDecode(response.body));

  //     listOfTable.forEach(
  //       (table) {
  //         tables.add(
  //           TableReservation.fromJson(table),
  //         );
  //       },
  //     );

  //     // print tables
  //     // print(tables);

  //     if (tables.isEmpty) {
  //       return [];
  //     }
  //     return tables;
  //   }

  //   return null;
  // }

  // Future<List<TableReservation>?> getReservedTables() async {
  //   List<TableReservation> tables = [];

  //   final response = await http.get(
  //     Uri.parse('http://localhost:3000/table/reserved'),
  //     headers: {
  //       "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
  //       "Content-Type": 'application/json',
  //     },
  //   );

  //   if (response.statusCode == HttpStatus.ok) {
  //     List<dynamic> listOfTable = List.of(jsonDecode(response.body));

  //     listOfTable.forEach(
  //       (table) {
  //         tables.add(
  //           TableReservation.fromJson(table),
  //         );
  //       },
  //     );

  //     // print tables
  //     // print(tables);

  //     if (tables.isEmpty) {
  //       return [];
  //     }
  //     return tables;
  //   }

  //   return null;
  // }

  // Future<bool> updateReservation(String id, TableReservation table) async {
  //   // print(jsonEncode(table.toJson()));
  //   // print(id);
  //   final response = await http.post(
  //     Uri.parse('http://localhost:3000/table/reservation/${id}'),
  //     headers: {
  //       "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
  //       "Content-Type": 'application/json',
  //     },
  //     body: jsonEncode(
  //       table.toJson(),
  //     ),
  //   );

  //   // print(response.statusCode);
  //   if (response.statusCode == HttpStatus.accepted) {
  //     return true;
  //   }
  //   return false;
  // }
}
