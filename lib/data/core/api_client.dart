import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/data/core/unauthorised_exception.dart';

class ApiClient{
  final http.Client _client;
  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async{
    final fullPath = getPath(path, params);
    final response = await _client.get(
      Uri.parse(fullPath),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if(response.statusCode >= 200 && response.statusCode < 300){
      return json.decode(response.body);
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, {Map<dynamic,dynamic>? params}) async{
    final response = await _client.post(
        Uri.parse(getPath(path, params!)),
      body: params != null ? jsonEncode(params) : null,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode >= 200 && response.statusCode < 300){
      return json.decode(response.body);
    }else if(response.statusCode == 401){
      throw UnauthorisedException();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    Request request = Request('DELETE', Uri.parse(getPath(path, null)));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => Response.fromStream(value),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }
    return '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString';
  }
}

