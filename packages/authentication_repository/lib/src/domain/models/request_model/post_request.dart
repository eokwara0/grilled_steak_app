import 'dart:convert';

import '../response_model/response.dart';
import 'request_model.dart';
import 'package:http/http.dart' as http;

class Post extends Request {
  Post({
    required super.uri,
    required super.headers,
    required super.body,
  });

  @override
  Future<Response> request() async {
    final response = await http.post(
      super.uri,
      headers: super.headers,
      body: super.body,
    );

    return Response(
      statusCode: response.statusCode,
      resBody: jsonDecode(response.body),
    );
  }
}
