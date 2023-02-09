import 'package:freezed_annotation/freezed_annotation.dart';

import 'recognition_result.dart';

part 'recognition_response.freezed.dart';
part 'recognition_response.g.dart';

@freezed
class RecognitionResponse with _$RecognitionResponse {
  factory RecognitionResponse({
    required String status,
    RegognitionResult? result,
  }) = _RecognitionResponse;

  factory RecognitionResponse.fromJson(Map<String, dynamic> json) => _$RecognitionResponseFromJson(json);
}
