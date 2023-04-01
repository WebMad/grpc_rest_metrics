import 'package:freezed_annotation/freezed_annotation.dart';

part 'street.freezed.dart';
part 'street.g.dart';

@freezed
class Street with _$Street {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Street({
    required int number,
    required String name,
  }) = _Street;

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);
}
