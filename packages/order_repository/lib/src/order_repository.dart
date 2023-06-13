import 'dart:convert';
import 'dart:io';

import 'package:service_locator/service_locator.dart';

import 'package:http/http.dart' as http;

import 'model/order_model.dart';

class OrderRepository {
  final SecureStorage _ss = sl<SecureStorage>();
  final http.Client client;

  OrderRepository({http.Client? cli}) : client = cli ?? http.Client();

  Future<bool> placeOrder(Order order) async {
    final response =
        await client.post(Uri.parse('http://192.168.0.252:3000/order'),
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

    final response = await client.get(
      Uri.parse('http://192.168.0.252:3000/order/orders/$id'),
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
    final response = await client.get(
      Uri.parse('http://192.168.0.252:3000/order/$id'),
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
    final response = await client.put(
      Uri.parse('http://192.168.0.252:3000/order/ready/$id'),
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

  Future<bool> closeId(String id) async {
    final response = await client.put(
      Uri.parse('http://192.168.0.252:3000/order/close/$id'),
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
    final response = await client.put(
      Uri.parse('http://192.168.0.252:3000/order/cancel/$id'),
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

    final response = await client.get(
      Uri.parse('http://192.168.0.252:3000/order/preparing'),
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
}
