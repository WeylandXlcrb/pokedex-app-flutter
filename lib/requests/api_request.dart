import 'package:http/http.dart' as http;
import 'package:pokedex_app/exceptions/http_exception.dart';

abstract class ApiRequest {
  static const defaultSuccessCodes = [200, 201];

  // Destination URI
  Uri get uri;

  /// if set, will be used to check response status, otherwise
  /// [defaultSuccessCodes] is used
  List<int>? successCodes;

  /// Will be set after request is made
  http.Response? response;

  List<int> get _successCodes => successCodes ?? defaultSuccessCodes;

  Future<http.Response> request();

  /// Returns body of successful request, otherwise throws [HttpException]
  Future<String> send() async {
    final res = await request();

    response = res;

    if (!_successCodes.contains(res.statusCode)) {
      throw HttpException(
        statusCode: res.statusCode,
        message: res.toString(),
      );
    }

    return res.body;
  }
}
