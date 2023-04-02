import 'package:grpc/grpc.dart';
import 'package:server/features/file/file_grpc_service_impl.dart';
import 'package:server/features/greeting/greeting_grpc_service_impl.dart';
import 'package:server/features/users/users_grpc_service_impl.dart';

Future<void> grpcServer({required String host, required int port}) async {
  final server = Server([
    UsersGrpcServiceImpl(),
    GreetingGrpcServiceImpl(),
    FileGrpcServiceImpl(),
  ]);

  await server.serve(
    address: host,
    port: port,
    shared: true,
    security: ServerLocalCredentials(),
  );
  print('Grpc server listening on port ${server.port}...');
}
