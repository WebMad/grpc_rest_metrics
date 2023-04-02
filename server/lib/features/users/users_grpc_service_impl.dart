import 'package:grpc/grpc.dart';
import 'package:server/features/users/protos/users.pbgrpc.dart';

class UsersGrpcServiceImpl extends UsersServiceBase {
  @override
  Future<GetUsersResponse> getUser(
      ServiceCall call, GetUsersRequest request) async {
    return GetUsersResponse(
      count: request.users.length,
      requestCreatedAt: request.requestCreatedAt,
    );
  }
}
