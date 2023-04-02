import 'package:client/features/users/entities/coordinates.dart';
import 'package:client/features/users/entities/street.dart';
import 'package:client/features/users/entities/timezone.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Location({
    required Street street,
    required String city,
    required String state,
    required String country,
    required int postcode,
    required Coordinates coordinates,
    required Timezone timezone,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
