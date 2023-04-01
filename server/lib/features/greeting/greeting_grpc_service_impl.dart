import 'package:grpc/grpc.dart';
import 'package:server/features/greeting/protos/greeting.pbgrpc.dart';

class GreetingGrpcServiceImpl extends GreetingServiceBase {
  @override
  Future<GreetingResponse> getUser(
    ServiceCall call,
    GreetingRequest request,
  ) async {
    final requestAcceptedAt = DateTime.now().microsecondsSinceEpoch.toString();

    return GreetingResponse(
      greeting: "Hello, ${request.name}",
      requestCreatedAt: request.requestCreatedAt,
      requestAcceptedAt: requestAcceptedAt,
      responseCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    );
  }
}
