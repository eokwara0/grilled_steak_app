import 'dart:convert';

import '../response_model/response.dart';
import 'request_model.dart';
import 'package:http/http.dart' as http;

class GetRequest extends Request {
  GetRequest({
    required super.uri,
    super.body,
    super.headers,
  });

  @override
  Future<Response> request() async {
    final response = await http.get(
      super.uri,
      headers: super.headers,
    );

    // response object
    return Response(
      statusCode: response.statusCode,
      resBody: jsonDecode(response.body),
    );
  }
}
