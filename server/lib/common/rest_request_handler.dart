import 'dart:io';

abstract class RestRequestHandler {
  Future<void> handleRequest(HttpRequest request);
}
