import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:service_locator/service_locator.dart';

import 'model/bill_model.dart';

class BillingRepository {
  final http.Client client;
  final SecureStorage _ss = sl<SecureStorage>();

  BillingRepository({http.Client? httpClient})
      : client = httpClient ?? http.Client();

  Future<bool> addBill(Bill bill) async {
    final response = await client.post(
      Uri.parse('http://localhost:3000/billing'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
      body: jsonEncode(bill.toJson()),
    );

    if (response.statusCode == HttpStatus.accepted) {
      return true;
    }
    return false;
  }

  Future<List<Bill>?> getBills() async {
    List<Bill> billList = [];
    final response = await client.get(
      Uri.parse('http://localhost:3000/billing'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> bills = jsonDecode(response.body);

      for (dynamic bill in bills) {
        final realBill = Bill.fromJson(bill);
        billList.add(realBill);
      }
      return billList;
    }
    return null;
  }
}
