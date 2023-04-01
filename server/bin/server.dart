import 'package:server/grpc_server.dart';
import 'package:server/json_rest_server.dart';

void main(List<String> arguments) {
  const host = '127.0.0.1';

  grpcServer(host: host, port: 50051);
  jsonRestServer(host: host, port: 8080);
}
