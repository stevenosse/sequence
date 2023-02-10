import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_ids.freezed.dart';
part 'external_ids.g.dart';

@freezed
class ExternalIds with _$ExternalIds {
  factory ExternalIds({
    String? isrc,
  }) = _ExternalIds;

  factory ExternalIds.fromJson(Map<String, dynamic> json) => _$ExternalIdsFromJson(json);
}
