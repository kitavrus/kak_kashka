import 'package:http/http.dart' as http;

class HttpApiClient {
  Future<http.Response> get(String endPoint) async {
    // {Map<String, String>? headers}
    return http.get(
      Uri.parse(endPoint),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<http.Response> post(String endPoint, Object? body) async {
    return http.post(
      Uri.parse(endPoint),
      body: body,
    );
  }
}
