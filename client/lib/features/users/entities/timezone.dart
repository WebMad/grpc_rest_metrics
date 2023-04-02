import 'package:freezed_annotation/freezed_annotation.dart';

part 'timezone.freezed.dart';
part 'timezone.g.dart';

@freezed
class Timezone with _$Timezone {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Timezone({
    required String offset,
    required String description,
  }) = _Timezone;

  factory Timezone.fromJson(Map<String, dynamic> json) =>
      _$TimezoneFromJson(json);
}
