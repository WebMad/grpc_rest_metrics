import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_response.freezed.dart';
part 'file_response.g.dart';

@freezed
class FileResponse with _$FileResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory FileResponse({
    required int size,
    required String requestCreatedAt,
  }) = _FileResponse;

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);
}
