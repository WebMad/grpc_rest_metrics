import 'package:grpc/grpc.dart';
import 'package:server/features/file/protos/file.pbgrpc.dart';

class FileGrpcServiceImpl extends FileServiceBase {
  @override
  Future<FileResponse> getUser(ServiceCall call, FileRequest request) async {
    final requestAcceptedAt = DateTime.now().microsecondsSinceEpoch.toString();

    return FileResponse(
      size: request.file.length,
      requestCreatedAt: request.requestCreatedAt,
      responseCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
      requestAcceptedAt: requestAcceptedAt,
    );
  }
}
