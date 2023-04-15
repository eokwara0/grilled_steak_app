class Response {
  // response body
  final dynamic _resBody;
  // status Code
  final int _statuscode;

  const Response({
    required dynamic resBody,
    required int statusCode,
  })  : _resBody = resBody,
        _statuscode = statusCode;

  // accessors
  get resBody => _resBody;
  get statucode => _statuscode;
}
