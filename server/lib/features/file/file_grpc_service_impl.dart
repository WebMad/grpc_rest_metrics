import 'package:grpc/grpc.dart';
import 'package:server/features/file/protos/file.pbgrpc.dart';

class FileGrpcServiceImpl extends FileServiceBase {
  @override
  Future<FileResponse> file(ServiceCall call, FileRequest request) async {
    return FileResponse(
      size: request.file.length,
      requestCreatedAt: request.requestCreatedAt,
    );
  }
}
