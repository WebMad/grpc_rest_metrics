import 'package:grpc/grpc.dart';
import 'package:server/features/users/protos/users.pbgrpc.dart';

class UsersGrpcServiceImpl extends UsersServiceBase {
  @override
  Future<GetUsersResponse> getUser(
      ServiceCall call, GetUsersRequest request) async {
    final requestAcceptedAt = DateTime.now().microsecondsSinceEpoch.toString();

    return GetUsersResponse(
      count: request.users.length,
      requestCreatedAt: request.requestCreatedAt,
      requestAcceptedAt: requestAcceptedAt,
      responseCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    );
  }
}
