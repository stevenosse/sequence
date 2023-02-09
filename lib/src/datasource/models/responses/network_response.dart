import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';

@freezed
class NetworkResponse<D, E> with _$NetworkResponse {
  factory NetworkResponse.success(D data) = _Success;

  factory NetworkResponse.error(E error) = _Error;
}
