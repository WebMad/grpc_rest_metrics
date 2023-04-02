import 'package:grpc/grpc.dart';
import 'package:server/features/greeting/protos/greeting.pbgrpc.dart';

class GreetingGrpcServiceImpl extends GreetingServiceBase {
  @override
  Future<GreetingResponse> greeting(
    ServiceCall call,
    GreetingRequest request,
  ) async {
    return GreetingResponse(
      greeting: "Hello, ${request.name}",
      requestCreatedAt: request.requestCreatedAt,
    );
  }
}
