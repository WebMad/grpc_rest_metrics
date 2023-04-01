import 'dart:io';

import 'package:server/common/rest_request_handler_registry.dart';

Future<void> jsonRestServer({required String host, required int port}) async {
  final server = await HttpServer.bind(host, port);

  server.listen((HttpRequest request) async {
    final handlerRegistry = RestRequestHandlerRegistry();

    handlerRegistry.getHandler(request.uri.path)?.handleRequest(request);

    request.response.close();
  });

  print('Http server listening on port ${server.port}...');
}
