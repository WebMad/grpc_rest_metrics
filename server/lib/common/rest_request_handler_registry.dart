import 'package:server/common/rest_request_handler.dart';
import 'package:server/features/file/file_rest_request_handler.dart';
import 'package:server/features/greeting/greeting_rest_request_handler.dart';
import 'package:server/features/users/users_rest_request_handler.dart';

class RestRequestHandlerRegistry {
  final Map<String, RestRequestHandler> _handlers = {
    '/greeting': GreetingRestRequestHandler(),
    '/users': UsersRestRequestHandler(),
    '/file': FileRestRequestHandler(),
  };

  RestRequestHandler? getHandler(String path) => _handlers[path];
}
