import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpClientLogger extends BaseClient {
  final Client _client;
  final JsonEncoder _encoder = const JsonEncoder.withIndent('  ');
  final JsonDecoder _decoder = const JsonDecoder();

  HttpClientLogger(this._client);

  @override
  void close() {
    _client.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request).then((StreamedResponse response) async {
      final String responseString = await response.stream.bytesToString();

      debugPrint('''
=> request: ${response.request.toString()},
=> headers: ${_encoder.convert(response.headers)},
<- statusCode: ${response.statusCode},
<- responseString: ${_encoder.convert(_decoder.convert(responseString))},
      ''');

      return StreamedResponse(
        ByteStream.fromBytes(utf8.encode(responseString)),
        response.statusCode,
        headers: response.headers,
        reasonPhrase: response.reasonPhrase,
        persistentConnection: response.persistentConnection,
        contentLength: response.contentLength,
        isRedirect: response.isRedirect,
        request: response.request,
      );
    });
  }
}
