import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sequence/src/core/environment.dart';

part 'recognize_request.freezed.dart';
part 'recognize_request.g.dart';

@freezed
class RecognizeRequest with _$RecognizeRequest {
  factory RecognizeRequest({
    @JsonKey(name: 'return') required String returnOutput,
    required String filePath,
  }) = _RecognizeRequest;

  factory RecognizeRequest.fromJson(Map<String, dynamic> json) => _$RecognizeRequestFromJson(json);
}

extension RecognizeRequestToFormData on RecognizeRequest {
  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      'file': await MultipartFile.fromFile(filePath),
      'api_token': Environment.auddApiToken,
    });
  }
}
