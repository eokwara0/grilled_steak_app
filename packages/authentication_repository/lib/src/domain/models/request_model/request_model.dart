import '../response_model/response.dart';

abstract class Request {
  late final Uri _uri;
  late final Map<String, String>? _body;
  late final Map<String, String>? _headers;

  Request({
    required Uri uri,
    Map<String, String>? body,
    Map<String, String>? headers,
  })  : _uri = uri,
        _body = body,
        _headers = headers;

  Future<Response> request();

  // uri
  get uri => _uri;

  // body
  get body => _body;

  // headers
  get headers => _headers;
}
