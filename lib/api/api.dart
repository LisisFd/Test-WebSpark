import 'package:http/http.dart' as http;

/// [http.Request] class
class Api {
  /// Url for [http.Request]
  final String _url;

  /// Using in [http.Request]
  final Map<String, String> _headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Api(this._url);

  /// Send [http.get] request and return json string [res.body]
  Future<String> get() async {
    http.Response res = await http.get(Uri.parse(_url));
    if (res.statusCode == 200 || res.statusCode == 400) {
      return res.body;
    } else {
      throw "Error ${res.statusCode}";
    }
  }

  /// Send [http.post] request using [body] and [_headers] and return json string [res.body]
  Future<String> post(String body) async {
    http.Response res =
        await http.post(Uri.parse(_url), headers: _headers, body: body);
    if (res.statusCode == 200 || res.statusCode == 400) {
      return res.body;
    } else {
      throw Exception("Error ${res.statusCode}");
    }
  }
}
